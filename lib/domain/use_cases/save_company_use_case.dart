import 'package:job_pool/data/dto/company_save_args.dart';
import 'package:job_pool/domain/repositories/companies_repository.dart';

class SaveCompanyUseCase {
  final CompaniesRepository _repository;

  const SaveCompanyUseCase(this._repository);

  Future<void> execute(CompanySaveArgs args) {
    return args.isNew ? _repository.insert(args) : _repository.update(args);
  }
}
