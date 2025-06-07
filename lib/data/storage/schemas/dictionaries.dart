import 'package:drift/drift.dart';

@DataClassName('JobDirectionDto')
class JobDirections extends Table {
  late final id = integer().autoIncrement()();
  late final name = text().unique()();

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

enum JobGrade { intern, junior, middle, senior, lead }

enum InterviewType {
  hr('HR'),
  tech('техническое'),
  director('с руководителем');

  final String label;

  const InterviewType(this.label);
}

enum ContactType { email, phone, telegram }
