import 'package:drift/drift.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/core/extensions.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/domain/models/vacancy_full_info.dart';
import 'package:job_pool/domain/models/vacancy_short_info.dart';

mixin VacancyDbMixin on AppDatabaseBase {
  static const _separator = AppDatabase.separator;

  Future<int> insertVacancy({
    required int companyId,
    required String link,
    required String comment,
    required ISet<JobGrade> grades,
    required IList<int> directionIds,
    required IList<({ContactType type, String value})> contactsList,
  }) async {
    return await transaction(() async {
      final vacancyId = await into(vacancies).insert(
        VacanciesCompanion.insert(
          company: companyId,
          link: link,
          comment: Value(comment),
          grades: grades,
        ),
      );

      await batch((batch) {
        batch.insertAll(vacancyDirections, [
          for (final (index, id) in directionIds.indexed)
            VacancyDirectionsCompanion.insert(
              vacancy: vacancyId,
              direction: id,
              order: index,
            ),
        ]);

        batch.insertAll(contacts, [
          for (final contact in contactsList)
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

  Future<void> updateVacancy({
    required int id,
    required int companyId,
    required String link,
    required String comment,
    required ISet<JobGrade> grades,
    required IList<int> directionIds,
    required IList<({ContactType type, String value})> contactsList,
  }) {
    return batch((batch) {
      batch.replace(
        vacancies,
        VacanciesCompanion(
          id: Value(id),
          company: Value(companyId),
          link: Value(link),
          comment: Value(comment),
          grades: Value(grades),
        ),
      );

      batch.replaceAll(vacancyDirections, [
        for (final (index, directionId) in directionIds.indexed)
          VacancyDirectionsCompanion(
            vacancy: Value(id),
            direction: Value(directionId),
            order: Value(index),
          ),
      ]);

      batch.replaceAll(contacts, [
        for (final contact in contactsList)
          ContactsCompanion(
            vacancy: Value(id),
            contactType: Value(contact.type),
            contactValue: Value(contact.value),
          ),
      ]);
    });
  }

  Future<void> removeVacancy(int id) async {
    await (delete(vacancies)..where((f) => f.id.equals(id))).go();
  }

  Future<List<int>> getVacancyDirectionIds(int vacancyId) {
    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId))
      ..orderBy([(f) => OrderingTerm.asc(f.order)]);

    return query.map((row) => row.direction).get();
  }

  Future<List<ContactDto>> getVacancyContacts(int vacancyId) {
    final query = select(contacts)..where((f) => f.vacancy.equals(vacancyId));
    return query.get();
  }

  Stream<List<VacancyShortInfo>> watchVacanciesShortInfo(int companyId) {
    final directionNames = jobDirections.name.groupConcat(
      distinct: true,
      orderBy: OrderBy([OrderingTerm.asc(vacancyDirections.order)]),
    );

    final query = selectOnly(vacancies)
      ..where(vacancies.company.equals(companyId))
      ..join([
        leftOuterJoin(
          vacancyDirections,
          vacancyDirections.vacancy.equalsExp(vacancies.id),
        ),
        innerJoin(
          jobDirections,
          jobDirections.id.equalsExp(vacancyDirections.direction),
        ),
        leftOuterJoin(storyItems, storyItems.vacancy.equalsExp(vacancies.id)),
      ])
      ..groupBy([vacancies.id])
      ..orderBy([OrderingTerm.desc(storyItems.createdAt)])
      ..addColumns([vacancies.id, vacancies.grades, directionNames]);

    return query.map((row) {
      final directionNamesList = row.read(directionNames)?.split(',') ?? [];

      return VacancyShortInfo(
        id: row.read(vacancies.id)!,
        grades: row.read(vacancies.grades)!.toIList(),
        directions: directionNamesList.toIList(),
      );
    }).watch();
  }

  Stream<VacancyFullInfo> watchVacancyFullInfo(int vacancyId) {
    return selectVacancyFullInfoInternal(vacancyId).map((row) {
      final directionIds = (row.directionIds?.split(_separator) ?? []).map(
        int.tryParse,
      );

      final directionNames = row.directionNames?.split(_separator) ?? [];

      final contactTypes = (row.contactTypes?.split(_separator) ?? []).map(
        int.tryParse,
      );

      final contactValues = row.contactValues?.split(_separator) ?? [];

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
            .map((e) => (type: ContactType.values[e.right!], value: e.left))
            .toIList(),
      );
    }).watchSingle();
  }

  Selectable<VacancyFullInfo> getFullVacancyInfo(int vacancyId) {
    final directionIds = jobDirections.id.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(vacancyDirections.order)]),
    );

    final directionNames = jobDirections.name.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(vacancyDirections.order)]),
    );

    final contactTypes = contacts.contactType.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(contacts.contactType)]),
    );

    final contactValues = contacts.contactValue.groupConcat(
      separator: _separator,
      orderBy: OrderBy([OrderingTerm.asc(contacts.contactType)]),
    );

    final query = selectOnly(vacancies)
      ..where(vacancies.id.equals(vacancyId))
      ..join([
        innerJoin(companies, companies.id.equalsExp(vacancies.company)),
        leftOuterJoin(
          vacancyDirections,
          vacancyDirections.vacancy.equalsExp(vacancies.id),
        ),
        innerJoin(
          jobDirections,
          jobDirections.id.equalsExp(vacancyDirections.direction),
        ),
        innerJoin(contacts, contacts.vacancy.equalsExp(vacancies.id)),
      ])
      ..groupBy([vacancies.id])
      ..addColumns([
        vacancies.id,
        vacancies.link,
        vacancies.comment,
        vacancies.grades,
        companies.id,
        companies.name,
        directionIds,
        directionNames,
        contactTypes,
        contactValues,
      ]);

    return query.map((row) {
      final valueDirectionIds = row
          .read(directionIds)!
          .split(_separator)
          .map(int.parse);

      final valueDirectionNames = row.read(directionNames)!.split(_separator);

      final valueContactTypes = row
          .read(contactTypes)!
          .split(_separator)
          .map(int.parse)
          .map((i) => ContactType.values[i]);

      final valueContactValues = row.read(contactValues)!.split(_separator);

      return VacancyFullInfo(
        id: row.read(vacancies.id)!,
        link: row.read(vacancies.link)!,
        comment: row.read(vacancies.comment)!,
        grades: row.read(vacancies.grades)!,
        companyId: row.read(companies.id)!,
        companyName: row.read(companies.name)!,
        directions: valueDirectionNames
            .zip(valueDirectionIds)
            .map((p) => (id: p.right, name: p.left))
            .toIList(),
        contacts: valueContactValues
            .zip(valueContactTypes)
            .map((p) => (type: p.right, value: p.left))
            .toIList(),
      );
    });
  }

  Future<VacancyDto?> getVacancy(int id) {
    final query = select(vacancies)..where((f) => f.id.equals(id));
    return query.getSingleOrNull();
  }

  Future<bool> setVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
    required int order,
  }) async {
    final maxOrder =
        (await _getMaxVacancyDirectionOrder(vacancyId: vacancyId)) ?? -1;

    if (order < 0 || order > maxOrder) {
      order = maxOrder + 1;
    }

    final currentOrder = await _getVacancyDirectionOrder(
      vacancyId: vacancyId,
      directionId: directionId,
    );

    if (currentOrder == null || currentOrder == order) {
      return false;
    }

    final otherDirectionId = await _getVacancyDirectionByOrder(
      vacancyId: vacancyId,
      order: order,
    );

    if (otherDirectionId == null) {
      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: directionId,
        order: order,
      );

      return true;
    }

    await transaction(() async {
      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: otherDirectionId,
        order: maxOrder + 1,
      );

      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: directionId,
        order: order,
      );

      _updateVacancyDirectionOrder(
        vacancyId: vacancyId,
        directionId: otherDirectionId,
        order: currentOrder,
      );
    });

    return true;
  }

  Future<int?> _getVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
  }) async {
    final query = select(vacancyDirections)
      ..where(
        (f) => f.vacancy.equals(vacancyId) & f.direction.equals(directionId),
      );

    return await query.map((row) => row.order).getSingleOrNull();
  }

  Future<int?> _getVacancyDirectionByOrder({
    required int vacancyId,
    required int order,
  }) async {
    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId) & f.order.equals(order));

    return await query.map((row) => row.direction).getSingleOrNull();
  }

  Future<int?> _getMaxVacancyDirectionOrder({required int vacancyId}) async {
    final maxOrder = vacancyDirections.order.max();

    final query = select(vacancyDirections)
      ..where((f) => f.vacancy.equals(vacancyId));

    return await query
        .addColumns([maxOrder])
        .map((row) => row.read(maxOrder))
        .getSingleOrNull();
  }

  Future<void> _updateVacancyDirectionOrder({
    required int vacancyId,
    required int directionId,
    required int order,
  }) async {
    final stmt = update(vacancyDirections)
      ..where(
        (f) => f.vacancy.equals(vacancyId) & f.direction.equals(directionId),
      );

    await stmt.write(VacancyDirectionsCompanion(order: Value(order)));
  }
}
