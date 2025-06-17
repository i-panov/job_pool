import 'package:job_pool/domain/models/story_item.dart';
import 'package:job_pool/domain/repositories/story_items_repository.dart';

class InsertStoryItemUseCase {
  final StoryItemsRepository _repository;

  const InsertStoryItemUseCase(this._repository);

  Future<void> execute(int vacancyId, StoryItemData data) {
    return _repository.insert(vacancyId, data);
  }
}
