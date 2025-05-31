import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/schemas/companies.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';
import 'package:job_pool/data/storage/types.dart';
import 'package:job_pool/domain/models/interview_dto.dart';
import 'package:path_provider/path_provider.dart';

part 'db.g.dart';

@DriftDatabase(
  tables: [
    Companies,
    Contacts,
    StoryItems,
    Vacancies,
    VacancyDirections,
    InterviewStoryItems,
    WaitingForFeedbackStoryItems,
    TaskStoryItems,
    FailureStoryItems,
    OfferStoryItems,
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

  Future<Company?> getCompany(int id) {
    final query = select(companies)..where((f) => f.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<Company?> findCompanyByName(String name) {
    final query = select(companies)..where((f) => f.name.equals(name));
    return query.getSingleOrNull();
  }

  Future<List<Company>> findCompaniesLikeName(String name) {
    final query = select(companies)..where((f) => f.name.like('%$name%'));
    return query.get();
  }

  Selectable<InterviewDto> selectInterviews() {
    final directions = jobDirections.name.groupConcat(separator: _separator);

    final query = selectOnly(interviewStoryItems)
      ..join([
        innerJoin(
          storyItems,
          storyItems.id.equalsExp(interviewStoryItems.item),
        ),
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
      ..groupBy([interviewStoryItems.item])
      ..orderBy([OrderingTerm.desc(interviewStoryItems.time)])
      ..addColumns([
        interviewStoryItems.time,
        interviewStoryItems.isOnline,
        interviewStoryItems.target,
        interviewStoryItems.type,
        vacancies.id,
        companies.name,
        directions,
        vacancies.grades,
      ]);

    return query.map((row) {
      return InterviewDto(
        time: row.read(interviewStoryItems.time)!,
        isOnline: row.read(interviewStoryItems.isOnline)!,
        target: row.read(interviewStoryItems.target)!,
        type: row.readWithConverter(interviewStoryItems.type)!,
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
