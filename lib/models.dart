import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';

class Company extends Equatable {
  final String name;
  final ISet<String> links;
  final IList<Vacancy> vacancies;

  /// Имеет ли IT аккредитацию
  final bool isIT;

  final bool isDefault;

  static final defaultCompany = Company(
    name: 'default',
    isDefault: true,
    vacancies: IList([
      Vacancy(link: '', directions: Vacancy.defaultDirections.toISet()),
    ]),
  );

  const Company({
    required this.name,
    this.links = const ISet.empty(),
    this.isIT = false,
    this.vacancies = const IList.empty(),
    this.isDefault = false,
  });

  factory Company.fromJson(Map json) {
    return Company(
      name: json['name'],
      links: List.from(json['links'] ?? []).cast<String>().toISet(),
      isIT: json['isIT'] ?? false,
      vacancies: List.from(
        json['vacancies'] ?? [],
      ).map((e) => Vacancy.fromJson(e)).toList().toIList(),
    );
  }

  @override
  List<Object?> get props => [name, links, isIT, vacancies];

  Map<String, dynamic> toJson() => {
    'name': name,
    'links': links.toList(),
    'isIT': isIT,
    'vacancies': vacancies.map((e) => e.toJson()).toList(),
  };
}

enum ContactType { phone, email, telegram }

class Vacancy extends Equatable {
  static const defaultDirections = {
    'PHP',
    'Yii',
    'Laravel',
    'Symfony',
    'CakePHP',
    'WordPress',
    'Bitrix24',
    'Dart',
    'Flutter',
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
    'JavaScript',
    'React',
    'Vue',
    'jQuery',
  };

  static const defaultGrades = {
    'Staff',
    'Junior',
    'Middle',
    'Middle+',
    'Senior',
    'Lead',
  };

  final String link;
  final ISet<String> directions;
  final ISet<String> grades;
  final IMap<ContactType, String> contacts;
  final IList<CompanyStoryItem> story;

  const Vacancy({
    required this.link,
    this.directions = const ISet.empty(),
    this.grades = const ISet.empty(),
    this.contacts = const IMap.empty(),
    this.story = const IList.empty(),
  });

  factory Vacancy.fromJson(Map json) {
    return Vacancy(
      link: json['link'],
      directions: List.from(json['directions'] ?? {}).cast<String>().toISet(),
      grades: List.from(json['grades'] ?? {}).cast<String>().toISet(),
      contacts: Map<String, String>.from(
        json['contacts'] ?? {},
      ).map((k, v) => MapEntry(ContactType.values.byName(k), v)).toIMap(),
    );
  }

  @override
  List<Object?> get props => [link, directions, grades, contacts, story];

  Map<String, dynamic> toJson() => {
    'link': link,
    'directions': directions.toList(),
    'grades': grades.toList(),
    'contacts': contacts.map((key, value) => MapEntry(key.name, value)),
    'story': story.map((e) => e.toJson()).toList(),
  };
}

//---------------------------------------------------

sealed class CompanyStoryItem extends Equatable {
  final DateTime createdAt;

  const CompanyStoryItem({required this.createdAt});

  factory CompanyStoryItem.fromJson(Map json) {
    final createdAt = DateTime.fromMillisecondsSinceEpoch(json['createdAt']);

    return switch (json['storyItemType']) {
      'InterviewStoryItem' => InterviewStoryItem(
        time: json.getDateTime('time')!,
        isOnline: json['isOnline'] ?? false,
        target: json['target'],
        type: json['type'],
        createdAt: createdAt,
      ),
      'WaitingForFeedbackStoryItem' => WaitingForFeedbackStoryItem(
        time: json.getDateTime('time'),
        comment: json['comment'] ?? '',
        createdAt: createdAt,
      ),
      'TaskStoryItem' => TaskStoryItem(
        deadline: json.getDateTime('deadline'),
        link: json['link'],
        comment: json['comment'] ?? '',
        createdAt: createdAt,
      ),
      'FailureStoryItem' => FailureStoryItem(
        comment: json['comment'],
        createdAt: createdAt,
      ),
      'OfferStoryItem' => OfferStoryItem(
        salary: json['salary'],
        createdAt: createdAt,
      ),
      _ => throw ArgumentError('Unknown story item type'),
    };
  }

  Map<String, dynamic> toJson() => {
    'createdAt': createdAt.millisecondsSinceEpoch,
    'storyItemType': runtimeType.toString(),
  };
}

class InterviewStoryItem extends CompanyStoryItem {
  static const defaultTypes = {'HR', 'Tech', 'Director'};

  final DateTime time;
  final bool isOnline;

  /// Адрес или ссылка на конфу
  final String target;

  final String type;

  const InterviewStoryItem({
    required this.time,
    this.isOnline = true,
    required this.target,
    required this.type,
    required super.createdAt,
  });

  @override
  List<Object?> get props => [time, isOnline, target, type, createdAt];

  @override
  Map<String, dynamic> toJson() => {
    'time': time.millisecondsSinceEpoch,
    'isOnline': isOnline,
    'target': target,
    'type': type,
    ...super.toJson(),
  };
}

class WaitingForFeedbackStoryItem extends CompanyStoryItem {
  final DateTime? time;
  final String comment;

  const WaitingForFeedbackStoryItem({
    this.time,
    this.comment = '',
    required super.createdAt,
  });

  @override
  List<Object?> get props => [time, comment, createdAt];

  @override
  Map<String, dynamic> toJson() => {
    'time': time?.millisecondsSinceEpoch,
    'comment': comment,
    ...super.toJson(),
  };
}

class TaskStoryItem extends CompanyStoryItem {
  final DateTime? deadline;
  final String link, comment;

  const TaskStoryItem({
    this.deadline,
    required this.link,
    this.comment = '',
    required super.createdAt,
  });

  @override
  List<Object?> get props => [deadline, link, comment, createdAt];

  @override
  Map<String, dynamic> toJson() => {
    'deadline': deadline?.millisecondsSinceEpoch,
    'link': link,
    'comment': comment,
    ...super.toJson(),
  };
}

class FailureStoryItem extends CompanyStoryItem {
  final String comment;

  const FailureStoryItem({this.comment = '', required super.createdAt});

  @override
  List<Object?> get props => [comment, createdAt];

  @override
  Map<String, dynamic> toJson() => {'comment': comment, ...super.toJson()};
}

class OfferStoryItem extends CompanyStoryItem {
  /// ЗП
  final int salary;

  const OfferStoryItem({required this.salary, required super.createdAt});

  @override
  List<Object?> get props => [salary, createdAt];

  @override
  Map<String, dynamic> toJson() => {'salary': salary, ...super.toJson()};
}

//---------------------------------------------------

extension AppMapExtensions on Map {
  DateTime? getDateTime(String key) {
    final value = this[key];
    return value == null ? null : DateTime.fromMillisecondsSinceEpoch(value);
  }
}
