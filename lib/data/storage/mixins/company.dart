import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/data/db/db.dart';

mixin CompanyDbMixin on AppDatabaseBase {
  Future<int> insertCompany({
    required String name,
    String comment = '',
    bool isIT = false,
    ISet<String> links = const ISet.empty(),
  }) {
    final company = CompaniesCompanion.insert(
      name: name,
      comment: Value(comment),
      isIT: isIT,
      links: links,
    );

    return into(companies).insert(company);
  }

  Future<void> updateCompany({
    required int id,
    required String name,
    String comment = '',
    bool isIT = false,
    ISet<String> links = const ISet.empty(),
  }) {
    final company = CompaniesCompanion(
      id: Value(id),
      name: Value(name),
      comment: Value(comment),
      isIT: Value(isIT),
      links: Value(links),
    );

    return update(companies).replace(company);
  }

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
