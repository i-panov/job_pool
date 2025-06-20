import 'package:drift/drift.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/dto/company_save_args.dart';

abstract interface class CompaniesRepository {
  Future<int> insert(CompanySaveArgs args);
  Future<void> update(CompanySaveArgs args);
  Future<void> remove(int id);
  Selectable<CompanyDto?> select(int id);
  Future<CompanyDto?> findByName(String name);
  Future<List<CompanyDto>> filterByName(String name);
  Selectable<CompanyDto> selectAll();
}
