import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/story_items.dart';
import 'package:job_pool/domain/models/interview.dart';
import 'package:job_pool/domain/models/story_item.dart';

mixin StoryDbMixin on AppDatabaseBase {
  static const _separator = AppDatabase.separator;

  Future<void> removeStoryItem(int id) async {
    await (delete(storyItems)..where((s) => s.id.equals(id))).go();
  }

  Future<void> insertInterviewStoryItem({
    required int vacancyId,
    required InterviewStoryItemData data,
  }) async {
    await into(storyItems).insert(
      StoryItemsCompanion.insert(
        createdAt: DateTime.now(),
        type: StoryItemType.interview,
        vacancy: vacancyId,
        commonTime: Value(data.time),
        interviewIsOnline: Value(data.isOnline),
        interviewTarget: Value(data.target),
        interviewType: Value(data.type),
      ),
    );
  }

  Future<void> insertWaitingForFeedbackStoryItem({
    required int vacancyId,
    required WaitingForFeedbackStoryItemData data,
  }) async {
    await into(storyItems).insert(
      StoryItemsCompanion.insert(
        createdAt: DateTime.now(),
        type: StoryItemType.waitingForFeedback,
        vacancy: vacancyId,
        commonTime: Value(data.time),
        commonComment: Value(data.comment),
      ),
    );
  }

  Future<void> insertTaskStoryItem({
    required int vacancyId,
    required TaskStoryItemData data,
  }) async {
    await into(storyItems).insert(
      StoryItemsCompanion.insert(
        createdAt: DateTime.now(),
        type: StoryItemType.task,
        vacancy: vacancyId,
        taskDeadline: Value(data.deadline),
        taskLink: Value(data.link),
      ),
    );
  }

  Future<void> insertFailureStoryItem({
    required int vacancyId,
    required FailureStoryItemData data,
  }) async {
    await into(storyItems).insert(
      StoryItemsCompanion.insert(
        createdAt: DateTime.now(),
        type: StoryItemType.failure,
        vacancy: vacancyId,
        commonComment: Value(data.comment),
      ),
    );
  }

  Future<void> insertOfferStoryItem({
    required int vacancyId,
    required OfferStoryItemData data,
  }) async {
    await into(storyItems).insert(
      StoryItemsCompanion.insert(
        createdAt: DateTime.now(),
        type: StoryItemType.offer,
        vacancy: vacancyId,
        offerSalary: Value(data.salary),
      ),
    );
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
}
