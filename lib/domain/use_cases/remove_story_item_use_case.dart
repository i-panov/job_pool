import 'package:job_pool/domain/repositories/story_items_repository.dart';

class RemoveStoryItemUseCase {
  final StoryItemsRepository _repository;

  RemoveStoryItemUseCase(this._repository);

  Future<void> execute(int id) {
    if (id < 0) {
      throw Exception("story item id can't be negative: $id");
    }

    return _repository.remove(id);
  }
}
