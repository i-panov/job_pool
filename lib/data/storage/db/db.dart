import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/extensions.dart';
import 'package:job_pool/data/storage/schemas/companies.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';
import 'package:job_pool/data/storage/types.dart';
import 'package:job_pool/domain/models/interview.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/domain/models/vacancy.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@DriftDatabase(
  tables: [
    Companies,
    Contacts,
    StoryItems,
    Vacancies,
    VacancyDirections,
    JobDirections,
  ],
)
class AppDatabase extends _$AppDatabase {
  static const _separator = '#___SEPARATOR___#';

  static QueryExecutor _openConnection() {
    return driftDatabase(
      name: 'job_pool',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }

  AppDatabase([QueryExecutor? executor]) : super(executor ?? _openConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (Migrator m) {
      return m.createAll();
    },
    beforeOpen: (details) async {
      if (details.wasCreated) {
        await managers.jobDirections.bulkCreate(
          (o) => [
            for (var direction in JobDirections.defaults) o(name: direction),
          ],
        );
      }
    },
  );

  Future<List<int>> getVacancyDirectionIds(int vacancyId) {
    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId))
      ..orderBy([(f) => OrderingTerm.asc(f.order)]);

    return query.map((row) => row.direction).get();
  }

  Future<List<ContactDto>> getVacancyContacts(int vacancyId) {
    final query = select(contacts)..where((f) => f.vacancy.equals(vacancyId));
    return query.get();
  }

  Stream<Vacancy> watchFullVacancyInfo(int vacancyId) {
    const query =
        '''
    SELECT
      v.id, v.link, v.comment, v.grades,
      c.id AS company_id, c.name AS company_name,
      (
        SELECT GROUP_CONCAT(d.id, '$_separator')
        FROM vacancy_directions vd
        JOIN job_directions d ON d.id = vd.direction
        WHERE vd.vacancy = v.id
        ORDER BY vd."order"
      ) AS direction_ids,
      (
        SELECT GROUP_CONCAT(d.name, '$_separator')
        FROM vacancy_directions vd
        JOIN job_directions d ON d.id = vd.direction
        WHERE vd.vacancy = v.id
        ORDER BY vd."order"
      ) AS direction_names,
      (
        SELECT GROUP_CONCAT(ct.contact_type, '$_separator')
        FROM contacts ct
        WHERE ct.vacancy = v.id
        ORDER BY ct.contact_type
      ) AS contact_types,
      (
        SELECT GROUP_CONCAT(ct.contact_value, '$_separator')
        FROM contacts ct
        WHERE ct.vacancy = v.id
        ORDER BY ct.contact_type
      ) AS contact_values
    FROM vacancies v
    JOIN companies c ON c.id = v.company
    WHERE v.id = ?
  ''';

    return customSelect(
      query,
      variables: [Variable.withInt(vacancyId)],
      readsFrom: {
        vacancies,
        companies,
        vacancyDirections,
        jobDirections,
        contacts,
      },
    ).asyncMap((row) async {
      final directionIds = (row.read<String?>('direction_ids') ?? '').split(
        _separator,
      );
      final directionNames = (row.read<String?>('direction_names') ?? '').split(
        _separator,
      );
      final contactTypes = (row.read<String?>('contact_types') ?? '').split(
        _separator,
      );
      final contactValues = (row.read<String?>('contact_values') ?? '').split(
        _separator,
      );

      const converter = EnumSetType(JobGrade.values);
      final grades = converter.read(row.read<String>('grades'));

      return Vacancy(
        id: row.read<int>('id'),
        link: row.read<String>('link'),
        comment: row.read<String>('comment'),
        grades: grades,
        companyId: row.read<int>('company_id'),
        companyName: row.read<String>('company_name'),
        directions: directionNames
            .zip(
              directionIds,
              (name, id) => (id: int.tryParse(id) ?? -1, name: name),
            )
            .where((e) => e.id > 0)
            .toIList(),
        contacts: contactValues
            .zip(
              contactTypes,
              (value, type) => (
                type: ContactType.values[int.tryParse(type) ?? 0],
                value: value,
              ),
            )
            .where((e) => e.value.isNotEmpty)
            .toIList(),
      );
    }).watchSingle();
  }

  Selectable<Vacancy> getFullVacancyInfo(int vacancyId) {
    final directionIds = jobDirections.id.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(vacancyDirections.order)]),
    );

    final directionNames = jobDirections.name.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(vacancyDirections.order)]),
    );

    final contactTypes = contacts.contactType.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(contacts.contactType)]),
    );

    final contactValues = contacts.contactValue.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(contacts.contactType)]),
    );

    final query = selectOnly(vacancies)
      ..where(vacancies.id.equals(vacancyId))
      ..join([
        innerJoin(companies, companies.id.equalsExp(vacancies.company)),
        leftOuterJoin(
          vacancyDirections,
          vacancyDirections.vacancy.equalsExp(vacancies.id),
        ),
        innerJoin(
          jobDirections,
          jobDirections.id.equalsExp(vacancyDirections.direction),
        ),
        innerJoin(contacts, contacts.vacancy.equalsExp(vacancies.id)),
      ])
      ..groupBy([vacancies.id])
      ..addColumns([
        vacancies.id,
        vacancies.link,
        vacancies.comment,
        vacancies.grades,
        companies.id,
        companies.name,
        directionIds,
        directionNames,
        contactTypes,
        contactValues,
      ]);

    return query.map((row) {
      final valueDirectionIds = row
          .read(directionIds)!
          .split(_separator)
          .map(int.parse);

      final valueDirectionNames = row.read(directionNames)!.split(_separator);

      final valueContactTypes = row
          .read(contactTypes)!
          .split(_separator)
          .map(int.parse)
          .map((i) => ContactType.values[i]);

      final valueContactValues = row.read(contactValues)!.split(_separator);

      return Vacancy(
        id: row.read(vacancies.id)!,
        link: row.read(vacancies.link)!,
        comment: row.read(vacancies.comment)!,
        grades: row.read(vacancies.grades)!,
        companyId: row.read(companies.id)!,
        companyName: row.read(companies.name)!,
        directions: valueDirectionNames
            .zip(valueDirectionIds, (name, id) => (id: id, name: name))
            .toIList(),
        contacts: valueContactValues
            .zip(valueContactTypes, (value, type) => (type: type, value: value))
            .toIList(),
      );
    });
  }

  Future<VacancyDto?> getVacancy(int id) {
    final query = select(vacancies)..where((f) => f.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<CompanyDto?> getCompany(int id) {
    final query = select(companies)..where((f) => f.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<CompanyDto?> findCompanyByName(String name) {
    final query = select(companies)..where((f) => f.name.equals(name));
    return query.getSingleOrNull();
  }

  Future<List<CompanyDto>> findCompaniesLikeName(String name) {
    final query = select(companies)..where((f) => f.name.like('%$name%'));
    return query.get();
  }

  Future<int> insertInterviewStoryItem({
    required int vacancyId,
    required DateTime time,
    required bool isOnline,
    required String target,
    required InterviewType type,
  }) {
    final obj = StoryItemsCompanion.insert(
      vacancy: vacancyId,
      type: StoryItemType.interview,
      createdAt: DateTime.now(),
      commonTime: Value(time),
      interviewIsOnline: Value(isOnline),
      interviewTarget: Value(target),
      interviewType: Value(type),
    );

    return into(storyItems).insert(obj);
  }

  Selectable<StoryItem> selectVacancyStory(int vacancyId) {
    final query = select(storyItems)
      ..where((s) => s.vacancy.equals(vacancyId))
      ..orderBy([(s) => OrderingTerm.asc(s.createdAt)]);

    return query.map((item) => item.toDomain());
  }

  Selectable<Interview> selectInterviews() {
    final directions = jobDirections.name.groupConcat(separator: _separator);

    final query = selectOnly(storyItems)
      ..where(storyItems.type.equalsValue(StoryItemType.interview))
      ..join([
        innerJoin(vacancies, vacancies.id.equalsExp(storyItems.vacancy)),
        innerJoin(companies, companies.id.equalsExp(vacancies.company)),
        leftOuterJoin(
          vacancyDirections,
          vacancyDirections.vacancy.equalsExp(vacancies.id),
        ),
        innerJoin(
          jobDirections,
          jobDirections.id.equalsExp(vacancyDirections.direction),
        ),
      ])
      ..groupBy([storyItems.id])
      ..orderBy([OrderingTerm.desc(storyItems.commonTime)])
      ..addColumns([
        storyItems.commonTime,
        storyItems.interviewIsOnline,
        storyItems.interviewTarget,
        storyItems.interviewType,
        vacancies.id,
        companies.name,
        directions,
        vacancies.grades,
      ]);

    return query.map((row) {
      return Interview(
        time: row.read(storyItems.commonTime)!,
        isOnline: row.read(storyItems.interviewIsOnline)!,
        target: row.read(storyItems.interviewTarget)!,
        type: row.readWithConverter(storyItems.interviewType) as InterviewType,
        vacancyId: row.read(vacancies.id)!,
        companyName: row.read(companies.name)!,
        jobDirections: row.read(directions)!.split(_separator).toISet(),
        jobGrades: row.read(vacancies.grades)!,
      );
    });
  }

  Future<bool> setVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
    required int order,
  }) async {
    final maxOrder =
        (await _getMaxVacancyDirectionOrder(vacancyId: vacancyId)) ?? -1;

    if (order < 0 || order > maxOrder) {
      order = maxOrder + 1;
    }

    final currentOrder = await _getVacancyDirectionOrder(
      vacancyId: vacancyId,
      directionId: directionId,
    );

    if (currentOrder == null || currentOrder == order) {
      return false;
    }

    final otherDirectionId = await _getVacancyDirectionByOrder(
      vacancyId: vacancyId,
      order: order,
    );

    if (otherDirectionId == null) {
      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: directionId,
        order: order,
      );

      return true;
    }

    await transaction(() async {
      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: otherDirectionId,
        order: maxOrder + 1,
      );

      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: directionId,
        order: order,
      );

      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: otherDirectionId,
        order: currentOrder,
      );
    });

    return true;
  }

  Future<int?> _getVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
  }) async {
    final query = select(vacancyDirections)
      ..where(
        (f) => f.vacancy.equals(vacancyId) & f.direction.equals(directionId),
      );

    return await query.map((row) => row.order).getSingleOrNull();
  }

  Future<int?> _getVacancyDirectionByOrder({
    required int vacancyId,
    required int order,
  }) async {
    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId) & f.order.equals(order));

    return await query.map((row) => row.direction).getSingleOrNull();
  }

  Future<int?> _getMaxVacancyDirectionOrder({required int vacancyId}) async {
    final maxOrder = vacancyDirections.order.max();

    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId));

    return await query
        .addColumns([maxOrder])
        .map((row) => row.read(maxOrder))
        .getSingleOrNull();
  }

  Future<void> _updateVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
    required int order,
  }) async {
    final stmt = update(vacancyDirections)
      ..where(
        (f) => f.vacancy.equals(vacancyId) & f.direction.equals(directionId),
      );

    await stmt.write(VacancyDirectionsCompanion(order: Value(order)));
  }
}
