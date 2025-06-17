import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/core/extensions.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/dto/vacancy_save_args.dart';
import 'package:job_pool/domain/models/contact.dart';
import 'package:job_pool/domain/models/vacancy_full_info.dart';
import 'package:job_pool/domain/models/vacancy_short_info.dart';
import 'package:job_pool/domain/repositories/vacancies_repository.dart';

class VacanciesRepositoryImpl implements VacanciesRepository {
  final AppDatabase _db;

  const VacanciesRepositoryImpl(this._db);

  @override
  Future<int> insert(VacancySaveArgs args) {
    return _db.transaction(() async {
      final vacancyId = await _db
          .into(_db.vacancies)
          .insert(
            VacanciesCompanion.insert(
              company: args.companyId,
              link: args.link,
              comment: Value(args.comment),
              grades: args.grades,
            ),
          );

      await _db.batch((batch) {
        batch.insertAll(_db.vacancyDirections, [
          for (final (index, id) in args.directionIds.indexed)
            VacancyDirectionsCompanion.insert(
              vacancy: vacancyId,
              direction: id,
              order: index,
            ),
        ]);

        batch.insertAll(_db.contacts, [
          for (final contact in args.contacts)
            ContactsCompanion.insert(
              vacancy: vacancyId,
              contactType: contact.type,
              contactValue: contact.value,
            ),
        ]);
      });

      return vacancyId;
    });
  }

  @override
  Future<void> update(VacancySaveArgs args) {
    return _db.batch((batch) {
      batch.replace(
        _db.vacancies,
        VacanciesCompanion(
          id: Value(args.id),
          company: Value(args.companyId),
          link: Value(args.link),
          comment: Value(args.comment),
          grades: Value(args.grades),
        ),
      );

      batch.replaceAll(_db.vacancyDirections, [
        for (final (index, directionId) in args.directionIds.indexed)
          VacancyDirectionsCompanion(
            vacancy: Value(args.id),
            direction: Value(directionId),
            order: Value(index),
          ),
      ]);

      batch.replaceAll(_db.contacts, [
        for (final contact in args.contacts)
          ContactsCompanion(
            vacancy: Value(args.id),
            contactType: Value(contact.type),
            contactValue: Value(contact.value),
          ),
      ]);
    });
  }

  @override
  Future<void> remove(int id) {
    return (_db.delete(_db.vacancies)..where((f) => f.id.equals(id))).go();
  }

  @override
  Selectable<VacancyFullInfo> select(int id) {
    final sep = AppDatabase.separator;

    return _db.selectVacancyFullInfoInternal(id).map((row) {
      final directionIds = (row.directionIds?.split(sep) ?? []).map(
        int.tryParse,
      );

      final directionNames = row.directionNames?.split(sep) ?? [];

      final contactTypes = (row.contactTypes?.split(sep) ?? []).map(
        int.tryParse,
      );

      final contactValues = row.contactValues?.split(sep) ?? [];

      return VacancyFullInfo(
        id: row.id,
        link: row.link,
        comment: row.comment,
        grades: row.grades,
        companyId: row.companyId,
        companyName: row.companyName,
        directions: directionNames
            .zip(directionIds)
            .where((p) => p.right != null)
            .map((p) => (id: p.right!, name: p.left))
            .toIList(),
        contacts: contactValues
            .zip(contactTypes)
            .where((p) => p.right != null && p.left.isNotEmpty)
            .map(
              (e) => Contact(type: ContactType.values[e.right!], value: e.left),
            )
            .toIList(),
      );
    });
  }

  @override
  Selectable<VacancyShortInfo> filterByCompany(int companyId) {
    final directionNames = _db.jobDirections.name.groupConcat(
      distinct: true,
      orderBy: OrderBy([OrderingTerm.asc(_db.vacancyDirections.order)]),
    );

    final query = _db.selectOnly(_db.vacancies)
      ..where(_db.vacancies.company.equals(companyId))
      ..join([
        leftOuterJoin(
          _db.vacancyDirections,
          _db.vacancyDirections.vacancy.equalsExp(_db.vacancies.id),
        ),
        innerJoin(
          _db.jobDirections,
          _db.jobDirections.id.equalsExp(_db.vacancyDirections.direction),
        ),
        leftOuterJoin(
          _db.storyItems,
          _db.storyItems.vacancy.equalsExp(_db.vacancies.id),
        ),
      ])
      ..groupBy([_db.vacancies.id])
      ..orderBy([OrderingTerm.desc(_db.storyItems.createdAt)])
      ..addColumns([_db.vacancies.id, _db.vacancies.grades, directionNames]);

    return query.map((row) {
      final directionNamesList = row.read(directionNames)?.split(',') ?? [];

      return VacancyShortInfo(
        id: row.read(_db.vacancies.id)!,
        grades: row.read(_db.vacancies.grades)!.toIList(),
        directions: directionNamesList.toIList(),
      );
    });
  }
}
