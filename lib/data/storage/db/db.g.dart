// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, Company> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CompaniesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isITMeta = const VerificationMeta('isIT');
  @override
  late final GeneratedColumn<bool> isIT = GeneratedColumn<bool>(
    'is_it',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_it" IN (0, 1))',
    ),
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  static const VerificationMeta _linksMeta = const VerificationMeta('links');
  @override
  late final GeneratedColumn<ISet<String>> links =
      GeneratedColumn<ISet<String>>(
        'links',
        aliasedName,
        false,
        type: const StringSetType(),
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, name, isIT, comment, links];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'companies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Company> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('is_it')) {
      context.handle(
        _isITMeta,
        isIT.isAcceptableOrUnknown(data['is_it']!, _isITMeta),
      );
    } else if (isInserting) {
      context.missing(_isITMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('links')) {
      context.handle(
        _linksMeta,
        links.isAcceptableOrUnknown(data['links']!, _linksMeta),
      );
    } else if (isInserting) {
      context.missing(_linksMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Company map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Company(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      isIT: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_it'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
      links: attachedDatabase.typeMapping.read(
        const StringSetType(),
        data['${effectivePrefix}links'],
      )!,
    );
  }

  @override
  $CompaniesTable createAlias(String alias) {
    return $CompaniesTable(attachedDatabase, alias);
  }
}

class Company extends DataClass implements Insertable<Company> {
  final int id;
  final String name;
  final bool isIT;
  final String comment;
  final ISet<String> links;
  const Company({
    required this.id,
    required this.name,
    required this.isIT,
    required this.comment,
    required this.links,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['is_it'] = Variable<bool>(isIT);
    map['comment'] = Variable<String>(comment);
    map['links'] = Variable<ISet<String>>(links, const StringSetType());
    return map;
  }

  CompaniesCompanion toCompanion(bool nullToAbsent) {
    return CompaniesCompanion(
      id: Value(id),
      name: Value(name),
      isIT: Value(isIT),
      comment: Value(comment),
      links: Value(links),
    );
  }

  factory Company.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Company(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      isIT: serializer.fromJson<bool>(json['isIT']),
      comment: serializer.fromJson<String>(json['comment']),
      links: serializer.fromJson<ISet<String>>(json['links']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'isIT': serializer.toJson<bool>(isIT),
      'comment': serializer.toJson<String>(comment),
      'links': serializer.toJson<ISet<String>>(links),
    };
  }

  Company copyWith({
    int? id,
    String? name,
    bool? isIT,
    String? comment,
    ISet<String>? links,
  }) => Company(
    id: id ?? this.id,
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    comment: comment ?? this.comment,
    links: links ?? this.links,
  );
  Company copyWithCompanion(CompaniesCompanion data) {
    return Company(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isIT: data.isIT.present ? data.isIT.value : this.isIT,
      comment: data.comment.present ? data.comment.value : this.comment,
      links: data.links.present ? data.links.value : this.links,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Company(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isIT: $isIT, ')
          ..write('comment: $comment, ')
          ..write('links: $links')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, isIT, comment, links);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Company &&
          other.id == this.id &&
          other.name == this.name &&
          other.isIT == this.isIT &&
          other.comment == this.comment &&
          other.links == this.links);
}

class CompaniesCompanion extends UpdateCompanion<Company> {
  final Value<int> id;
  final Value<String> name;
  final Value<bool> isIT;
  final Value<String> comment;
  final Value<ISet<String>> links;
  const CompaniesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.isIT = const Value.absent(),
    this.comment = const Value.absent(),
    this.links = const Value.absent(),
  });
  CompaniesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required bool isIT,
    this.comment = const Value.absent(),
    required ISet<String> links,
  }) : name = Value(name),
       isIT = Value(isIT),
       links = Value(links);
  static Insertable<Company> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<bool>? isIT,
    Expression<String>? comment,
    Expression<ISet<String>>? links,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (isIT != null) 'is_it': isIT,
      if (comment != null) 'comment': comment,
      if (links != null) 'links': links,
    });
  }

  CompaniesCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<bool>? isIT,
    Value<String>? comment,
    Value<ISet<String>>? links,
  }) {
    return CompaniesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      isIT: isIT ?? this.isIT,
      comment: comment ?? this.comment,
      links: links ?? this.links,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (isIT.present) {
      map['is_it'] = Variable<bool>(isIT.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (links.present) {
      map['links'] = Variable<ISet<String>>(links.value, const StringSetType());
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CompaniesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('isIT: $isIT, ')
          ..write('comment: $comment, ')
          ..write('links: $links')
          ..write(')'))
        .toString();
  }
}

class $VacanciesTable extends Vacancies
    with TableInfo<$VacanciesTable, Vacancy> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VacanciesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  static const VerificationMeta _companyMeta = const VerificationMeta(
    'company',
  );
  @override
  late final GeneratedColumn<int> company = GeneratedColumn<int>(
    'company',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES companies (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _gradesMeta = const VerificationMeta('grades');
  @override
  late final GeneratedColumn<ISet<JobGrades>> grades =
      GeneratedColumn<ISet<JobGrades>>(
        'grades',
        aliasedName,
        false,
        type: const EnumSetType(JobGrades.values),
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [id, link, comment, company, grades];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vacancies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vacancy> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    if (data.containsKey('company')) {
      context.handle(
        _companyMeta,
        company.isAcceptableOrUnknown(data['company']!, _companyMeta),
      );
    } else if (isInserting) {
      context.missing(_companyMeta);
    }
    if (data.containsKey('grades')) {
      context.handle(
        _gradesMeta,
        grades.isAcceptableOrUnknown(data['grades']!, _gradesMeta),
      );
    } else if (isInserting) {
      context.missing(_gradesMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vacancy map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vacancy(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
      company: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}company'],
      )!,
      grades: attachedDatabase.typeMapping.read(
        const EnumSetType(JobGrades.values),
        data['${effectivePrefix}grades'],
      )!,
    );
  }

  @override
  $VacanciesTable createAlias(String alias) {
    return $VacanciesTable(attachedDatabase, alias);
  }
}

class Vacancy extends DataClass implements Insertable<Vacancy> {
  final int id;
  final String link;
  final String comment;
  final int company;
  final ISet<JobGrades> grades;
  const Vacancy({
    required this.id,
    required this.link,
    required this.comment,
    required this.company,
    required this.grades,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['link'] = Variable<String>(link);
    map['comment'] = Variable<String>(comment);
    map['company'] = Variable<int>(company);
    map['grades'] = Variable<ISet<JobGrades>>(
      grades,
      const EnumSetType(JobGrades.values),
    );
    return map;
  }

  VacanciesCompanion toCompanion(bool nullToAbsent) {
    return VacanciesCompanion(
      id: Value(id),
      link: Value(link),
      comment: Value(comment),
      company: Value(company),
      grades: Value(grades),
    );
  }

  factory Vacancy.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vacancy(
      id: serializer.fromJson<int>(json['id']),
      link: serializer.fromJson<String>(json['link']),
      comment: serializer.fromJson<String>(json['comment']),
      company: serializer.fromJson<int>(json['company']),
      grades: serializer.fromJson<ISet<JobGrades>>(json['grades']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'link': serializer.toJson<String>(link),
      'comment': serializer.toJson<String>(comment),
      'company': serializer.toJson<int>(company),
      'grades': serializer.toJson<ISet<JobGrades>>(grades),
    };
  }

  Vacancy copyWith({
    int? id,
    String? link,
    String? comment,
    int? company,
    ISet<JobGrades>? grades,
  }) => Vacancy(
    id: id ?? this.id,
    link: link ?? this.link,
    comment: comment ?? this.comment,
    company: company ?? this.company,
    grades: grades ?? this.grades,
  );
  Vacancy copyWithCompanion(VacanciesCompanion data) {
    return Vacancy(
      id: data.id.present ? data.id.value : this.id,
      link: data.link.present ? data.link.value : this.link,
      comment: data.comment.present ? data.comment.value : this.comment,
      company: data.company.present ? data.company.value : this.company,
      grades: data.grades.present ? data.grades.value : this.grades,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vacancy(')
          ..write('id: $id, ')
          ..write('link: $link, ')
          ..write('comment: $comment, ')
          ..write('company: $company, ')
          ..write('grades: $grades')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, link, comment, company, grades);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vacancy &&
          other.id == this.id &&
          other.link == this.link &&
          other.comment == this.comment &&
          other.company == this.company &&
          other.grades == this.grades);
}

class VacanciesCompanion extends UpdateCompanion<Vacancy> {
  final Value<int> id;
  final Value<String> link;
  final Value<String> comment;
  final Value<int> company;
  final Value<ISet<JobGrades>> grades;
  const VacanciesCompanion({
    this.id = const Value.absent(),
    this.link = const Value.absent(),
    this.comment = const Value.absent(),
    this.company = const Value.absent(),
    this.grades = const Value.absent(),
  });
  VacanciesCompanion.insert({
    this.id = const Value.absent(),
    required String link,
    this.comment = const Value.absent(),
    required int company,
    required ISet<JobGrades> grades,
  }) : link = Value(link),
       company = Value(company),
       grades = Value(grades);
  static Insertable<Vacancy> custom({
    Expression<int>? id,
    Expression<String>? link,
    Expression<String>? comment,
    Expression<int>? company,
    Expression<ISet<JobGrades>>? grades,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (link != null) 'link': link,
      if (comment != null) 'comment': comment,
      if (company != null) 'company': company,
      if (grades != null) 'grades': grades,
    });
  }

  VacanciesCompanion copyWith({
    Value<int>? id,
    Value<String>? link,
    Value<String>? comment,
    Value<int>? company,
    Value<ISet<JobGrades>>? grades,
  }) {
    return VacanciesCompanion(
      id: id ?? this.id,
      link: link ?? this.link,
      comment: comment ?? this.comment,
      company: company ?? this.company,
      grades: grades ?? this.grades,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    if (company.present) {
      map['company'] = Variable<int>(company.value);
    }
    if (grades.present) {
      map['grades'] = Variable<ISet<JobGrades>>(
        grades.value,
        const EnumSetType(JobGrades.values),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VacanciesCompanion(')
          ..write('id: $id, ')
          ..write('link: $link, ')
          ..write('comment: $comment, ')
          ..write('company: $company, ')
          ..write('grades: $grades')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vacancyMeta = const VerificationMeta(
    'vacancy',
  );
  @override
  late final GeneratedColumn<int> vacancy = GeneratedColumn<int>(
    'vacancy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vacancies (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<ContactTypes, int> contactType =
      GeneratedColumn<int>(
        'contact_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ContactTypes>($ContactsTable.$convertercontactType);
  static const VerificationMeta _contactValueMeta = const VerificationMeta(
    'contactValue',
  );
  @override
  late final GeneratedColumn<String> contactValue = GeneratedColumn<String>(
    'contact_value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [vacancy, contactType, contactValue];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(
    Insertable<Contact> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vacancy')) {
      context.handle(
        _vacancyMeta,
        vacancy.isAcceptableOrUnknown(data['vacancy']!, _vacancyMeta),
      );
    } else if (isInserting) {
      context.missing(_vacancyMeta);
    }
    if (data.containsKey('contact_value')) {
      context.handle(
        _contactValueMeta,
        contactValue.isAcceptableOrUnknown(
          data['contact_value']!,
          _contactValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_contactValueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vacancy, contactType};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      vacancy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vacancy'],
      )!,
      contactType: $ContactsTable.$convertercontactType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}contact_type'],
        )!,
      ),
      contactValue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}contact_value'],
      )!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ContactTypes, int, int> $convertercontactType =
      const EnumIndexConverter<ContactTypes>(ContactTypes.values);
}

class Contact extends DataClass implements Insertable<Contact> {
  final int vacancy;
  final ContactTypes contactType;
  final String contactValue;
  const Contact({
    required this.vacancy,
    required this.contactType,
    required this.contactValue,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vacancy'] = Variable<int>(vacancy);
    {
      map['contact_type'] = Variable<int>(
        $ContactsTable.$convertercontactType.toSql(contactType),
      );
    }
    map['contact_value'] = Variable<String>(contactValue);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      vacancy: Value(vacancy),
      contactType: Value(contactType),
      contactValue: Value(contactValue),
    );
  }

  factory Contact.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      vacancy: serializer.fromJson<int>(json['vacancy']),
      contactType: $ContactsTable.$convertercontactType.fromJson(
        serializer.fromJson<int>(json['contactType']),
      ),
      contactValue: serializer.fromJson<String>(json['contactValue']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vacancy': serializer.toJson<int>(vacancy),
      'contactType': serializer.toJson<int>(
        $ContactsTable.$convertercontactType.toJson(contactType),
      ),
      'contactValue': serializer.toJson<String>(contactValue),
    };
  }

  Contact copyWith({
    int? vacancy,
    ContactTypes? contactType,
    String? contactValue,
  }) => Contact(
    vacancy: vacancy ?? this.vacancy,
    contactType: contactType ?? this.contactType,
    contactValue: contactValue ?? this.contactValue,
  );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      vacancy: data.vacancy.present ? data.vacancy.value : this.vacancy,
      contactType: data.contactType.present
          ? data.contactType.value
          : this.contactType,
      contactValue: data.contactValue.present
          ? data.contactValue.value
          : this.contactValue,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('vacancy: $vacancy, ')
          ..write('contactType: $contactType, ')
          ..write('contactValue: $contactValue')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vacancy, contactType, contactValue);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.vacancy == this.vacancy &&
          other.contactType == this.contactType &&
          other.contactValue == this.contactValue);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> vacancy;
  final Value<ContactTypes> contactType;
  final Value<String> contactValue;
  final Value<int> rowid;
  const ContactsCompanion({
    this.vacancy = const Value.absent(),
    this.contactType = const Value.absent(),
    this.contactValue = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ContactsCompanion.insert({
    required int vacancy,
    required ContactTypes contactType,
    required String contactValue,
    this.rowid = const Value.absent(),
  }) : vacancy = Value(vacancy),
       contactType = Value(contactType),
       contactValue = Value(contactValue);
  static Insertable<Contact> custom({
    Expression<int>? vacancy,
    Expression<int>? contactType,
    Expression<String>? contactValue,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vacancy != null) 'vacancy': vacancy,
      if (contactType != null) 'contact_type': contactType,
      if (contactValue != null) 'contact_value': contactValue,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ContactsCompanion copyWith({
    Value<int>? vacancy,
    Value<ContactTypes>? contactType,
    Value<String>? contactValue,
    Value<int>? rowid,
  }) {
    return ContactsCompanion(
      vacancy: vacancy ?? this.vacancy,
      contactType: contactType ?? this.contactType,
      contactValue: contactValue ?? this.contactValue,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vacancy.present) {
      map['vacancy'] = Variable<int>(vacancy.value);
    }
    if (contactType.present) {
      map['contact_type'] = Variable<int>(
        $ContactsTable.$convertercontactType.toSql(contactType.value),
      );
    }
    if (contactValue.present) {
      map['contact_value'] = Variable<String>(contactValue.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('vacancy: $vacancy, ')
          ..write('contactType: $contactType, ')
          ..write('contactValue: $contactValue, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $StoryItemsTable extends StoryItems
    with TableInfo<$StoryItemsTable, StoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vacancyMeta = const VerificationMeta(
    'vacancy',
  );
  @override
  late final GeneratedColumn<int> vacancy = GeneratedColumn<int>(
    'vacancy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vacancies (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [id, createdAt, vacancy];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('vacancy')) {
      context.handle(
        _vacancyMeta,
        vacancy.isAcceptableOrUnknown(data['vacancy']!, _vacancyMeta),
      );
    } else if (isInserting) {
      context.missing(_vacancyMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  StoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoryItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      vacancy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vacancy'],
      )!,
    );
  }

  @override
  $StoryItemsTable createAlias(String alias) {
    return $StoryItemsTable(attachedDatabase, alias);
  }
}

class StoryItem extends DataClass implements Insertable<StoryItem> {
  final int id;
  final DateTime createdAt;
  final int vacancy;
  const StoryItem({
    required this.id,
    required this.createdAt,
    required this.vacancy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['vacancy'] = Variable<int>(vacancy);
    return map;
  }

  StoryItemsCompanion toCompanion(bool nullToAbsent) {
    return StoryItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      vacancy: Value(vacancy),
    );
  }

  factory StoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoryItem(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      vacancy: serializer.fromJson<int>(json['vacancy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'vacancy': serializer.toJson<int>(vacancy),
    };
  }

  StoryItem copyWith({int? id, DateTime? createdAt, int? vacancy}) => StoryItem(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    vacancy: vacancy ?? this.vacancy,
  );
  StoryItem copyWithCompanion(StoryItemsCompanion data) {
    return StoryItem(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      vacancy: data.vacancy.present ? data.vacancy.value : this.vacancy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoryItem(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('vacancy: $vacancy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, createdAt, vacancy);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoryItem &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.vacancy == this.vacancy);
}

class StoryItemsCompanion extends UpdateCompanion<StoryItem> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<int> vacancy;
  const StoryItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.vacancy = const Value.absent(),
  });
  StoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required int vacancy,
  }) : createdAt = Value(createdAt),
       vacancy = Value(vacancy);
  static Insertable<StoryItem> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? vacancy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (vacancy != null) 'vacancy': vacancy,
    });
  }

  StoryItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<int>? vacancy,
  }) {
    return StoryItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      vacancy: vacancy ?? this.vacancy,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (vacancy.present) {
      map['vacancy'] = Variable<int>(vacancy.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoryItemsCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('vacancy: $vacancy')
          ..write(')'))
        .toString();
  }
}

class $JobDirectionsTable extends JobDirections
    with TableInfo<$JobDirectionsTable, JobDirection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JobDirectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'job_directions';
  @override
  VerificationContext validateIntegrity(
    Insertable<JobDirection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  JobDirection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobDirection(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $JobDirectionsTable createAlias(String alias) {
    return $JobDirectionsTable(attachedDatabase, alias);
  }
}

class JobDirection extends DataClass implements Insertable<JobDirection> {
  final int id;
  final String name;
  const JobDirection({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  JobDirectionsCompanion toCompanion(bool nullToAbsent) {
    return JobDirectionsCompanion(id: Value(id), name: Value(name));
  }

  factory JobDirection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobDirection(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  JobDirection copyWith({int? id, String? name}) =>
      JobDirection(id: id ?? this.id, name: name ?? this.name);
  JobDirection copyWithCompanion(JobDirectionsCompanion data) {
    return JobDirection(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobDirection(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JobDirection && other.id == this.id && other.name == this.name);
}

class JobDirectionsCompanion extends UpdateCompanion<JobDirection> {
  final Value<int> id;
  final Value<String> name;
  const JobDirectionsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
  });
  JobDirectionsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
  }) : name = Value(name);
  static Insertable<JobDirection> custom({
    Expression<int>? id,
    Expression<String>? name,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
    });
  }

  JobDirectionsCompanion copyWith({Value<int>? id, Value<String>? name}) {
    return JobDirectionsCompanion(id: id ?? this.id, name: name ?? this.name);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JobDirectionsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }
}

class $VacancyDirectionsTable extends VacancyDirections
    with TableInfo<$VacancyDirectionsTable, VacancyDirection> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VacancyDirectionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _vacancyMeta = const VerificationMeta(
    'vacancy',
  );
  @override
  late final GeneratedColumn<int> vacancy = GeneratedColumn<int>(
    'vacancy',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vacancies (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _directionMeta = const VerificationMeta(
    'direction',
  );
  @override
  late final GeneratedColumn<int> direction = GeneratedColumn<int>(
    'direction',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES job_directions (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _orderMeta = const VerificationMeta('order');
  @override
  late final GeneratedColumn<int> order = GeneratedColumn<int>(
    'order',
    aliasedName,
    false,
    check: () => ComparableExpr(order).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [vacancy, direction, order];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vacancy_directions';
  @override
  VerificationContext validateIntegrity(
    Insertable<VacancyDirection> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('vacancy')) {
      context.handle(
        _vacancyMeta,
        vacancy.isAcceptableOrUnknown(data['vacancy']!, _vacancyMeta),
      );
    } else if (isInserting) {
      context.missing(_vacancyMeta);
    }
    if (data.containsKey('direction')) {
      context.handle(
        _directionMeta,
        direction.isAcceptableOrUnknown(data['direction']!, _directionMeta),
      );
    } else if (isInserting) {
      context.missing(_directionMeta);
    }
    if (data.containsKey('order')) {
      context.handle(
        _orderMeta,
        order.isAcceptableOrUnknown(data['order']!, _orderMeta),
      );
    } else if (isInserting) {
      context.missing(_orderMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {vacancy, direction};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {vacancy, order},
  ];
  @override
  VacancyDirection map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VacancyDirection(
      vacancy: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}vacancy'],
      )!,
      direction: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}direction'],
      )!,
      order: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}order'],
      )!,
    );
  }

  @override
  $VacancyDirectionsTable createAlias(String alias) {
    return $VacancyDirectionsTable(attachedDatabase, alias);
  }
}

class VacancyDirection extends DataClass
    implements Insertable<VacancyDirection> {
  final int vacancy;
  final int direction;
  final int order;
  const VacancyDirection({
    required this.vacancy,
    required this.direction,
    required this.order,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['vacancy'] = Variable<int>(vacancy);
    map['direction'] = Variable<int>(direction);
    map['order'] = Variable<int>(order);
    return map;
  }

  VacancyDirectionsCompanion toCompanion(bool nullToAbsent) {
    return VacancyDirectionsCompanion(
      vacancy: Value(vacancy),
      direction: Value(direction),
      order: Value(order),
    );
  }

  factory VacancyDirection.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VacancyDirection(
      vacancy: serializer.fromJson<int>(json['vacancy']),
      direction: serializer.fromJson<int>(json['direction']),
      order: serializer.fromJson<int>(json['order']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'vacancy': serializer.toJson<int>(vacancy),
      'direction': serializer.toJson<int>(direction),
      'order': serializer.toJson<int>(order),
    };
  }

  VacancyDirection copyWith({int? vacancy, int? direction, int? order}) =>
      VacancyDirection(
        vacancy: vacancy ?? this.vacancy,
        direction: direction ?? this.direction,
        order: order ?? this.order,
      );
  VacancyDirection copyWithCompanion(VacancyDirectionsCompanion data) {
    return VacancyDirection(
      vacancy: data.vacancy.present ? data.vacancy.value : this.vacancy,
      direction: data.direction.present ? data.direction.value : this.direction,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VacancyDirection(')
          ..write('vacancy: $vacancy, ')
          ..write('direction: $direction, ')
          ..write('order: $order')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(vacancy, direction, order);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VacancyDirection &&
          other.vacancy == this.vacancy &&
          other.direction == this.direction &&
          other.order == this.order);
}

class VacancyDirectionsCompanion extends UpdateCompanion<VacancyDirection> {
  final Value<int> vacancy;
  final Value<int> direction;
  final Value<int> order;
  final Value<int> rowid;
  const VacancyDirectionsCompanion({
    this.vacancy = const Value.absent(),
    this.direction = const Value.absent(),
    this.order = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VacancyDirectionsCompanion.insert({
    required int vacancy,
    required int direction,
    required int order,
    this.rowid = const Value.absent(),
  }) : vacancy = Value(vacancy),
       direction = Value(direction),
       order = Value(order);
  static Insertable<VacancyDirection> custom({
    Expression<int>? vacancy,
    Expression<int>? direction,
    Expression<int>? order,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (vacancy != null) 'vacancy': vacancy,
      if (direction != null) 'direction': direction,
      if (order != null) 'order': order,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VacancyDirectionsCompanion copyWith({
    Value<int>? vacancy,
    Value<int>? direction,
    Value<int>? order,
    Value<int>? rowid,
  }) {
    return VacancyDirectionsCompanion(
      vacancy: vacancy ?? this.vacancy,
      direction: direction ?? this.direction,
      order: order ?? this.order,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (vacancy.present) {
      map['vacancy'] = Variable<int>(vacancy.value);
    }
    if (direction.present) {
      map['direction'] = Variable<int>(direction.value);
    }
    if (order.present) {
      map['order'] = Variable<int>(order.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VacancyDirectionsCompanion(')
          ..write('vacancy: $vacancy, ')
          ..write('direction: $direction, ')
          ..write('order: $order, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $InterviewStoryItemsTable extends InterviewStoryItems
    with TableInfo<$InterviewStoryItemsTable, InterviewStoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $InterviewStoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES story_items (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isOnlineMeta = const VerificationMeta(
    'isOnline',
  );
  @override
  late final GeneratedColumn<bool> isOnline = GeneratedColumn<bool>(
    'is_online',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_online" IN (0, 1))',
    ),
  );
  static const VerificationMeta _targetMeta = const VerificationMeta('target');
  @override
  late final GeneratedColumn<String> target = GeneratedColumn<String>(
    'target',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<InterviewTypes, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<InterviewTypes>($InterviewStoryItemsTable.$convertertype);
  @override
  List<GeneratedColumn> get $columns => [item, time, isOnline, target, type];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'interview_story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<InterviewStoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    } else if (isInserting) {
      context.missing(_timeMeta);
    }
    if (data.containsKey('is_online')) {
      context.handle(
        _isOnlineMeta,
        isOnline.isAcceptableOrUnknown(data['is_online']!, _isOnlineMeta),
      );
    } else if (isInserting) {
      context.missing(_isOnlineMeta);
    }
    if (data.containsKey('target')) {
      context.handle(
        _targetMeta,
        target.isAcceptableOrUnknown(data['target']!, _targetMeta),
      );
    } else if (isInserting) {
      context.missing(_targetMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {item};
  @override
  InterviewStoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return InterviewStoryItem(
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      )!,
      isOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_online'],
      )!,
      target: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target'],
      )!,
      type: $InterviewStoryItemsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
    );
  }

  @override
  $InterviewStoryItemsTable createAlias(String alias) {
    return $InterviewStoryItemsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<InterviewTypes, int, int> $convertertype =
      const EnumIndexConverter<InterviewTypes>(InterviewTypes.values);
}

class InterviewStoryItem extends DataClass
    implements Insertable<InterviewStoryItem> {
  final int item;
  final DateTime time;
  final bool isOnline;
  final String target;
  final InterviewTypes type;
  const InterviewStoryItem({
    required this.item,
    required this.time,
    required this.isOnline,
    required this.target,
    required this.type,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item'] = Variable<int>(item);
    map['time'] = Variable<DateTime>(time);
    map['is_online'] = Variable<bool>(isOnline);
    map['target'] = Variable<String>(target);
    {
      map['type'] = Variable<int>(
        $InterviewStoryItemsTable.$convertertype.toSql(type),
      );
    }
    return map;
  }

  InterviewStoryItemsCompanion toCompanion(bool nullToAbsent) {
    return InterviewStoryItemsCompanion(
      item: Value(item),
      time: Value(time),
      isOnline: Value(isOnline),
      target: Value(target),
      type: Value(type),
    );
  }

  factory InterviewStoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return InterviewStoryItem(
      item: serializer.fromJson<int>(json['item']),
      time: serializer.fromJson<DateTime>(json['time']),
      isOnline: serializer.fromJson<bool>(json['isOnline']),
      target: serializer.fromJson<String>(json['target']),
      type: $InterviewStoryItemsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'item': serializer.toJson<int>(item),
      'time': serializer.toJson<DateTime>(time),
      'isOnline': serializer.toJson<bool>(isOnline),
      'target': serializer.toJson<String>(target),
      'type': serializer.toJson<int>(
        $InterviewStoryItemsTable.$convertertype.toJson(type),
      ),
    };
  }

  InterviewStoryItem copyWith({
    int? item,
    DateTime? time,
    bool? isOnline,
    String? target,
    InterviewTypes? type,
  }) => InterviewStoryItem(
    item: item ?? this.item,
    time: time ?? this.time,
    isOnline: isOnline ?? this.isOnline,
    target: target ?? this.target,
    type: type ?? this.type,
  );
  InterviewStoryItem copyWithCompanion(InterviewStoryItemsCompanion data) {
    return InterviewStoryItem(
      item: data.item.present ? data.item.value : this.item,
      time: data.time.present ? data.time.value : this.time,
      isOnline: data.isOnline.present ? data.isOnline.value : this.isOnline,
      target: data.target.present ? data.target.value : this.target,
      type: data.type.present ? data.type.value : this.type,
    );
  }

  @override
  String toString() {
    return (StringBuffer('InterviewStoryItem(')
          ..write('item: $item, ')
          ..write('time: $time, ')
          ..write('isOnline: $isOnline, ')
          ..write('target: $target, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(item, time, isOnline, target, type);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is InterviewStoryItem &&
          other.item == this.item &&
          other.time == this.time &&
          other.isOnline == this.isOnline &&
          other.target == this.target &&
          other.type == this.type);
}

class InterviewStoryItemsCompanion extends UpdateCompanion<InterviewStoryItem> {
  final Value<int> item;
  final Value<DateTime> time;
  final Value<bool> isOnline;
  final Value<String> target;
  final Value<InterviewTypes> type;
  const InterviewStoryItemsCompanion({
    this.item = const Value.absent(),
    this.time = const Value.absent(),
    this.isOnline = const Value.absent(),
    this.target = const Value.absent(),
    this.type = const Value.absent(),
  });
  InterviewStoryItemsCompanion.insert({
    this.item = const Value.absent(),
    required DateTime time,
    required bool isOnline,
    required String target,
    required InterviewTypes type,
  }) : time = Value(time),
       isOnline = Value(isOnline),
       target = Value(target),
       type = Value(type);
  static Insertable<InterviewStoryItem> custom({
    Expression<int>? item,
    Expression<DateTime>? time,
    Expression<bool>? isOnline,
    Expression<String>? target,
    Expression<int>? type,
  }) {
    return RawValuesInsertable({
      if (item != null) 'item': item,
      if (time != null) 'time': time,
      if (isOnline != null) 'is_online': isOnline,
      if (target != null) 'target': target,
      if (type != null) 'type': type,
    });
  }

  InterviewStoryItemsCompanion copyWith({
    Value<int>? item,
    Value<DateTime>? time,
    Value<bool>? isOnline,
    Value<String>? target,
    Value<InterviewTypes>? type,
  }) {
    return InterviewStoryItemsCompanion(
      item: item ?? this.item,
      time: time ?? this.time,
      isOnline: isOnline ?? this.isOnline,
      target: target ?? this.target,
      type: type ?? this.type,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (isOnline.present) {
      map['is_online'] = Variable<bool>(isOnline.value);
    }
    if (target.present) {
      map['target'] = Variable<String>(target.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $InterviewStoryItemsTable.$convertertype.toSql(type.value),
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('InterviewStoryItemsCompanion(')
          ..write('item: $item, ')
          ..write('time: $time, ')
          ..write('isOnline: $isOnline, ')
          ..write('target: $target, ')
          ..write('type: $type')
          ..write(')'))
        .toString();
  }
}

class $WaitingForFeedbackStoryItemsTable extends WaitingForFeedbackStoryItems
    with
        TableInfo<
          $WaitingForFeedbackStoryItemsTable,
          WaitingForFeedbackStoryItem
        > {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WaitingForFeedbackStoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES story_items (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _timeMeta = const VerificationMeta('time');
  @override
  late final GeneratedColumn<DateTime> time = GeneratedColumn<DateTime>(
    'time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [item, time, comment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'waiting_for_feedback_story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<WaitingForFeedbackStoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('time')) {
      context.handle(
        _timeMeta,
        time.isAcceptableOrUnknown(data['time']!, _timeMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {item};
  @override
  WaitingForFeedbackStoryItem map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WaitingForFeedbackStoryItem(
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      time: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}time'],
      ),
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
    );
  }

  @override
  $WaitingForFeedbackStoryItemsTable createAlias(String alias) {
    return $WaitingForFeedbackStoryItemsTable(attachedDatabase, alias);
  }
}

class WaitingForFeedbackStoryItem extends DataClass
    implements Insertable<WaitingForFeedbackStoryItem> {
  final int item;
  final DateTime? time;
  final String comment;
  const WaitingForFeedbackStoryItem({
    required this.item,
    this.time,
    required this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item'] = Variable<int>(item);
    if (!nullToAbsent || time != null) {
      map['time'] = Variable<DateTime>(time);
    }
    map['comment'] = Variable<String>(comment);
    return map;
  }

  WaitingForFeedbackStoryItemsCompanion toCompanion(bool nullToAbsent) {
    return WaitingForFeedbackStoryItemsCompanion(
      item: Value(item),
      time: time == null && nullToAbsent ? const Value.absent() : Value(time),
      comment: Value(comment),
    );
  }

  factory WaitingForFeedbackStoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WaitingForFeedbackStoryItem(
      item: serializer.fromJson<int>(json['item']),
      time: serializer.fromJson<DateTime?>(json['time']),
      comment: serializer.fromJson<String>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'item': serializer.toJson<int>(item),
      'time': serializer.toJson<DateTime?>(time),
      'comment': serializer.toJson<String>(comment),
    };
  }

  WaitingForFeedbackStoryItem copyWith({
    int? item,
    Value<DateTime?> time = const Value.absent(),
    String? comment,
  }) => WaitingForFeedbackStoryItem(
    item: item ?? this.item,
    time: time.present ? time.value : this.time,
    comment: comment ?? this.comment,
  );
  WaitingForFeedbackStoryItem copyWithCompanion(
    WaitingForFeedbackStoryItemsCompanion data,
  ) {
    return WaitingForFeedbackStoryItem(
      item: data.item.present ? data.item.value : this.item,
      time: data.time.present ? data.time.value : this.time,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WaitingForFeedbackStoryItem(')
          ..write('item: $item, ')
          ..write('time: $time, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(item, time, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WaitingForFeedbackStoryItem &&
          other.item == this.item &&
          other.time == this.time &&
          other.comment == this.comment);
}

class WaitingForFeedbackStoryItemsCompanion
    extends UpdateCompanion<WaitingForFeedbackStoryItem> {
  final Value<int> item;
  final Value<DateTime?> time;
  final Value<String> comment;
  const WaitingForFeedbackStoryItemsCompanion({
    this.item = const Value.absent(),
    this.time = const Value.absent(),
    this.comment = const Value.absent(),
  });
  WaitingForFeedbackStoryItemsCompanion.insert({
    this.item = const Value.absent(),
    this.time = const Value.absent(),
    this.comment = const Value.absent(),
  });
  static Insertable<WaitingForFeedbackStoryItem> custom({
    Expression<int>? item,
    Expression<DateTime>? time,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (item != null) 'item': item,
      if (time != null) 'time': time,
      if (comment != null) 'comment': comment,
    });
  }

  WaitingForFeedbackStoryItemsCompanion copyWith({
    Value<int>? item,
    Value<DateTime?>? time,
    Value<String>? comment,
  }) {
    return WaitingForFeedbackStoryItemsCompanion(
      item: item ?? this.item,
      time: time ?? this.time,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (time.present) {
      map['time'] = Variable<DateTime>(time.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WaitingForFeedbackStoryItemsCompanion(')
          ..write('item: $item, ')
          ..write('time: $time, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $TaskStoryItemsTable extends TaskStoryItems
    with TableInfo<$TaskStoryItemsTable, TaskStoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TaskStoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES story_items (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _deadlineMeta = const VerificationMeta(
    'deadline',
  );
  @override
  late final GeneratedColumn<DateTime> deadline = GeneratedColumn<DateTime>(
    'deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [item, deadline, link, comment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'task_story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<TaskStoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('deadline')) {
      context.handle(
        _deadlineMeta,
        deadline.isAcceptableOrUnknown(data['deadline']!, _deadlineMeta),
      );
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    } else if (isInserting) {
      context.missing(_linkMeta);
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {item};
  @override
  TaskStoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskStoryItem(
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      deadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}deadline'],
      ),
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
    );
  }

  @override
  $TaskStoryItemsTable createAlias(String alias) {
    return $TaskStoryItemsTable(attachedDatabase, alias);
  }
}

class TaskStoryItem extends DataClass implements Insertable<TaskStoryItem> {
  final int item;
  final DateTime? deadline;
  final String link;
  final String comment;
  const TaskStoryItem({
    required this.item,
    this.deadline,
    required this.link,
    required this.comment,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item'] = Variable<int>(item);
    if (!nullToAbsent || deadline != null) {
      map['deadline'] = Variable<DateTime>(deadline);
    }
    map['link'] = Variable<String>(link);
    map['comment'] = Variable<String>(comment);
    return map;
  }

  TaskStoryItemsCompanion toCompanion(bool nullToAbsent) {
    return TaskStoryItemsCompanion(
      item: Value(item),
      deadline: deadline == null && nullToAbsent
          ? const Value.absent()
          : Value(deadline),
      link: Value(link),
      comment: Value(comment),
    );
  }

  factory TaskStoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskStoryItem(
      item: serializer.fromJson<int>(json['item']),
      deadline: serializer.fromJson<DateTime?>(json['deadline']),
      link: serializer.fromJson<String>(json['link']),
      comment: serializer.fromJson<String>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'item': serializer.toJson<int>(item),
      'deadline': serializer.toJson<DateTime?>(deadline),
      'link': serializer.toJson<String>(link),
      'comment': serializer.toJson<String>(comment),
    };
  }

  TaskStoryItem copyWith({
    int? item,
    Value<DateTime?> deadline = const Value.absent(),
    String? link,
    String? comment,
  }) => TaskStoryItem(
    item: item ?? this.item,
    deadline: deadline.present ? deadline.value : this.deadline,
    link: link ?? this.link,
    comment: comment ?? this.comment,
  );
  TaskStoryItem copyWithCompanion(TaskStoryItemsCompanion data) {
    return TaskStoryItem(
      item: data.item.present ? data.item.value : this.item,
      deadline: data.deadline.present ? data.deadline.value : this.deadline,
      link: data.link.present ? data.link.value : this.link,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('TaskStoryItem(')
          ..write('item: $item, ')
          ..write('deadline: $deadline, ')
          ..write('link: $link, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(item, deadline, link, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskStoryItem &&
          other.item == this.item &&
          other.deadline == this.deadline &&
          other.link == this.link &&
          other.comment == this.comment);
}

class TaskStoryItemsCompanion extends UpdateCompanion<TaskStoryItem> {
  final Value<int> item;
  final Value<DateTime?> deadline;
  final Value<String> link;
  final Value<String> comment;
  const TaskStoryItemsCompanion({
    this.item = const Value.absent(),
    this.deadline = const Value.absent(),
    this.link = const Value.absent(),
    this.comment = const Value.absent(),
  });
  TaskStoryItemsCompanion.insert({
    this.item = const Value.absent(),
    this.deadline = const Value.absent(),
    required String link,
    this.comment = const Value.absent(),
  }) : link = Value(link);
  static Insertable<TaskStoryItem> custom({
    Expression<int>? item,
    Expression<DateTime>? deadline,
    Expression<String>? link,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (item != null) 'item': item,
      if (deadline != null) 'deadline': deadline,
      if (link != null) 'link': link,
      if (comment != null) 'comment': comment,
    });
  }

  TaskStoryItemsCompanion copyWith({
    Value<int>? item,
    Value<DateTime?>? deadline,
    Value<String>? link,
    Value<String>? comment,
  }) {
    return TaskStoryItemsCompanion(
      item: item ?? this.item,
      deadline: deadline ?? this.deadline,
      link: link ?? this.link,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (deadline.present) {
      map['deadline'] = Variable<DateTime>(deadline.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TaskStoryItemsCompanion(')
          ..write('item: $item, ')
          ..write('deadline: $deadline, ')
          ..write('link: $link, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $FailureStoryItemsTable extends FailureStoryItems
    with TableInfo<$FailureStoryItemsTable, FailureStoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FailureStoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES story_items (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _commentMeta = const VerificationMeta(
    'comment',
  );
  @override
  late final GeneratedColumn<String> comment = GeneratedColumn<String>(
    'comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  @override
  List<GeneratedColumn> get $columns => [item, comment];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'failure_story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<FailureStoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('comment')) {
      context.handle(
        _commentMeta,
        comment.isAcceptableOrUnknown(data['comment']!, _commentMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {item};
  @override
  FailureStoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FailureStoryItem(
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      comment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}comment'],
      )!,
    );
  }

  @override
  $FailureStoryItemsTable createAlias(String alias) {
    return $FailureStoryItemsTable(attachedDatabase, alias);
  }
}

class FailureStoryItem extends DataClass
    implements Insertable<FailureStoryItem> {
  final int item;
  final String comment;
  const FailureStoryItem({required this.item, required this.comment});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item'] = Variable<int>(item);
    map['comment'] = Variable<String>(comment);
    return map;
  }

  FailureStoryItemsCompanion toCompanion(bool nullToAbsent) {
    return FailureStoryItemsCompanion(
      item: Value(item),
      comment: Value(comment),
    );
  }

  factory FailureStoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FailureStoryItem(
      item: serializer.fromJson<int>(json['item']),
      comment: serializer.fromJson<String>(json['comment']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'item': serializer.toJson<int>(item),
      'comment': serializer.toJson<String>(comment),
    };
  }

  FailureStoryItem copyWith({int? item, String? comment}) => FailureStoryItem(
    item: item ?? this.item,
    comment: comment ?? this.comment,
  );
  FailureStoryItem copyWithCompanion(FailureStoryItemsCompanion data) {
    return FailureStoryItem(
      item: data.item.present ? data.item.value : this.item,
      comment: data.comment.present ? data.comment.value : this.comment,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FailureStoryItem(')
          ..write('item: $item, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(item, comment);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FailureStoryItem &&
          other.item == this.item &&
          other.comment == this.comment);
}

class FailureStoryItemsCompanion extends UpdateCompanion<FailureStoryItem> {
  final Value<int> item;
  final Value<String> comment;
  const FailureStoryItemsCompanion({
    this.item = const Value.absent(),
    this.comment = const Value.absent(),
  });
  FailureStoryItemsCompanion.insert({
    this.item = const Value.absent(),
    this.comment = const Value.absent(),
  });
  static Insertable<FailureStoryItem> custom({
    Expression<int>? item,
    Expression<String>? comment,
  }) {
    return RawValuesInsertable({
      if (item != null) 'item': item,
      if (comment != null) 'comment': comment,
    });
  }

  FailureStoryItemsCompanion copyWith({
    Value<int>? item,
    Value<String>? comment,
  }) {
    return FailureStoryItemsCompanion(
      item: item ?? this.item,
      comment: comment ?? this.comment,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (comment.present) {
      map['comment'] = Variable<String>(comment.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FailureStoryItemsCompanion(')
          ..write('item: $item, ')
          ..write('comment: $comment')
          ..write(')'))
        .toString();
  }
}

class $OfferStoryItemsTable extends OfferStoryItems
    with TableInfo<$OfferStoryItemsTable, OfferStoryItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OfferStoryItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _itemMeta = const VerificationMeta('item');
  @override
  late final GeneratedColumn<int> item = GeneratedColumn<int>(
    'item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES story_items (id) ON DELETE CASCADE DEFERRABLE INITIALLY DEFERRED',
    ),
  );
  static const VerificationMeta _salaryMeta = const VerificationMeta('salary');
  @override
  late final GeneratedColumn<int> salary = GeneratedColumn<int>(
    'salary',
    aliasedName,
    false,
    check: () => ComparableExpr(salary).isBiggerOrEqualValue(0),
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [item, salary];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'offer_story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<OfferStoryItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('item')) {
      context.handle(
        _itemMeta,
        item.isAcceptableOrUnknown(data['item']!, _itemMeta),
      );
    }
    if (data.containsKey('salary')) {
      context.handle(
        _salaryMeta,
        salary.isAcceptableOrUnknown(data['salary']!, _salaryMeta),
      );
    } else if (isInserting) {
      context.missing(_salaryMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {item};
  @override
  OfferStoryItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OfferStoryItem(
      item: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}item'],
      )!,
      salary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}salary'],
      )!,
    );
  }

  @override
  $OfferStoryItemsTable createAlias(String alias) {
    return $OfferStoryItemsTable(attachedDatabase, alias);
  }
}

class OfferStoryItem extends DataClass implements Insertable<OfferStoryItem> {
  final int item;
  final int salary;
  const OfferStoryItem({required this.item, required this.salary});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['item'] = Variable<int>(item);
    map['salary'] = Variable<int>(salary);
    return map;
  }

  OfferStoryItemsCompanion toCompanion(bool nullToAbsent) {
    return OfferStoryItemsCompanion(item: Value(item), salary: Value(salary));
  }

  factory OfferStoryItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OfferStoryItem(
      item: serializer.fromJson<int>(json['item']),
      salary: serializer.fromJson<int>(json['salary']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'item': serializer.toJson<int>(item),
      'salary': serializer.toJson<int>(salary),
    };
  }

  OfferStoryItem copyWith({int? item, int? salary}) =>
      OfferStoryItem(item: item ?? this.item, salary: salary ?? this.salary);
  OfferStoryItem copyWithCompanion(OfferStoryItemsCompanion data) {
    return OfferStoryItem(
      item: data.item.present ? data.item.value : this.item,
      salary: data.salary.present ? data.salary.value : this.salary,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OfferStoryItem(')
          ..write('item: $item, ')
          ..write('salary: $salary')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(item, salary);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OfferStoryItem &&
          other.item == this.item &&
          other.salary == this.salary);
}

class OfferStoryItemsCompanion extends UpdateCompanion<OfferStoryItem> {
  final Value<int> item;
  final Value<int> salary;
  const OfferStoryItemsCompanion({
    this.item = const Value.absent(),
    this.salary = const Value.absent(),
  });
  OfferStoryItemsCompanion.insert({
    this.item = const Value.absent(),
    required int salary,
  }) : salary = Value(salary);
  static Insertable<OfferStoryItem> custom({
    Expression<int>? item,
    Expression<int>? salary,
  }) {
    return RawValuesInsertable({
      if (item != null) 'item': item,
      if (salary != null) 'salary': salary,
    });
  }

  OfferStoryItemsCompanion copyWith({Value<int>? item, Value<int>? salary}) {
    return OfferStoryItemsCompanion(
      item: item ?? this.item,
      salary: salary ?? this.salary,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (item.present) {
      map['item'] = Variable<int>(item.value);
    }
    if (salary.present) {
      map['salary'] = Variable<int>(salary.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OfferStoryItemsCompanion(')
          ..write('item: $item, ')
          ..write('salary: $salary')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CompaniesTable companies = $CompaniesTable(this);
  late final $VacanciesTable vacancies = $VacanciesTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $StoryItemsTable storyItems = $StoryItemsTable(this);
  late final $JobDirectionsTable jobDirections = $JobDirectionsTable(this);
  late final $VacancyDirectionsTable vacancyDirections =
      $VacancyDirectionsTable(this);
  late final $InterviewStoryItemsTable interviewStoryItems =
      $InterviewStoryItemsTable(this);
  late final $WaitingForFeedbackStoryItemsTable waitingForFeedbackStoryItems =
      $WaitingForFeedbackStoryItemsTable(this);
  late final $TaskStoryItemsTable taskStoryItems = $TaskStoryItemsTable(this);
  late final $FailureStoryItemsTable failureStoryItems =
      $FailureStoryItemsTable(this);
  late final $OfferStoryItemsTable offerStoryItems = $OfferStoryItemsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    companies,
    vacancies,
    contacts,
    storyItems,
    jobDirections,
    vacancyDirections,
    interviewStoryItems,
    waitingForFeedbackStoryItems,
    taskStoryItems,
    failureStoryItems,
    offerStoryItems,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'companies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vacancies', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vacancies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('contacts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vacancies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('story_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vacancies',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vacancy_directions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'job_directions',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('vacancy_directions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'story_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('interview_story_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'story_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [
        TableUpdate(
          'waiting_for_feedback_story_items',
          kind: UpdateKind.delete,
        ),
      ],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'story_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('task_story_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'story_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('failure_story_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'story_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('offer_story_items', kind: UpdateKind.delete)],
    ),
  ]);
  @override
  DriftDatabaseOptions get options =>
      const DriftDatabaseOptions(storeDateTimeAsText: true);
}

typedef $$CompaniesTableCreateCompanionBuilder =
    CompaniesCompanion Function({
      Value<int> id,
      required String name,
      required bool isIT,
      Value<String> comment,
      required ISet<String> links,
    });
typedef $$CompaniesTableUpdateCompanionBuilder =
    CompaniesCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<bool> isIT,
      Value<String> comment,
      Value<ISet<String>> links,
    });

final class $$CompaniesTableReferences
    extends BaseReferences<_$AppDatabase, $CompaniesTable, Company> {
  $$CompaniesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VacanciesTable, List<Vacancy>>
  _vacanciesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.vacancies,
    aliasName: $_aliasNameGenerator(db.companies.id, db.vacancies.company),
  );

  $$VacanciesTableProcessedTableManager get vacanciesRefs {
    final manager = $$VacanciesTableTableManager(
      $_db,
      $_db.vacancies,
    ).filter((f) => f.company.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_vacanciesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CompaniesTableFilterComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isIT => $composableBuilder(
    column: $table.isIT,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<ISet<String>> get links => $composableBuilder(
    column: $table.links,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vacanciesRefs(
    Expression<bool> Function($$VacanciesTableFilterComposer f) f,
  ) {
    final $$VacanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.company,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableFilterComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableOrderingComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isIT => $composableBuilder(
    column: $table.isIT,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<ISet<String>> get links => $composableBuilder(
    column: $table.links,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CompaniesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CompaniesTable> {
  $$CompaniesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<bool> get isIT =>
      $composableBuilder(column: $table.isIT, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<ISet<String>> get links =>
      $composableBuilder(column: $table.links, builder: (column) => column);

  Expression<T> vacanciesRefs<T extends Object>(
    Expression<T> Function($$VacanciesTableAnnotationComposer a) f,
  ) {
    final $$VacanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.company,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CompaniesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CompaniesTable,
          Company,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (Company, $$CompaniesTableReferences),
          Company,
          PrefetchHooks Function({bool vacanciesRefs})
        > {
  $$CompaniesTableTableManager(_$AppDatabase db, $CompaniesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CompaniesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CompaniesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CompaniesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<bool> isIT = const Value.absent(),
                Value<String> comment = const Value.absent(),
                Value<ISet<String>> links = const Value.absent(),
              }) => CompaniesCompanion(
                id: id,
                name: name,
                isIT: isIT,
                comment: comment,
                links: links,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                required bool isIT,
                Value<String> comment = const Value.absent(),
                required ISet<String> links,
              }) => CompaniesCompanion.insert(
                id: id,
                name: name,
                isIT: isIT,
                comment: comment,
                links: links,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$CompaniesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vacanciesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (vacanciesRefs) db.vacancies],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vacanciesRefs)
                    await $_getPrefetchedData<
                      Company,
                      $CompaniesTable,
                      Vacancy
                    >(
                      currentTable: table,
                      referencedTable: $$CompaniesTableReferences
                          ._vacanciesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CompaniesTableReferences(
                            db,
                            table,
                            p0,
                          ).vacanciesRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.company == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CompaniesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CompaniesTable,
      Company,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (Company, $$CompaniesTableReferences),
      Company,
      PrefetchHooks Function({bool vacanciesRefs})
    >;
typedef $$VacanciesTableCreateCompanionBuilder =
    VacanciesCompanion Function({
      Value<int> id,
      required String link,
      Value<String> comment,
      required int company,
      required ISet<JobGrades> grades,
    });
typedef $$VacanciesTableUpdateCompanionBuilder =
    VacanciesCompanion Function({
      Value<int> id,
      Value<String> link,
      Value<String> comment,
      Value<int> company,
      Value<ISet<JobGrades>> grades,
    });

final class $$VacanciesTableReferences
    extends BaseReferences<_$AppDatabase, $VacanciesTable, Vacancy> {
  $$VacanciesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CompaniesTable _companyTable(_$AppDatabase db) => db.companies
      .createAlias($_aliasNameGenerator(db.vacancies.company, db.companies.id));

  $$CompaniesTableProcessedTableManager get company {
    final $_column = $_itemColumn<int>('company')!;

    final manager = $$CompaniesTableTableManager(
      $_db,
      $_db.companies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_companyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$ContactsTable, List<Contact>> _contactsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.contacts,
    aliasName: $_aliasNameGenerator(db.vacancies.id, db.contacts.vacancy),
  );

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager(
      $_db,
      $_db.contacts,
    ).filter((f) => f.vacancy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$StoryItemsTable, List<StoryItem>>
  _storyItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.storyItems,
    aliasName: $_aliasNameGenerator(db.vacancies.id, db.storyItems.vacancy),
  );

  $$StoryItemsTableProcessedTableManager get storyItemsRefs {
    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.vacancy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_storyItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$VacancyDirectionsTable, List<VacancyDirection>>
  _vacancyDirectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vacancyDirections,
        aliasName: $_aliasNameGenerator(
          db.vacancies.id,
          db.vacancyDirections.vacancy,
        ),
      );

  $$VacancyDirectionsTableProcessedTableManager get vacancyDirectionsRefs {
    final manager = $$VacancyDirectionsTableTableManager(
      $_db,
      $_db.vacancyDirections,
    ).filter((f) => f.vacancy.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vacancyDirectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VacanciesTableFilterComposer
    extends Composer<_$AppDatabase, $VacanciesTable> {
  $$VacanciesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<ISet<JobGrades>> get grades => $composableBuilder(
    column: $table.grades,
    builder: (column) => ColumnFilters(column),
  );

  $$CompaniesTableFilterComposer get company {
    final $$CompaniesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.company,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableFilterComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> contactsRefs(
    Expression<bool> Function($$ContactsTableFilterComposer f) f,
  ) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.vacancy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableFilterComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> storyItemsRefs(
    Expression<bool> Function($$StoryItemsTableFilterComposer f) f,
  ) {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.vacancy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> vacancyDirectionsRefs(
    Expression<bool> Function($$VacancyDirectionsTableFilterComposer f) f,
  ) {
    final $$VacancyDirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vacancyDirections,
      getReferencedColumn: (t) => t.vacancy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacancyDirectionsTableFilterComposer(
            $db: $db,
            $table: $db.vacancyDirections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VacanciesTableOrderingComposer
    extends Composer<_$AppDatabase, $VacanciesTable> {
  $$VacanciesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<ISet<JobGrades>> get grades => $composableBuilder(
    column: $table.grades,
    builder: (column) => ColumnOrderings(column),
  );

  $$CompaniesTableOrderingComposer get company {
    final $$CompaniesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.company,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableOrderingComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VacanciesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VacanciesTable> {
  $$VacanciesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  GeneratedColumn<ISet<JobGrades>> get grades =>
      $composableBuilder(column: $table.grades, builder: (column) => column);

  $$CompaniesTableAnnotationComposer get company {
    final $$CompaniesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.company,
      referencedTable: $db.companies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CompaniesTableAnnotationComposer(
            $db: $db,
            $table: $db.companies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> contactsRefs<T extends Object>(
    Expression<T> Function($$ContactsTableAnnotationComposer a) f,
  ) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.contacts,
      getReferencedColumn: (t) => t.vacancy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ContactsTableAnnotationComposer(
            $db: $db,
            $table: $db.contacts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> storyItemsRefs<T extends Object>(
    Expression<T> Function($$StoryItemsTableAnnotationComposer a) f,
  ) {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.vacancy,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> vacancyDirectionsRefs<T extends Object>(
    Expression<T> Function($$VacancyDirectionsTableAnnotationComposer a) f,
  ) {
    final $$VacancyDirectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vacancyDirections,
          getReferencedColumn: (t) => t.vacancy,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VacancyDirectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.vacancyDirections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$VacanciesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VacanciesTable,
          Vacancy,
          $$VacanciesTableFilterComposer,
          $$VacanciesTableOrderingComposer,
          $$VacanciesTableAnnotationComposer,
          $$VacanciesTableCreateCompanionBuilder,
          $$VacanciesTableUpdateCompanionBuilder,
          (Vacancy, $$VacanciesTableReferences),
          Vacancy,
          PrefetchHooks Function({
            bool company,
            bool contactsRefs,
            bool storyItemsRefs,
            bool vacancyDirectionsRefs,
          })
        > {
  $$VacanciesTableTableManager(_$AppDatabase db, $VacanciesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VacanciesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VacanciesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VacanciesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<String> comment = const Value.absent(),
                Value<int> company = const Value.absent(),
                Value<ISet<JobGrades>> grades = const Value.absent(),
              }) => VacanciesCompanion(
                id: id,
                link: link,
                comment: comment,
                company: company,
                grades: grades,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String link,
                Value<String> comment = const Value.absent(),
                required int company,
                required ISet<JobGrades> grades,
              }) => VacanciesCompanion.insert(
                id: id,
                link: link,
                comment: comment,
                company: company,
                grades: grades,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VacanciesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                company = false,
                contactsRefs = false,
                storyItemsRefs = false,
                vacancyDirectionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (contactsRefs) db.contacts,
                    if (storyItemsRefs) db.storyItems,
                    if (vacancyDirectionsRefs) db.vacancyDirections,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (company) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.company,
                                    referencedTable: $$VacanciesTableReferences
                                        ._companyTable(db),
                                    referencedColumn: $$VacanciesTableReferences
                                        ._companyTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (contactsRefs)
                        await $_getPrefetchedData<
                          Vacancy,
                          $VacanciesTable,
                          Contact
                        >(
                          currentTable: table,
                          referencedTable: $$VacanciesTableReferences
                              ._contactsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VacanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).contactsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vacancy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (storyItemsRefs)
                        await $_getPrefetchedData<
                          Vacancy,
                          $VacanciesTable,
                          StoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$VacanciesTableReferences
                              ._storyItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VacanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).storyItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vacancy == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (vacancyDirectionsRefs)
                        await $_getPrefetchedData<
                          Vacancy,
                          $VacanciesTable,
                          VacancyDirection
                        >(
                          currentTable: table,
                          referencedTable: $$VacanciesTableReferences
                              ._vacancyDirectionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VacanciesTableReferences(
                                db,
                                table,
                                p0,
                              ).vacancyDirectionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vacancy == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VacanciesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VacanciesTable,
      Vacancy,
      $$VacanciesTableFilterComposer,
      $$VacanciesTableOrderingComposer,
      $$VacanciesTableAnnotationComposer,
      $$VacanciesTableCreateCompanionBuilder,
      $$VacanciesTableUpdateCompanionBuilder,
      (Vacancy, $$VacanciesTableReferences),
      Vacancy,
      PrefetchHooks Function({
        bool company,
        bool contactsRefs,
        bool storyItemsRefs,
        bool vacancyDirectionsRefs,
      })
    >;
typedef $$ContactsTableCreateCompanionBuilder =
    ContactsCompanion Function({
      required int vacancy,
      required ContactTypes contactType,
      required String contactValue,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> vacancy,
      Value<ContactTypes> contactType,
      Value<String> contactValue,
      Value<int> rowid,
    });

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VacanciesTable _vacancyTable(_$AppDatabase db) => db.vacancies
      .createAlias($_aliasNameGenerator(db.contacts.vacancy, db.vacancies.id));

  $$VacanciesTableProcessedTableManager get vacancy {
    final $_column = $_itemColumn<int>('vacancy')!;

    final manager = $$VacanciesTableTableManager(
      $_db,
      $_db.vacancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vacancyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnWithTypeConverterFilters<ContactTypes, ContactTypes, int>
  get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get contactValue => $composableBuilder(
    column: $table.contactValue,
    builder: (column) => ColumnFilters(column),
  );

  $$VacanciesTableFilterComposer get vacancy {
    final $$VacanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableFilterComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get contactType => $composableBuilder(
    column: $table.contactType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get contactValue => $composableBuilder(
    column: $table.contactValue,
    builder: (column) => ColumnOrderings(column),
  );

  $$VacanciesTableOrderingComposer get vacancy {
    final $$VacanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableOrderingComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumnWithTypeConverter<ContactTypes, int> get contactType =>
      $composableBuilder(
        column: $table.contactType,
        builder: (column) => column,
      );

  GeneratedColumn<String> get contactValue => $composableBuilder(
    column: $table.contactValue,
    builder: (column) => column,
  );

  $$VacanciesTableAnnotationComposer get vacancy {
    final $$VacanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ContactsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ContactsTable,
          Contact,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (Contact, $$ContactsTableReferences),
          Contact,
          PrefetchHooks Function({bool vacancy})
        > {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> vacancy = const Value.absent(),
                Value<ContactTypes> contactType = const Value.absent(),
                Value<String> contactValue = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion(
                vacancy: vacancy,
                contactType: contactType,
                contactValue: contactValue,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int vacancy,
                required ContactTypes contactType,
                required String contactValue,
                Value<int> rowid = const Value.absent(),
              }) => ContactsCompanion.insert(
                vacancy: vacancy,
                contactType: contactType,
                contactValue: contactValue,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ContactsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vacancy = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vacancy) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vacancy,
                                referencedTable: $$ContactsTableReferences
                                    ._vacancyTable(db),
                                referencedColumn: $$ContactsTableReferences
                                    ._vacancyTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ContactsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ContactsTable,
      Contact,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (Contact, $$ContactsTableReferences),
      Contact,
      PrefetchHooks Function({bool vacancy})
    >;
typedef $$StoryItemsTableCreateCompanionBuilder =
    StoryItemsCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      required int vacancy,
    });
typedef $$StoryItemsTableUpdateCompanionBuilder =
    StoryItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<int> vacancy,
    });

final class $$StoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $StoryItemsTable, StoryItem> {
  $$StoryItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VacanciesTable _vacancyTable(_$AppDatabase db) =>
      db.vacancies.createAlias(
        $_aliasNameGenerator(db.storyItems.vacancy, db.vacancies.id),
      );

  $$VacanciesTableProcessedTableManager get vacancy {
    final $_column = $_itemColumn<int>('vacancy')!;

    final manager = $$VacanciesTableTableManager(
      $_db,
      $_db.vacancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vacancyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<
    $InterviewStoryItemsTable,
    List<InterviewStoryItem>
  >
  _interviewStoryItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.interviewStoryItems,
        aliasName: $_aliasNameGenerator(
          db.storyItems.id,
          db.interviewStoryItems.item,
        ),
      );

  $$InterviewStoryItemsTableProcessedTableManager get interviewStoryItemsRefs {
    final manager = $$InterviewStoryItemsTableTableManager(
      $_db,
      $_db.interviewStoryItems,
    ).filter((f) => f.item.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _interviewStoryItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $WaitingForFeedbackStoryItemsTable,
    List<WaitingForFeedbackStoryItem>
  >
  _waitingForFeedbackStoryItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.waitingForFeedbackStoryItems,
        aliasName: $_aliasNameGenerator(
          db.storyItems.id,
          db.waitingForFeedbackStoryItems.item,
        ),
      );

  $$WaitingForFeedbackStoryItemsTableProcessedTableManager
  get waitingForFeedbackStoryItemsRefs {
    final manager = $$WaitingForFeedbackStoryItemsTableTableManager(
      $_db,
      $_db.waitingForFeedbackStoryItems,
    ).filter((f) => f.item.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _waitingForFeedbackStoryItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TaskStoryItemsTable, List<TaskStoryItem>>
  _taskStoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.taskStoryItems,
    aliasName: $_aliasNameGenerator(db.storyItems.id, db.taskStoryItems.item),
  );

  $$TaskStoryItemsTableProcessedTableManager get taskStoryItemsRefs {
    final manager = $$TaskStoryItemsTableTableManager(
      $_db,
      $_db.taskStoryItems,
    ).filter((f) => f.item.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_taskStoryItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$FailureStoryItemsTable, List<FailureStoryItem>>
  _failureStoryItemsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.failureStoryItems,
        aliasName: $_aliasNameGenerator(
          db.storyItems.id,
          db.failureStoryItems.item,
        ),
      );

  $$FailureStoryItemsTableProcessedTableManager get failureStoryItemsRefs {
    final manager = $$FailureStoryItemsTableTableManager(
      $_db,
      $_db.failureStoryItems,
    ).filter((f) => f.item.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _failureStoryItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$OfferStoryItemsTable, List<OfferStoryItem>>
  _offerStoryItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.offerStoryItems,
    aliasName: $_aliasNameGenerator(db.storyItems.id, db.offerStoryItems.item),
  );

  $$OfferStoryItemsTableProcessedTableManager get offerStoryItemsRefs {
    final manager = $$OfferStoryItemsTableTableManager(
      $_db,
      $_db.offerStoryItems,
    ).filter((f) => f.item.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _offerStoryItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$StoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $StoryItemsTable> {
  $$StoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$VacanciesTableFilterComposer get vacancy {
    final $$VacanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableFilterComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> interviewStoryItemsRefs(
    Expression<bool> Function($$InterviewStoryItemsTableFilterComposer f) f,
  ) {
    final $$InterviewStoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.interviewStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$InterviewStoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.interviewStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> waitingForFeedbackStoryItemsRefs(
    Expression<bool> Function(
      $$WaitingForFeedbackStoryItemsTableFilterComposer f,
    )
    f,
  ) {
    final $$WaitingForFeedbackStoryItemsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.waitingForFeedbackStoryItems,
          getReferencedColumn: (t) => t.item,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WaitingForFeedbackStoryItemsTableFilterComposer(
                $db: $db,
                $table: $db.waitingForFeedbackStoryItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<bool> taskStoryItemsRefs(
    Expression<bool> Function($$TaskStoryItemsTableFilterComposer f) f,
  ) {
    final $$TaskStoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskStoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.taskStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> failureStoryItemsRefs(
    Expression<bool> Function($$FailureStoryItemsTableFilterComposer f) f,
  ) {
    final $$FailureStoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.failureStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FailureStoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.failureStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> offerStoryItemsRefs(
    Expression<bool> Function($$OfferStoryItemsTableFilterComposer f) f,
  ) {
    final $$OfferStoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.offerStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfferStoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.offerStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $StoryItemsTable> {
  $$StoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$VacanciesTableOrderingComposer get vacancy {
    final $$VacanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableOrderingComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$StoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $StoryItemsTable> {
  $$StoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$VacanciesTableAnnotationComposer get vacancy {
    final $$VacanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> interviewStoryItemsRefs<T extends Object>(
    Expression<T> Function($$InterviewStoryItemsTableAnnotationComposer a) f,
  ) {
    final $$InterviewStoryItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.interviewStoryItems,
          getReferencedColumn: (t) => t.item,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$InterviewStoryItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.interviewStoryItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> waitingForFeedbackStoryItemsRefs<T extends Object>(
    Expression<T> Function(
      $$WaitingForFeedbackStoryItemsTableAnnotationComposer a,
    )
    f,
  ) {
    final $$WaitingForFeedbackStoryItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.waitingForFeedbackStoryItems,
          getReferencedColumn: (t) => t.item,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$WaitingForFeedbackStoryItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.waitingForFeedbackStoryItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> taskStoryItemsRefs<T extends Object>(
    Expression<T> Function($$TaskStoryItemsTableAnnotationComposer a) f,
  ) {
    final $$TaskStoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.taskStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TaskStoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.taskStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> failureStoryItemsRefs<T extends Object>(
    Expression<T> Function($$FailureStoryItemsTableAnnotationComposer a) f,
  ) {
    final $$FailureStoryItemsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.failureStoryItems,
          getReferencedColumn: (t) => t.item,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FailureStoryItemsTableAnnotationComposer(
                $db: $db,
                $table: $db.failureStoryItems,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> offerStoryItemsRefs<T extends Object>(
    Expression<T> Function($$OfferStoryItemsTableAnnotationComposer a) f,
  ) {
    final $$OfferStoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.offerStoryItems,
      getReferencedColumn: (t) => t.item,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OfferStoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.offerStoryItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$StoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoryItemsTable,
          StoryItem,
          $$StoryItemsTableFilterComposer,
          $$StoryItemsTableOrderingComposer,
          $$StoryItemsTableAnnotationComposer,
          $$StoryItemsTableCreateCompanionBuilder,
          $$StoryItemsTableUpdateCompanionBuilder,
          (StoryItem, $$StoryItemsTableReferences),
          StoryItem,
          PrefetchHooks Function({
            bool vacancy,
            bool interviewStoryItemsRefs,
            bool waitingForFeedbackStoryItemsRefs,
            bool taskStoryItemsRefs,
            bool failureStoryItemsRefs,
            bool offerStoryItemsRefs,
          })
        > {
  $$StoryItemsTableTableManager(_$AppDatabase db, $StoryItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$StoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$StoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$StoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> vacancy = const Value.absent(),
              }) => StoryItemsCompanion(
                id: id,
                createdAt: createdAt,
                vacancy: vacancy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                required int vacancy,
              }) => StoryItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                vacancy: vacancy,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$StoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                vacancy = false,
                interviewStoryItemsRefs = false,
                waitingForFeedbackStoryItemsRefs = false,
                taskStoryItemsRefs = false,
                failureStoryItemsRefs = false,
                offerStoryItemsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (interviewStoryItemsRefs) db.interviewStoryItems,
                    if (waitingForFeedbackStoryItemsRefs)
                      db.waitingForFeedbackStoryItems,
                    if (taskStoryItemsRefs) db.taskStoryItems,
                    if (failureStoryItemsRefs) db.failureStoryItems,
                    if (offerStoryItemsRefs) db.offerStoryItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (vacancy) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.vacancy,
                                    referencedTable: $$StoryItemsTableReferences
                                        ._vacancyTable(db),
                                    referencedColumn:
                                        $$StoryItemsTableReferences
                                            ._vacancyTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (interviewStoryItemsRefs)
                        await $_getPrefetchedData<
                          StoryItem,
                          $StoryItemsTable,
                          InterviewStoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$StoryItemsTableReferences
                              ._interviewStoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).interviewStoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.item == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (waitingForFeedbackStoryItemsRefs)
                        await $_getPrefetchedData<
                          StoryItem,
                          $StoryItemsTable,
                          WaitingForFeedbackStoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$StoryItemsTableReferences
                              ._waitingForFeedbackStoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).waitingForFeedbackStoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.item == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (taskStoryItemsRefs)
                        await $_getPrefetchedData<
                          StoryItem,
                          $StoryItemsTable,
                          TaskStoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$StoryItemsTableReferences
                              ._taskStoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).taskStoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.item == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (failureStoryItemsRefs)
                        await $_getPrefetchedData<
                          StoryItem,
                          $StoryItemsTable,
                          FailureStoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$StoryItemsTableReferences
                              ._failureStoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).failureStoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.item == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (offerStoryItemsRefs)
                        await $_getPrefetchedData<
                          StoryItem,
                          $StoryItemsTable,
                          OfferStoryItem
                        >(
                          currentTable: table,
                          referencedTable: $$StoryItemsTableReferences
                              ._offerStoryItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$StoryItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).offerStoryItemsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.item == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$StoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoryItemsTable,
      StoryItem,
      $$StoryItemsTableFilterComposer,
      $$StoryItemsTableOrderingComposer,
      $$StoryItemsTableAnnotationComposer,
      $$StoryItemsTableCreateCompanionBuilder,
      $$StoryItemsTableUpdateCompanionBuilder,
      (StoryItem, $$StoryItemsTableReferences),
      StoryItem,
      PrefetchHooks Function({
        bool vacancy,
        bool interviewStoryItemsRefs,
        bool waitingForFeedbackStoryItemsRefs,
        bool taskStoryItemsRefs,
        bool failureStoryItemsRefs,
        bool offerStoryItemsRefs,
      })
    >;
typedef $$JobDirectionsTableCreateCompanionBuilder =
    JobDirectionsCompanion Function({Value<int> id, required String name});
typedef $$JobDirectionsTableUpdateCompanionBuilder =
    JobDirectionsCompanion Function({Value<int> id, Value<String> name});

final class $$JobDirectionsTableReferences
    extends BaseReferences<_$AppDatabase, $JobDirectionsTable, JobDirection> {
  $$JobDirectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VacancyDirectionsTable, List<VacancyDirection>>
  _vacancyDirectionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.vacancyDirections,
        aliasName: $_aliasNameGenerator(
          db.jobDirections.id,
          db.vacancyDirections.direction,
        ),
      );

  $$VacancyDirectionsTableProcessedTableManager get vacancyDirectionsRefs {
    final manager = $$VacancyDirectionsTableTableManager(
      $_db,
      $_db.vacancyDirections,
    ).filter((f) => f.direction.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _vacancyDirectionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$JobDirectionsTableFilterComposer
    extends Composer<_$AppDatabase, $JobDirectionsTable> {
  $$JobDirectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> vacancyDirectionsRefs(
    Expression<bool> Function($$VacancyDirectionsTableFilterComposer f) f,
  ) {
    final $$VacancyDirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.vacancyDirections,
      getReferencedColumn: (t) => t.direction,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacancyDirectionsTableFilterComposer(
            $db: $db,
            $table: $db.vacancyDirections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$JobDirectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $JobDirectionsTable> {
  $$JobDirectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JobDirectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $JobDirectionsTable> {
  $$JobDirectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> vacancyDirectionsRefs<T extends Object>(
    Expression<T> Function($$VacancyDirectionsTableAnnotationComposer a) f,
  ) {
    final $$VacancyDirectionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.vacancyDirections,
          getReferencedColumn: (t) => t.direction,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$VacancyDirectionsTableAnnotationComposer(
                $db: $db,
                $table: $db.vacancyDirections,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$JobDirectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JobDirectionsTable,
          JobDirection,
          $$JobDirectionsTableFilterComposer,
          $$JobDirectionsTableOrderingComposer,
          $$JobDirectionsTableAnnotationComposer,
          $$JobDirectionsTableCreateCompanionBuilder,
          $$JobDirectionsTableUpdateCompanionBuilder,
          (JobDirection, $$JobDirectionsTableReferences),
          JobDirection,
          PrefetchHooks Function({bool vacancyDirectionsRefs})
        > {
  $$JobDirectionsTableTableManager(_$AppDatabase db, $JobDirectionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JobDirectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JobDirectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$JobDirectionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
              }) => JobDirectionsCompanion(id: id, name: name),
          createCompanionCallback:
              ({Value<int> id = const Value.absent(), required String name}) =>
                  JobDirectionsCompanion.insert(id: id, name: name),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$JobDirectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vacancyDirectionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (vacancyDirectionsRefs) db.vacancyDirections,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (vacancyDirectionsRefs)
                    await $_getPrefetchedData<
                      JobDirection,
                      $JobDirectionsTable,
                      VacancyDirection
                    >(
                      currentTable: table,
                      referencedTable: $$JobDirectionsTableReferences
                          ._vacancyDirectionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$JobDirectionsTableReferences(
                            db,
                            table,
                            p0,
                          ).vacancyDirectionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.direction == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$JobDirectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JobDirectionsTable,
      JobDirection,
      $$JobDirectionsTableFilterComposer,
      $$JobDirectionsTableOrderingComposer,
      $$JobDirectionsTableAnnotationComposer,
      $$JobDirectionsTableCreateCompanionBuilder,
      $$JobDirectionsTableUpdateCompanionBuilder,
      (JobDirection, $$JobDirectionsTableReferences),
      JobDirection,
      PrefetchHooks Function({bool vacancyDirectionsRefs})
    >;
typedef $$VacancyDirectionsTableCreateCompanionBuilder =
    VacancyDirectionsCompanion Function({
      required int vacancy,
      required int direction,
      required int order,
      Value<int> rowid,
    });
typedef $$VacancyDirectionsTableUpdateCompanionBuilder =
    VacancyDirectionsCompanion Function({
      Value<int> vacancy,
      Value<int> direction,
      Value<int> order,
      Value<int> rowid,
    });

final class $$VacancyDirectionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $VacancyDirectionsTable,
          VacancyDirection
        > {
  $$VacancyDirectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $VacanciesTable _vacancyTable(_$AppDatabase db) =>
      db.vacancies.createAlias(
        $_aliasNameGenerator(db.vacancyDirections.vacancy, db.vacancies.id),
      );

  $$VacanciesTableProcessedTableManager get vacancy {
    final $_column = $_itemColumn<int>('vacancy')!;

    final manager = $$VacanciesTableTableManager(
      $_db,
      $_db.vacancies,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vacancyTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $JobDirectionsTable _directionTable(_$AppDatabase db) =>
      db.jobDirections.createAlias(
        $_aliasNameGenerator(
          db.vacancyDirections.direction,
          db.jobDirections.id,
        ),
      );

  $$JobDirectionsTableProcessedTableManager get direction {
    final $_column = $_itemColumn<int>('direction')!;

    final manager = $$JobDirectionsTableTableManager(
      $_db,
      $_db.jobDirections,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_directionTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$VacancyDirectionsTableFilterComposer
    extends Composer<_$AppDatabase, $VacancyDirectionsTable> {
  $$VacancyDirectionsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnFilters(column),
  );

  $$VacanciesTableFilterComposer get vacancy {
    final $$VacanciesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableFilterComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobDirectionsTableFilterComposer get direction {
    final $$JobDirectionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.direction,
      referencedTable: $db.jobDirections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobDirectionsTableFilterComposer(
            $db: $db,
            $table: $db.jobDirections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VacancyDirectionsTableOrderingComposer
    extends Composer<_$AppDatabase, $VacancyDirectionsTable> {
  $$VacancyDirectionsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get order => $composableBuilder(
    column: $table.order,
    builder: (column) => ColumnOrderings(column),
  );

  $$VacanciesTableOrderingComposer get vacancy {
    final $$VacanciesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableOrderingComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobDirectionsTableOrderingComposer get direction {
    final $$JobDirectionsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.direction,
      referencedTable: $db.jobDirections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobDirectionsTableOrderingComposer(
            $db: $db,
            $table: $db.jobDirections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VacancyDirectionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $VacancyDirectionsTable> {
  $$VacancyDirectionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get order =>
      $composableBuilder(column: $table.order, builder: (column) => column);

  $$VacanciesTableAnnotationComposer get vacancy {
    final $$VacanciesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vacancy,
      referencedTable: $db.vacancies,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VacanciesTableAnnotationComposer(
            $db: $db,
            $table: $db.vacancies,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$JobDirectionsTableAnnotationComposer get direction {
    final $$JobDirectionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.direction,
      referencedTable: $db.jobDirections,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$JobDirectionsTableAnnotationComposer(
            $db: $db,
            $table: $db.jobDirections,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$VacancyDirectionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VacancyDirectionsTable,
          VacancyDirection,
          $$VacancyDirectionsTableFilterComposer,
          $$VacancyDirectionsTableOrderingComposer,
          $$VacancyDirectionsTableAnnotationComposer,
          $$VacancyDirectionsTableCreateCompanionBuilder,
          $$VacancyDirectionsTableUpdateCompanionBuilder,
          (VacancyDirection, $$VacancyDirectionsTableReferences),
          VacancyDirection,
          PrefetchHooks Function({bool vacancy, bool direction})
        > {
  $$VacancyDirectionsTableTableManager(
    _$AppDatabase db,
    $VacancyDirectionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VacancyDirectionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VacancyDirectionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VacancyDirectionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> vacancy = const Value.absent(),
                Value<int> direction = const Value.absent(),
                Value<int> order = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VacancyDirectionsCompanion(
                vacancy: vacancy,
                direction: direction,
                order: order,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required int vacancy,
                required int direction,
                required int order,
                Value<int> rowid = const Value.absent(),
              }) => VacancyDirectionsCompanion.insert(
                vacancy: vacancy,
                direction: direction,
                order: order,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VacancyDirectionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vacancy = false, direction = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vacancy) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vacancy,
                                referencedTable:
                                    $$VacancyDirectionsTableReferences
                                        ._vacancyTable(db),
                                referencedColumn:
                                    $$VacancyDirectionsTableReferences
                                        ._vacancyTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (direction) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.direction,
                                referencedTable:
                                    $$VacancyDirectionsTableReferences
                                        ._directionTable(db),
                                referencedColumn:
                                    $$VacancyDirectionsTableReferences
                                        ._directionTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$VacancyDirectionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VacancyDirectionsTable,
      VacancyDirection,
      $$VacancyDirectionsTableFilterComposer,
      $$VacancyDirectionsTableOrderingComposer,
      $$VacancyDirectionsTableAnnotationComposer,
      $$VacancyDirectionsTableCreateCompanionBuilder,
      $$VacancyDirectionsTableUpdateCompanionBuilder,
      (VacancyDirection, $$VacancyDirectionsTableReferences),
      VacancyDirection,
      PrefetchHooks Function({bool vacancy, bool direction})
    >;
typedef $$InterviewStoryItemsTableCreateCompanionBuilder =
    InterviewStoryItemsCompanion Function({
      Value<int> item,
      required DateTime time,
      required bool isOnline,
      required String target,
      required InterviewTypes type,
    });
typedef $$InterviewStoryItemsTableUpdateCompanionBuilder =
    InterviewStoryItemsCompanion Function({
      Value<int> item,
      Value<DateTime> time,
      Value<bool> isOnline,
      Value<String> target,
      Value<InterviewTypes> type,
    });

final class $$InterviewStoryItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $InterviewStoryItemsTable,
          InterviewStoryItem
        > {
  $$InterviewStoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoryItemsTable _itemTable(_$AppDatabase db) =>
      db.storyItems.createAlias(
        $_aliasNameGenerator(db.interviewStoryItems.item, db.storyItems.id),
      );

  $$StoryItemsTableProcessedTableManager get item {
    final $_column = $_itemColumn<int>('item')!;

    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$InterviewStoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $InterviewStoryItemsTable> {
  $$InterviewStoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InterviewTypes, InterviewTypes, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  $$StoryItemsTableFilterComposer get item {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InterviewStoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $InterviewStoryItemsTable> {
  $$InterviewStoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isOnline => $composableBuilder(
    column: $table.isOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get target => $composableBuilder(
    column: $table.target,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoryItemsTableOrderingComposer get item {
    final $$StoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InterviewStoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $InterviewStoryItemsTable> {
  $$InterviewStoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<bool> get isOnline =>
      $composableBuilder(column: $table.isOnline, builder: (column) => column);

  GeneratedColumn<String> get target =>
      $composableBuilder(column: $table.target, builder: (column) => column);

  GeneratedColumnWithTypeConverter<InterviewTypes, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  $$StoryItemsTableAnnotationComposer get item {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$InterviewStoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $InterviewStoryItemsTable,
          InterviewStoryItem,
          $$InterviewStoryItemsTableFilterComposer,
          $$InterviewStoryItemsTableOrderingComposer,
          $$InterviewStoryItemsTableAnnotationComposer,
          $$InterviewStoryItemsTableCreateCompanionBuilder,
          $$InterviewStoryItemsTableUpdateCompanionBuilder,
          (InterviewStoryItem, $$InterviewStoryItemsTableReferences),
          InterviewStoryItem,
          PrefetchHooks Function({bool item})
        > {
  $$InterviewStoryItemsTableTableManager(
    _$AppDatabase db,
    $InterviewStoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$InterviewStoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$InterviewStoryItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$InterviewStoryItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<DateTime> time = const Value.absent(),
                Value<bool> isOnline = const Value.absent(),
                Value<String> target = const Value.absent(),
                Value<InterviewTypes> type = const Value.absent(),
              }) => InterviewStoryItemsCompanion(
                item: item,
                time: time,
                isOnline: isOnline,
                target: target,
                type: type,
              ),
          createCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                required DateTime time,
                required bool isOnline,
                required String target,
                required InterviewTypes type,
              }) => InterviewStoryItemsCompanion.insert(
                item: item,
                time: time,
                isOnline: isOnline,
                target: target,
                type: type,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$InterviewStoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({item = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (item) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.item,
                                referencedTable:
                                    $$InterviewStoryItemsTableReferences
                                        ._itemTable(db),
                                referencedColumn:
                                    $$InterviewStoryItemsTableReferences
                                        ._itemTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$InterviewStoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $InterviewStoryItemsTable,
      InterviewStoryItem,
      $$InterviewStoryItemsTableFilterComposer,
      $$InterviewStoryItemsTableOrderingComposer,
      $$InterviewStoryItemsTableAnnotationComposer,
      $$InterviewStoryItemsTableCreateCompanionBuilder,
      $$InterviewStoryItemsTableUpdateCompanionBuilder,
      (InterviewStoryItem, $$InterviewStoryItemsTableReferences),
      InterviewStoryItem,
      PrefetchHooks Function({bool item})
    >;
typedef $$WaitingForFeedbackStoryItemsTableCreateCompanionBuilder =
    WaitingForFeedbackStoryItemsCompanion Function({
      Value<int> item,
      Value<DateTime?> time,
      Value<String> comment,
    });
typedef $$WaitingForFeedbackStoryItemsTableUpdateCompanionBuilder =
    WaitingForFeedbackStoryItemsCompanion Function({
      Value<int> item,
      Value<DateTime?> time,
      Value<String> comment,
    });

final class $$WaitingForFeedbackStoryItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $WaitingForFeedbackStoryItemsTable,
          WaitingForFeedbackStoryItem
        > {
  $$WaitingForFeedbackStoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoryItemsTable _itemTable(_$AppDatabase db) =>
      db.storyItems.createAlias(
        $_aliasNameGenerator(
          db.waitingForFeedbackStoryItems.item,
          db.storyItems.id,
        ),
      );

  $$StoryItemsTableProcessedTableManager get item {
    final $_column = $_itemColumn<int>('item')!;

    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WaitingForFeedbackStoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $WaitingForFeedbackStoryItemsTable> {
  $$WaitingForFeedbackStoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$StoryItemsTableFilterComposer get item {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaitingForFeedbackStoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $WaitingForFeedbackStoryItemsTable> {
  $$WaitingForFeedbackStoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get time => $composableBuilder(
    column: $table.time,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoryItemsTableOrderingComposer get item {
    final $$StoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaitingForFeedbackStoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WaitingForFeedbackStoryItemsTable> {
  $$WaitingForFeedbackStoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get time =>
      $composableBuilder(column: $table.time, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$StoryItemsTableAnnotationComposer get item {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WaitingForFeedbackStoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WaitingForFeedbackStoryItemsTable,
          WaitingForFeedbackStoryItem,
          $$WaitingForFeedbackStoryItemsTableFilterComposer,
          $$WaitingForFeedbackStoryItemsTableOrderingComposer,
          $$WaitingForFeedbackStoryItemsTableAnnotationComposer,
          $$WaitingForFeedbackStoryItemsTableCreateCompanionBuilder,
          $$WaitingForFeedbackStoryItemsTableUpdateCompanionBuilder,
          (
            WaitingForFeedbackStoryItem,
            $$WaitingForFeedbackStoryItemsTableReferences,
          ),
          WaitingForFeedbackStoryItem,
          PrefetchHooks Function({bool item})
        > {
  $$WaitingForFeedbackStoryItemsTableTableManager(
    _$AppDatabase db,
    $WaitingForFeedbackStoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WaitingForFeedbackStoryItemsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$WaitingForFeedbackStoryItemsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$WaitingForFeedbackStoryItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => WaitingForFeedbackStoryItemsCompanion(
                item: item,
                time: time,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<DateTime?> time = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => WaitingForFeedbackStoryItemsCompanion.insert(
                item: item,
                time: time,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$WaitingForFeedbackStoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({item = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (item) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.item,
                                referencedTable:
                                    $$WaitingForFeedbackStoryItemsTableReferences
                                        ._itemTable(db),
                                referencedColumn:
                                    $$WaitingForFeedbackStoryItemsTableReferences
                                        ._itemTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$WaitingForFeedbackStoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WaitingForFeedbackStoryItemsTable,
      WaitingForFeedbackStoryItem,
      $$WaitingForFeedbackStoryItemsTableFilterComposer,
      $$WaitingForFeedbackStoryItemsTableOrderingComposer,
      $$WaitingForFeedbackStoryItemsTableAnnotationComposer,
      $$WaitingForFeedbackStoryItemsTableCreateCompanionBuilder,
      $$WaitingForFeedbackStoryItemsTableUpdateCompanionBuilder,
      (
        WaitingForFeedbackStoryItem,
        $$WaitingForFeedbackStoryItemsTableReferences,
      ),
      WaitingForFeedbackStoryItem,
      PrefetchHooks Function({bool item})
    >;
typedef $$TaskStoryItemsTableCreateCompanionBuilder =
    TaskStoryItemsCompanion Function({
      Value<int> item,
      Value<DateTime?> deadline,
      required String link,
      Value<String> comment,
    });
typedef $$TaskStoryItemsTableUpdateCompanionBuilder =
    TaskStoryItemsCompanion Function({
      Value<int> item,
      Value<DateTime?> deadline,
      Value<String> link,
      Value<String> comment,
    });

final class $$TaskStoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $TaskStoryItemsTable, TaskStoryItem> {
  $$TaskStoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoryItemsTable _itemTable(_$AppDatabase db) =>
      db.storyItems.createAlias(
        $_aliasNameGenerator(db.taskStoryItems.item, db.storyItems.id),
      );

  $$StoryItemsTableProcessedTableManager get item {
    final $_column = $_itemColumn<int>('item')!;

    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TaskStoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $TaskStoryItemsTable> {
  $$TaskStoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$StoryItemsTableFilterComposer get item {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskStoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $TaskStoryItemsTable> {
  $$TaskStoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<DateTime> get deadline => $composableBuilder(
    column: $table.deadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoryItemsTableOrderingComposer get item {
    final $$StoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskStoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $TaskStoryItemsTable> {
  $$TaskStoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<DateTime> get deadline =>
      $composableBuilder(column: $table.deadline, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$StoryItemsTableAnnotationComposer get item {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TaskStoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TaskStoryItemsTable,
          TaskStoryItem,
          $$TaskStoryItemsTableFilterComposer,
          $$TaskStoryItemsTableOrderingComposer,
          $$TaskStoryItemsTableAnnotationComposer,
          $$TaskStoryItemsTableCreateCompanionBuilder,
          $$TaskStoryItemsTableUpdateCompanionBuilder,
          (TaskStoryItem, $$TaskStoryItemsTableReferences),
          TaskStoryItem,
          PrefetchHooks Function({bool item})
        > {
  $$TaskStoryItemsTableTableManager(
    _$AppDatabase db,
    $TaskStoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TaskStoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TaskStoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TaskStoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                Value<String> link = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => TaskStoryItemsCompanion(
                item: item,
                deadline: deadline,
                link: link,
                comment: comment,
              ),
          createCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<DateTime?> deadline = const Value.absent(),
                required String link,
                Value<String> comment = const Value.absent(),
              }) => TaskStoryItemsCompanion.insert(
                item: item,
                deadline: deadline,
                link: link,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$TaskStoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({item = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (item) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.item,
                                referencedTable: $$TaskStoryItemsTableReferences
                                    ._itemTable(db),
                                referencedColumn:
                                    $$TaskStoryItemsTableReferences
                                        ._itemTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TaskStoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TaskStoryItemsTable,
      TaskStoryItem,
      $$TaskStoryItemsTableFilterComposer,
      $$TaskStoryItemsTableOrderingComposer,
      $$TaskStoryItemsTableAnnotationComposer,
      $$TaskStoryItemsTableCreateCompanionBuilder,
      $$TaskStoryItemsTableUpdateCompanionBuilder,
      (TaskStoryItem, $$TaskStoryItemsTableReferences),
      TaskStoryItem,
      PrefetchHooks Function({bool item})
    >;
typedef $$FailureStoryItemsTableCreateCompanionBuilder =
    FailureStoryItemsCompanion Function({
      Value<int> item,
      Value<String> comment,
    });
typedef $$FailureStoryItemsTableUpdateCompanionBuilder =
    FailureStoryItemsCompanion Function({
      Value<int> item,
      Value<String> comment,
    });

final class $$FailureStoryItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FailureStoryItemsTable,
          FailureStoryItem
        > {
  $$FailureStoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoryItemsTable _itemTable(_$AppDatabase db) =>
      db.storyItems.createAlias(
        $_aliasNameGenerator(db.failureStoryItems.item, db.storyItems.id),
      );

  $$StoryItemsTableProcessedTableManager get item {
    final $_column = $_itemColumn<int>('item')!;

    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FailureStoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $FailureStoryItemsTable> {
  $$FailureStoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnFilters(column),
  );

  $$StoryItemsTableFilterComposer get item {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FailureStoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $FailureStoryItemsTable> {
  $$FailureStoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get comment => $composableBuilder(
    column: $table.comment,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoryItemsTableOrderingComposer get item {
    final $$StoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FailureStoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FailureStoryItemsTable> {
  $$FailureStoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get comment =>
      $composableBuilder(column: $table.comment, builder: (column) => column);

  $$StoryItemsTableAnnotationComposer get item {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FailureStoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FailureStoryItemsTable,
          FailureStoryItem,
          $$FailureStoryItemsTableFilterComposer,
          $$FailureStoryItemsTableOrderingComposer,
          $$FailureStoryItemsTableAnnotationComposer,
          $$FailureStoryItemsTableCreateCompanionBuilder,
          $$FailureStoryItemsTableUpdateCompanionBuilder,
          (FailureStoryItem, $$FailureStoryItemsTableReferences),
          FailureStoryItem,
          PrefetchHooks Function({bool item})
        > {
  $$FailureStoryItemsTableTableManager(
    _$AppDatabase db,
    $FailureStoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FailureStoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FailureStoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FailureStoryItemsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => FailureStoryItemsCompanion(item: item, comment: comment),
          createCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<String> comment = const Value.absent(),
              }) => FailureStoryItemsCompanion.insert(
                item: item,
                comment: comment,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$FailureStoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({item = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (item) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.item,
                                referencedTable:
                                    $$FailureStoryItemsTableReferences
                                        ._itemTable(db),
                                referencedColumn:
                                    $$FailureStoryItemsTableReferences
                                        ._itemTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$FailureStoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FailureStoryItemsTable,
      FailureStoryItem,
      $$FailureStoryItemsTableFilterComposer,
      $$FailureStoryItemsTableOrderingComposer,
      $$FailureStoryItemsTableAnnotationComposer,
      $$FailureStoryItemsTableCreateCompanionBuilder,
      $$FailureStoryItemsTableUpdateCompanionBuilder,
      (FailureStoryItem, $$FailureStoryItemsTableReferences),
      FailureStoryItem,
      PrefetchHooks Function({bool item})
    >;
typedef $$OfferStoryItemsTableCreateCompanionBuilder =
    OfferStoryItemsCompanion Function({Value<int> item, required int salary});
typedef $$OfferStoryItemsTableUpdateCompanionBuilder =
    OfferStoryItemsCompanion Function({Value<int> item, Value<int> salary});

final class $$OfferStoryItemsTableReferences
    extends
        BaseReferences<_$AppDatabase, $OfferStoryItemsTable, OfferStoryItem> {
  $$OfferStoryItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $StoryItemsTable _itemTable(_$AppDatabase db) =>
      db.storyItems.createAlias(
        $_aliasNameGenerator(db.offerStoryItems.item, db.storyItems.id),
      );

  $$StoryItemsTableProcessedTableManager get item {
    final $_column = $_itemColumn<int>('item')!;

    final manager = $$StoryItemsTableTableManager(
      $_db,
      $_db.storyItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_itemTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OfferStoryItemsTableFilterComposer
    extends Composer<_$AppDatabase, $OfferStoryItemsTable> {
  $$OfferStoryItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnFilters(column),
  );

  $$StoryItemsTableFilterComposer get item {
    final $$StoryItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableFilterComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OfferStoryItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $OfferStoryItemsTable> {
  $$OfferStoryItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get salary => $composableBuilder(
    column: $table.salary,
    builder: (column) => ColumnOrderings(column),
  );

  $$StoryItemsTableOrderingComposer get item {
    final $$StoryItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableOrderingComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OfferStoryItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $OfferStoryItemsTable> {
  $$OfferStoryItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get salary =>
      $composableBuilder(column: $table.salary, builder: (column) => column);

  $$StoryItemsTableAnnotationComposer get item {
    final $$StoryItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.item,
      referencedTable: $db.storyItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$StoryItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.storyItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OfferStoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OfferStoryItemsTable,
          OfferStoryItem,
          $$OfferStoryItemsTableFilterComposer,
          $$OfferStoryItemsTableOrderingComposer,
          $$OfferStoryItemsTableAnnotationComposer,
          $$OfferStoryItemsTableCreateCompanionBuilder,
          $$OfferStoryItemsTableUpdateCompanionBuilder,
          (OfferStoryItem, $$OfferStoryItemsTableReferences),
          OfferStoryItem,
          PrefetchHooks Function({bool item})
        > {
  $$OfferStoryItemsTableTableManager(
    _$AppDatabase db,
    $OfferStoryItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OfferStoryItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OfferStoryItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OfferStoryItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> item = const Value.absent(),
                Value<int> salary = const Value.absent(),
              }) => OfferStoryItemsCompanion(item: item, salary: salary),
          createCompanionCallback:
              ({Value<int> item = const Value.absent(), required int salary}) =>
                  OfferStoryItemsCompanion.insert(item: item, salary: salary),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OfferStoryItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({item = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (item) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.item,
                                referencedTable:
                                    $$OfferStoryItemsTableReferences._itemTable(
                                      db,
                                    ),
                                referencedColumn:
                                    $$OfferStoryItemsTableReferences
                                        ._itemTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OfferStoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OfferStoryItemsTable,
      OfferStoryItem,
      $$OfferStoryItemsTableFilterComposer,
      $$OfferStoryItemsTableOrderingComposer,
      $$OfferStoryItemsTableAnnotationComposer,
      $$OfferStoryItemsTableCreateCompanionBuilder,
      $$OfferStoryItemsTableUpdateCompanionBuilder,
      (OfferStoryItem, $$OfferStoryItemsTableReferences),
      OfferStoryItem,
      PrefetchHooks Function({bool item})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CompaniesTableTableManager get companies =>
      $$CompaniesTableTableManager(_db, _db.companies);
  $$VacanciesTableTableManager get vacancies =>
      $$VacanciesTableTableManager(_db, _db.vacancies);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$StoryItemsTableTableManager get storyItems =>
      $$StoryItemsTableTableManager(_db, _db.storyItems);
  $$JobDirectionsTableTableManager get jobDirections =>
      $$JobDirectionsTableTableManager(_db, _db.jobDirections);
  $$VacancyDirectionsTableTableManager get vacancyDirections =>
      $$VacancyDirectionsTableTableManager(_db, _db.vacancyDirections);
  $$InterviewStoryItemsTableTableManager get interviewStoryItems =>
      $$InterviewStoryItemsTableTableManager(_db, _db.interviewStoryItems);
  $$WaitingForFeedbackStoryItemsTableTableManager
  get waitingForFeedbackStoryItems =>
      $$WaitingForFeedbackStoryItemsTableTableManager(
        _db,
        _db.waitingForFeedbackStoryItems,
      );
  $$TaskStoryItemsTableTableManager get taskStoryItems =>
      $$TaskStoryItemsTableTableManager(_db, _db.taskStoryItems);
  $$FailureStoryItemsTableTableManager get failureStoryItems =>
      $$FailureStoryItemsTableTableManager(_db, _db.failureStoryItems);
  $$OfferStoryItemsTableTableManager get offerStoryItems =>
      $$OfferStoryItemsTableTableManager(_db, _db.offerStoryItems);
}
