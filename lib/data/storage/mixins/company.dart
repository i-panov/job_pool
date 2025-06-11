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

  Selectable<CompanyDto> selectCompanies() {
    final query = selectOnly(companies)
      ..join([
        leftOuterJoin(vacancies, vacancies.company.equalsExp(companies.id)),
        leftOuterJoin(storyItems, storyItems.vacancy.equalsExp(vacancies.id)),
      ])
      ..orderBy([
        OrderingTerm.desc(storyItems.createdAt),
        OrderingTerm.desc(vacancies.id),
        OrderingTerm.desc(companies.id),
      ])
      ..groupBy([companies.id])
      ..addColumns([
        companies.id,
        companies.name,
        companies.isIT,
        companies.comment,
        companies.links,
      ]);

    return query.map((row) {
      return CompanyDto(
        id: row.read(companies.id)!,
        name: row.read(companies.name)!,
        isIT: row.read(companies.isIT)!,
        comment: row.read(companies.comment)!,
        links: row.read(companies.links)!,
      );
    });
  }
}
