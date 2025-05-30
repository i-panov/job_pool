import 'package:drift/drift.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';

class StoryItems extends Table {
  late final id = integer().autoIncrement()();
  late final createdAt = dateTime()();

  late final vacancy = integer().references(
    Vacancies,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();
}

class InterviewStoryItems extends Table {
  late final item = integer().references(
    StoryItems,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final time = dateTime()();
  late final isOnline = boolean()();
  late final target = text()();
  late final type = intEnum<InterviewTypes>()();

  @override
  Set<Column<Object>>? get primaryKey => {item};
}

class WaitingForFeedbackStoryItems extends Table {
  late final item = integer().references(
    StoryItems,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final time = dateTime().nullable()();
  late final comment = text().withDefault(Constant(''))();

  @override
  Set<Column<Object>>? get primaryKey => {item};
}

class TaskStoryItems extends Table {
  late final item = integer().references(
    StoryItems,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final deadline = dateTime().nullable()();
  late final link = text()();
  late final comment = text().withDefault(Constant(''))();

  @override
  Set<Column<Object>>? get primaryKey => {item};
}

class FailureStoryItems extends Table {
  late final item = integer().references(
    StoryItems,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final comment = text().withDefault(Constant(''))();

  @override
  Set<Column<Object>>? get primaryKey => {item};
}

class OfferStoryItems extends Table {
  late final item = integer().references(
    StoryItems,
    #id,
    onDelete: KeyAction.cascade,
    initiallyDeferred: true,
  )();

  late final Column<int> salary = integer().check(
    salary.isBiggerOrEqualValue(0),
  )();

  @override
  Set<Column<Object>>? get primaryKey => {item};
}
