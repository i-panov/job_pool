import 'package:drift/drift.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/data/storage/schemas/vacancies.dart';

enum StoryItemType {
  interview('Собеседование'),
  waitingForFeedback('Ожидание фидбэка'),
  task('ТЗ'),
  failure('Провал'),
  offer('Оффер');

  final String label;
  
  const StoryItemType(this.label);
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
