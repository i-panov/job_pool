import 'package:drift/drift.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/dto/company_save_args.dart';
import 'package:job_pool/domain/repositories/companies_repository.dart';

class CompaniesRepositoryImpl implements CompaniesRepository {
  final AppDatabase _db;

  const CompaniesRepositoryImpl(this._db);

  @override
  Future<int> insert(CompanySaveArgs args) {
    final company = CompaniesCompanion.insert(
      name: args.name,
      comment: Value(args.comment),
      isIT: args.isIT,
      links: args.links,
    );

    return _db.into(_db.companies).insert(company);
  }

  @override
  Future<void> update(CompanySaveArgs args) {
    final company = CompaniesCompanion(
      id: Value(args.id),
      name: Value(args.name),
      comment: Value(args.comment),
      isIT: Value(args.isIT),
      links: Value(args.links),
    );

    return _db.update(_db.companies).replace(company);
  }

  @override
  Future<void> remove(int id) {
    return (_db.delete(_db.companies)..where((f) => f.id.equals(id))).go();
  }

  @override
  Selectable<CompanyDto?> select(int id) {
    return _db.select(_db.companies)..where((f) => f.id.equals(id));
  }

  @override
  Future<CompanyDto?> findByName(String name) {
    final query = _db.select(_db.companies)..where((f) => f.name.equals(name));
    return query.getSingleOrNull();
  }

  @override
  Future<List<CompanyDto>> filterByName(String name) {
    final query = _db.select(_db.companies)..where((f) => f.name.like('%$name%'));
    return query.get();
  }

  @override
  Selectable<CompanyDto> selectAll() {
    final query = _db.selectOnly(_db.companies)
      ..join([
        leftOuterJoin(_db.vacancies, _db.vacancies.company.equalsExp(_db.companies.id)),
        leftOuterJoin(_db.storyItems, _db.storyItems.vacancy.equalsExp(_db.vacancies.id)),
      ])
      ..orderBy([
        OrderingTerm.desc(_db.storyItems.createdAt),
        OrderingTerm.desc(_db.vacancies.id),
        OrderingTerm.desc(_db.companies.id),
      ])
      ..groupBy([_db.companies.id])
      ..addColumns([
        _db.companies.id,
        _db.companies.name,
        _db.companies.isIT,
        _db.companies.comment,
        _db.companies.links,
      ]);

    return query.map((row) {
      return CompanyDto(
        id: row.read(_db.companies.id)!,
        name: row.read(_db.companies.name)!,
        isIT: row.read(_db.companies.isIT)!,
        comment: row.read(_db.companies.comment)!,
        links: row.read(_db.companies.links)!,
      );
    });
  }
}
