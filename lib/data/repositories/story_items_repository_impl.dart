import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/domain/models/interview.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/domain/models/task.dart';
import 'package:job_pool/domain/repositories/story_items_repository.dart';

class StoryItemsRepositoryImpl implements StoryItemsRepository {
  static const _separator = AppDatabase.separator;
  
  final AppDatabase _db;

  const StoryItemsRepositoryImpl(this._db);

  @override
  Future<void> remove(int id) async {
    await (_db.delete(_db.storyItems)..where((s) => s.id.equals(id))).go();
  }

  @override
  Future<void> insert(int vacancyId, StoryItemData data) {
    return _db.into(_db.storyItems).insert(StoryItemsCompanion.insert(
      createdAt: DateTime.now(),
      vacancy: vacancyId,
      type: data.dtoType,
      commonTime: Value.absentIfNull(switch (data) {
        InterviewStoryItemData d => d.time,
        WaitingForFeedbackStoryItemData d => d.time,
        _ => null,
      }),
      commonComment: Value.absentIfNull(switch (data) {
        WaitingForFeedbackStoryItemData d => d.comment,
        FailureStoryItemData d => d.comment,
        _ => null,
      }),
      taskLink: Value.absentIfNull(switch (data) {
        TaskStoryItemData d => d.link,
        _ => null,
      }),
      taskDeadline: Value.absentIfNull(switch (data) {
        TaskStoryItemData d => d.deadline,
        _ => null,
      }),
      offerSalary: Value.absentIfNull(switch (data) {
        OfferStoryItemData d => d.salary,
        _ => null,
      }),
    ));
  }

  @override
  Selectable<StoryItem> selectVacancyStory(int vacancyId) {
    final query = _db.select(_db.storyItems)
      ..where((s) => s.vacancy.equals(vacancyId))
      ..orderBy([(s) => OrderingTerm.asc(s.createdAt)]);

    return query.map((item) => item.toDomain());
  }

  @override
  Selectable<Interview> selectInterviews() {
    final directions = _db.jobDirections.name.groupConcat(separator: _separator);

    final query = _db.selectOnly(_db.storyItems)
      ..where(_db.storyItems.type.equalsValue(StoryItemType.interview))
      ..join([
        innerJoin(_db.vacancies, _db.vacancies.id.equalsExp(_db.storyItems.vacancy)),
        innerJoin(_db.companies, _db.companies.id.equalsExp(_db.vacancies.company)),
        leftOuterJoin(
          _db.vacancyDirections,
          _db.vacancyDirections.vacancy.equalsExp(_db.vacancies.id),
        ),
        innerJoin(
          _db.jobDirections,
          _db.jobDirections.id.equalsExp(_db.vacancyDirections.direction),
        ),
      ])
      ..groupBy([_db.storyItems.id])
      ..orderBy([OrderingTerm.desc(_db.storyItems.commonTime)])
      ..addColumns([
        _db.storyItems.commonTime,
        _db.storyItems.interviewIsOnline,
        _db.storyItems.interviewTarget,
        _db.storyItems.interviewType,
        _db.vacancies.id,
        _db.companies.name,
        directions,
        _db.vacancies.grades,
      ]);

    return query.map((row) {
      return Interview(
        time: row.read(_db.storyItems.commonTime)!,
        isOnline: row.read(_db.storyItems.interviewIsOnline)!,
        target: row.read(_db.storyItems.interviewTarget)!,
        type: row.readWithConverter(_db.storyItems.interviewType) as InterviewType,
        vacancyId: row.read(_db.vacancies.id)!,
        companyName: row.read(_db.companies.name)!,
        jobDirections: row.read(directions)!.split(_separator).toISet(),
        jobGrades: row.read(_db.vacancies.grades)!,
      );
    });
  }

  @override
  Selectable<Task> selectTasks() {
    final directions = _db.jobDirections.name.groupConcat(separator: _separator);

    final query = _db.selectOnly(_db.storyItems)
      ..where(_db.storyItems.type.equalsValue(StoryItemType.task))
      ..join([
        innerJoin(_db.vacancies, _db.vacancies.id.equalsExp(_db.storyItems.vacancy)),
        innerJoin(_db.companies, _db.companies.id.equalsExp(_db.vacancies.company)),
        leftOuterJoin(
          _db.vacancyDirections,
          _db.vacancyDirections.vacancy.equalsExp(_db.vacancies.id),
        ),
        innerJoin(
          _db.jobDirections,
          _db.jobDirections.id.equalsExp(_db.vacancyDirections.direction),
        ),
      ])
      ..orderBy([OrderingTerm.desc(_db.storyItems.createdAt)])
      ..groupBy([_db.storyItems.id])
      ..addColumns([
        _db.storyItems.taskLink,
        _db.storyItems.taskDeadline,
        _db.storyItems.createdAt,
        _db.vacancies.id,
        _db.companies.name,
        directions,
      ]);

    return query.map((row) {
      return Task(
        link: row.read(_db.storyItems.taskLink)!,
        companyName: row.read(_db.companies.name)!,
        deadline: row.read(_db.storyItems.taskDeadline)!,
        createdAt: row.read(_db.storyItems.createdAt)!,
        directions:
            row.read(directions)?.split(_separator).toIList() ??
            const IList.empty(),
        vacancyId: row.read(_db.vacancies.id)!,
      );
    });
  }
}
