import 'package:drift/drift.dart';
import 'package:job_pool/data/storage/db/db.dart';

mixin CompanyDbMixin on AppDatabaseBase {
  Future<CompanyDto?> getCompany(int id) {
    final query = select(companies)..where((f) => f.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<CompanyDto?> findCompanyByName(String name) {
    final query = select(companies)..where((f) => f.name.equals(name));
    return query.getSingleOrNull();
  }

  Future<List<CompanyDto>> findCompaniesLikeName(String name) {
    final query = select(companies)..where((f) => f.name.like('%$name%'));
    return query.get();
  }

  Future<void> removeCompany(int id) {
    final query = delete(companies)..where((f) => f.id.equals(id));
    return query.go();
  }
}
