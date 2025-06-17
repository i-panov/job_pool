import 'package:drift/drift.dart';
import 'package:job_pool/domain/models/interview.dart';
import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/domain/models/task.dart';

abstract interface class StoryItemsRepository {
  Future<void> remove(int id);
  Future<void> insert(int vacancyId, StoryItemData data);
  Selectable<StoryItem> selectVacancyStory(int vacancyId);
  Selectable<Interview> selectInterviews();
  Selectable<Task> selectTasks();
}
