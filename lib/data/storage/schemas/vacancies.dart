import 'package:drift/drift.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/data/storage/schemas/companies.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/types.dart';

@DataClassName('VacancyDto')
class Vacancies extends Table {
  late final id = integer().autoIncrement()();
  late final link = text()();
  late final comment = text().withDefault(Constant(''))();

  late final company = integer().references(
    Companies,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final grades = customType(const EnumSetType(JobGrade.values))();
}

@DataClassName('VacancyDirectionDto')
class VacancyDirections extends Table {
  late final vacancy = integer().references(
    Vacancies,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final direction = integer().references(
    JobDirections,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final Column<int> order = integer().check(
    order.isBiggerOrEqualValue(0),
  )();

  @override
  Set<Column<Object>>? get primaryKey => {vacancy, direction};

  @override
  List<Set<Column>>? get uniqueKeys => [{vacancy, order}];
}

@DataClassName('ContactDto')
class Contacts extends Table {
  late final vacancy = integer().references(
    Vacancies,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final contactType = intEnum<ContactType>()();

  late final contactValue = text()();

  @override
  Set<Column<Object>>? get primaryKey => {vacancy, contactType};
}
