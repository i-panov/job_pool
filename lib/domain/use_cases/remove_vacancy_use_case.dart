import 'package:job_pool/domain/repositories/vacancies_repository.dart';

class RemoveVacancyUseCase {
  final VacanciesRepository _repository;
  
  const RemoveVacancyUseCase(this._repository);
  
  Future<void> execute(int id) {
    if (id < 0) {
      throw Exception("vacancy id can't be negative: $id");
    }

    return _repository.remove(id);
  }
}
