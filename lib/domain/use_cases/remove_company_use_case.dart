import 'package:job_pool/domain/repositories/companies_repository.dart';

class RemoveCompanyUseCase {
  final CompaniesRepository _companiesRepository;

  const RemoveCompanyUseCase(this._companiesRepository);

  Future<void> call(int id) {
    if (id < 0) {
      throw Exception("company id can't be negative: $id");
    }
    
    return _companiesRepository.remove(id);
  }
}
