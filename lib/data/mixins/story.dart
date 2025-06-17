import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/domain/models/interview.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/domain/models/task.dart';

mixin StoryDbMixin on AppDatabaseBase {
  static const _separator = AppDatabase.separator;

  Future<void> removeStoryItem(int id) async {
    await (delete(storyItems)..where((s) => s.id.equals(id))).go();
  }

  Future<void> insertStoryItem(int vacancyId, StoryItemData data) {
    return into(storyItems).insert(StoryItemsCompanion.insert(
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

  Selectable<Task> selectTasks() {
    final directions = jobDirections.name.groupConcat(separator: _separator);

    final query = selectOnly(storyItems)
      ..where(storyItems.type.equalsValue(StoryItemType.task))
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
      ..orderBy([OrderingTerm.desc(storyItems.createdAt)])
      ..groupBy([storyItems.id])
      ..addColumns([
        storyItems.taskLink,
        storyItems.taskDeadline,
        storyItems.createdAt,
        vacancies.id,
        companies.name,
        directions,
      ]);

    return query.map((row) {
      return Task(
        link: row.read(storyItems.taskLink)!,
        companyName: row.read(companies.name)!,
        deadline: row.read(storyItems.taskDeadline)!,
        createdAt: row.read(storyItems.createdAt)!,
        directions:
            row.read(directions)?.split(_separator).toIList() ??
            const IList.empty(),
        vacancyId: row.read(vacancies.id)!,
      );
    });
  }
}
