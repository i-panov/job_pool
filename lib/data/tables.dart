import 'package:drift/drift.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/data/types.dart';

@DataClassName('CompanyDto')
class Companies extends Table {
  late final id = integer().autoIncrement()();
  late final name = text()();
  late final isIT = boolean().named('is_it')();
  late final comment = text().withDefault(Constant(''))();
  late final links = customType(const StringSetType())();
}

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

@DataClassName('StoryItemDto')
class StoryItems extends Table {
  late final id = integer().autoIncrement()();
  late final createdAt = dateTime()();

  late final type = intEnum<StoryItemType>()();

  late final commonTime = dateTime().nullable()();
  late final commonComment = text().withDefault(Constant(''))();

  late final interviewIsOnline = boolean().nullable()();
  late final interviewTarget = text().withDefault(Constant(''))();
  late final interviewType = intEnum<InterviewType>().nullable()();

  late final taskDeadline = dateTime().nullable()();
  late final taskLink = text().withDefault(Constant(''))();

  late final offerSalary = integer().nullable()();

  late final vacancy = integer().references(
    Vacancies,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();
}

@DataClassName('JobDirectionDto')
class JobDirections extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().unique()();

  /// При парсинге иногда добавляются лишние направления. 
  /// Планирую сделать возможность их игнора.
  late final ignore = boolean().withDefault(Constant(false))();

  static const defaults = {
    'Dart',
    'Flutter',
    'JavaScript',
    'React',
    'Vue',
    'jQuery',
    'PHP',
    'Yii',
    'Laravel',
    'Symfony',
    'CakePHP',
    'WordPress',
    'Bitrix24',
    'C#',
    'ASP.NET',
    'WPF',
    'Avalonia.UI',
    'Java',
    'Spring',
    'Android',
    'Kotlin',
    'Python',
    'Django',
    'Flask',
    'Go',
    'Rust',
    'C++',
    'C',
    'Qt',
    'Qml',
    'SQL',
  };
}
