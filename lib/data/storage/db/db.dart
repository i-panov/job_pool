import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/schemas/companies.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';
import 'package:job_pool/data/storage/types.dart';
import 'package:job_pool/domain/models/interview.dart';
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

  Selectable<Vacancy> getFullVacancyInfo(int vacancyId) {
    final directionIds = jobDirections.id.groupConcat(separator: _separator);

    final directionNames = jobDirections.name.groupConcat(
      separator: _separator,
    );

    final contactTypes = contacts.contactType.groupConcat(
      separator: _separator,
    );

    final contactValues = contacts.contactValue.groupConcat(
      separator: _separator,
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

      final valueDirectionNames = row
          .read(directionNames)!
          .split(_separator);

      final valueContactTypes = row
          .read(contactTypes)!
          .split(_separator)
          .map(ContactTypes.values.byName);

      final valueContactValues = row
          .read(contactValues)!
          .split(_separator);

      return Vacancy(
        id: row.read(vacancies.id)!,
        link: row.read(vacancies.link)!,
        comment: row.read(vacancies.comment)!,
        grades: row.read(vacancies.grades)!,
        companyId: row.read(companies.id)!,
        companyName: row.read(companies.name)!,
        directions: IMap.fromIterables(valueDirectionIds, valueDirectionNames),
        contacts: IMap.fromIterables(valueContactTypes, valueContactValues),
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
        type: row.readWithConverter(storyItems.interviewType) as InterviewTypes,
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
