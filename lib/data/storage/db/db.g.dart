// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db.dart';

// ignore_for_file: type=lint
class $CompaniesTable extends Companies
    with TableInfo<$CompaniesTable, CompanyDto> {
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
    Insertable<CompanyDto> instance, {
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
  CompanyDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CompanyDto(
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

class CompanyDto extends DataClass implements Insertable<CompanyDto> {
  final int id;
  final String name;
  final bool isIT;
  final String comment;
  final ISet<String> links;
  const CompanyDto({
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

  factory CompanyDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CompanyDto(
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

  CompanyDto copyWith({
    int? id,
    String? name,
    bool? isIT,
    String? comment,
    ISet<String>? links,
  }) => CompanyDto(
    id: id ?? this.id,
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    comment: comment ?? this.comment,
    links: links ?? this.links,
  );
  CompanyDto copyWithCompanion(CompaniesCompanion data) {
    return CompanyDto(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      isIT: data.isIT.present ? data.isIT.value : this.isIT,
      comment: data.comment.present ? data.comment.value : this.comment,
      links: data.links.present ? data.links.value : this.links,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CompanyDto(')
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
      (other is CompanyDto &&
          other.id == this.id &&
          other.name == this.name &&
          other.isIT == this.isIT &&
          other.comment == this.comment &&
          other.links == this.links);
}

class CompaniesCompanion extends UpdateCompanion<CompanyDto> {
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
  static Insertable<CompanyDto> custom({
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
    with TableInfo<$VacanciesTable, VacancyDto> {
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
  late final GeneratedColumn<ISet<JobGrade>> grades =
      GeneratedColumn<ISet<JobGrade>>(
        'grades',
        aliasedName,
        false,
        type: const EnumSetType(JobGrade.values),
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
    Insertable<VacancyDto> instance, {
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
  VacancyDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VacancyDto(
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
        const EnumSetType(JobGrade.values),
        data['${effectivePrefix}grades'],
      )!,
    );
  }

  @override
  $VacanciesTable createAlias(String alias) {
    return $VacanciesTable(attachedDatabase, alias);
  }
}

class VacancyDto extends DataClass implements Insertable<VacancyDto> {
  final int id;
  final String link;
  final String comment;
  final int company;
  final ISet<JobGrade> grades;
  const VacancyDto({
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
    map['grades'] = Variable<ISet<JobGrade>>(
      grades,
      const EnumSetType(JobGrade.values),
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

  factory VacancyDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VacancyDto(
      id: serializer.fromJson<int>(json['id']),
      link: serializer.fromJson<String>(json['link']),
      comment: serializer.fromJson<String>(json['comment']),
      company: serializer.fromJson<int>(json['company']),
      grades: serializer.fromJson<ISet<JobGrade>>(json['grades']),
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
      'grades': serializer.toJson<ISet<JobGrade>>(grades),
    };
  }

  VacancyDto copyWith({
    int? id,
    String? link,
    String? comment,
    int? company,
    ISet<JobGrade>? grades,
  }) => VacancyDto(
    id: id ?? this.id,
    link: link ?? this.link,
    comment: comment ?? this.comment,
    company: company ?? this.company,
    grades: grades ?? this.grades,
  );
  VacancyDto copyWithCompanion(VacanciesCompanion data) {
    return VacancyDto(
      id: data.id.present ? data.id.value : this.id,
      link: data.link.present ? data.link.value : this.link,
      comment: data.comment.present ? data.comment.value : this.comment,
      company: data.company.present ? data.company.value : this.company,
      grades: data.grades.present ? data.grades.value : this.grades,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VacancyDto(')
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
      (other is VacancyDto &&
          other.id == this.id &&
          other.link == this.link &&
          other.comment == this.comment &&
          other.company == this.company &&
          other.grades == this.grades);
}

class VacanciesCompanion extends UpdateCompanion<VacancyDto> {
  final Value<int> id;
  final Value<String> link;
  final Value<String> comment;
  final Value<int> company;
  final Value<ISet<JobGrade>> grades;
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
    required ISet<JobGrade> grades,
  }) : link = Value(link),
       company = Value(company),
       grades = Value(grades);
  static Insertable<VacancyDto> custom({
    Expression<int>? id,
    Expression<String>? link,
    Expression<String>? comment,
    Expression<int>? company,
    Expression<ISet<JobGrade>>? grades,
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
    Value<ISet<JobGrade>>? grades,
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
      map['grades'] = Variable<ISet<JobGrade>>(
        grades.value,
        const EnumSetType(JobGrade.values),
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

class $ContactsTable extends Contacts
    with TableInfo<$ContactsTable, ContactDto> {
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
  late final GeneratedColumnWithTypeConverter<ContactType, int> contactType =
      GeneratedColumn<int>(
        'contact_type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<ContactType>($ContactsTable.$convertercontactType);
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
    Insertable<ContactDto> instance, {
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
  ContactDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ContactDto(
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

  static JsonTypeConverter2<ContactType, int, int> $convertercontactType =
      const EnumIndexConverter<ContactType>(ContactType.values);
}

class ContactDto extends DataClass implements Insertable<ContactDto> {
  final int vacancy;
  final ContactType contactType;
  final String contactValue;
  const ContactDto({
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

  factory ContactDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ContactDto(
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

  ContactDto copyWith({
    int? vacancy,
    ContactType? contactType,
    String? contactValue,
  }) => ContactDto(
    vacancy: vacancy ?? this.vacancy,
    contactType: contactType ?? this.contactType,
    contactValue: contactValue ?? this.contactValue,
  );
  ContactDto copyWithCompanion(ContactsCompanion data) {
    return ContactDto(
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
    return (StringBuffer('ContactDto(')
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
      (other is ContactDto &&
          other.vacancy == this.vacancy &&
          other.contactType == this.contactType &&
          other.contactValue == this.contactValue);
}

class ContactsCompanion extends UpdateCompanion<ContactDto> {
  final Value<int> vacancy;
  final Value<ContactType> contactType;
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
    required ContactType contactType,
    required String contactValue,
    this.rowid = const Value.absent(),
  }) : vacancy = Value(vacancy),
       contactType = Value(contactType),
       contactValue = Value(contactValue);
  static Insertable<ContactDto> custom({
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
    Value<ContactType>? contactType,
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
    with TableInfo<$StoryItemsTable, StoryItemDto> {
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
  @override
  late final GeneratedColumnWithTypeConverter<StoryItemType, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<StoryItemType>($StoryItemsTable.$convertertype);
  static const VerificationMeta _commonTimeMeta = const VerificationMeta(
    'commonTime',
  );
  @override
  late final GeneratedColumn<DateTime> commonTime = GeneratedColumn<DateTime>(
    'common_time',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _commonCommentMeta = const VerificationMeta(
    'commonComment',
  );
  @override
  late final GeneratedColumn<String> commonComment = GeneratedColumn<String>(
    'common_comment',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  static const VerificationMeta _interviewIsOnlineMeta = const VerificationMeta(
    'interviewIsOnline',
  );
  @override
  late final GeneratedColumn<bool> interviewIsOnline = GeneratedColumn<bool>(
    'interview_is_online',
    aliasedName,
    true,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("interview_is_online" IN (0, 1))',
    ),
  );
  static const VerificationMeta _interviewTargetMeta = const VerificationMeta(
    'interviewTarget',
  );
  @override
  late final GeneratedColumn<String> interviewTarget = GeneratedColumn<String>(
    'interview_target',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  @override
  late final GeneratedColumnWithTypeConverter<InterviewType?, int>
  interviewType = GeneratedColumn<int>(
    'interview_type',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  ).withConverter<InterviewType?>($StoryItemsTable.$converterinterviewTypen);
  static const VerificationMeta _taskDeadlineMeta = const VerificationMeta(
    'taskDeadline',
  );
  @override
  late final GeneratedColumn<DateTime> taskDeadline = GeneratedColumn<DateTime>(
    'task_deadline',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _taskLinkMeta = const VerificationMeta(
    'taskLink',
  );
  @override
  late final GeneratedColumn<String> taskLink = GeneratedColumn<String>(
    'task_link',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: Constant(''),
  );
  static const VerificationMeta _offerSalaryMeta = const VerificationMeta(
    'offerSalary',
  );
  @override
  late final GeneratedColumn<int> offerSalary = GeneratedColumn<int>(
    'offer_salary',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
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
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    type,
    commonTime,
    commonComment,
    interviewIsOnline,
    interviewTarget,
    interviewType,
    taskDeadline,
    taskLink,
    offerSalary,
    vacancy,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'story_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<StoryItemDto> instance, {
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
    if (data.containsKey('common_time')) {
      context.handle(
        _commonTimeMeta,
        commonTime.isAcceptableOrUnknown(data['common_time']!, _commonTimeMeta),
      );
    }
    if (data.containsKey('common_comment')) {
      context.handle(
        _commonCommentMeta,
        commonComment.isAcceptableOrUnknown(
          data['common_comment']!,
          _commonCommentMeta,
        ),
      );
    }
    if (data.containsKey('interview_is_online')) {
      context.handle(
        _interviewIsOnlineMeta,
        interviewIsOnline.isAcceptableOrUnknown(
          data['interview_is_online']!,
          _interviewIsOnlineMeta,
        ),
      );
    }
    if (data.containsKey('interview_target')) {
      context.handle(
        _interviewTargetMeta,
        interviewTarget.isAcceptableOrUnknown(
          data['interview_target']!,
          _interviewTargetMeta,
        ),
      );
    }
    if (data.containsKey('task_deadline')) {
      context.handle(
        _taskDeadlineMeta,
        taskDeadline.isAcceptableOrUnknown(
          data['task_deadline']!,
          _taskDeadlineMeta,
        ),
      );
    }
    if (data.containsKey('task_link')) {
      context.handle(
        _taskLinkMeta,
        taskLink.isAcceptableOrUnknown(data['task_link']!, _taskLinkMeta),
      );
    }
    if (data.containsKey('offer_salary')) {
      context.handle(
        _offerSalaryMeta,
        offerSalary.isAcceptableOrUnknown(
          data['offer_salary']!,
          _offerSalaryMeta,
        ),
      );
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
  StoryItemDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return StoryItemDto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      type: $StoryItemsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      commonTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}common_time'],
      ),
      commonComment: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}common_comment'],
      )!,
      interviewIsOnline: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}interview_is_online'],
      ),
      interviewTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}interview_target'],
      )!,
      interviewType: $StoryItemsTable.$converterinterviewTypen.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}interview_type'],
        ),
      ),
      taskDeadline: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}task_deadline'],
      ),
      taskLink: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}task_link'],
      )!,
      offerSalary: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}offer_salary'],
      ),
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

  static JsonTypeConverter2<StoryItemType, int, int> $convertertype =
      const EnumIndexConverter<StoryItemType>(StoryItemType.values);
  static JsonTypeConverter2<InterviewType, int, int> $converterinterviewType =
      const EnumIndexConverter<InterviewType>(InterviewType.values);
  static JsonTypeConverter2<InterviewType?, int?, int?>
  $converterinterviewTypen = JsonTypeConverter2.asNullable(
    $converterinterviewType,
  );
}

class StoryItemDto extends DataClass implements Insertable<StoryItemDto> {
  final int id;
  final DateTime createdAt;
  final StoryItemType type;
  final DateTime? commonTime;
  final String commonComment;
  final bool? interviewIsOnline;
  final String interviewTarget;
  final InterviewType? interviewType;
  final DateTime? taskDeadline;
  final String taskLink;
  final int? offerSalary;
  final int vacancy;
  const StoryItemDto({
    required this.id,
    required this.createdAt,
    required this.type,
    this.commonTime,
    required this.commonComment,
    this.interviewIsOnline,
    required this.interviewTarget,
    this.interviewType,
    this.taskDeadline,
    required this.taskLink,
    this.offerSalary,
    required this.vacancy,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    {
      map['type'] = Variable<int>($StoryItemsTable.$convertertype.toSql(type));
    }
    if (!nullToAbsent || commonTime != null) {
      map['common_time'] = Variable<DateTime>(commonTime);
    }
    map['common_comment'] = Variable<String>(commonComment);
    if (!nullToAbsent || interviewIsOnline != null) {
      map['interview_is_online'] = Variable<bool>(interviewIsOnline);
    }
    map['interview_target'] = Variable<String>(interviewTarget);
    if (!nullToAbsent || interviewType != null) {
      map['interview_type'] = Variable<int>(
        $StoryItemsTable.$converterinterviewTypen.toSql(interviewType),
      );
    }
    if (!nullToAbsent || taskDeadline != null) {
      map['task_deadline'] = Variable<DateTime>(taskDeadline);
    }
    map['task_link'] = Variable<String>(taskLink);
    if (!nullToAbsent || offerSalary != null) {
      map['offer_salary'] = Variable<int>(offerSalary);
    }
    map['vacancy'] = Variable<int>(vacancy);
    return map;
  }

  StoryItemsCompanion toCompanion(bool nullToAbsent) {
    return StoryItemsCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      type: Value(type),
      commonTime: commonTime == null && nullToAbsent
          ? const Value.absent()
          : Value(commonTime),
      commonComment: Value(commonComment),
      interviewIsOnline: interviewIsOnline == null && nullToAbsent
          ? const Value.absent()
          : Value(interviewIsOnline),
      interviewTarget: Value(interviewTarget),
      interviewType: interviewType == null && nullToAbsent
          ? const Value.absent()
          : Value(interviewType),
      taskDeadline: taskDeadline == null && nullToAbsent
          ? const Value.absent()
          : Value(taskDeadline),
      taskLink: Value(taskLink),
      offerSalary: offerSalary == null && nullToAbsent
          ? const Value.absent()
          : Value(offerSalary),
      vacancy: Value(vacancy),
    );
  }

  factory StoryItemDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StoryItemDto(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      type: $StoryItemsTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      commonTime: serializer.fromJson<DateTime?>(json['commonTime']),
      commonComment: serializer.fromJson<String>(json['commonComment']),
      interviewIsOnline: serializer.fromJson<bool?>(json['interviewIsOnline']),
      interviewTarget: serializer.fromJson<String>(json['interviewTarget']),
      interviewType: $StoryItemsTable.$converterinterviewTypen.fromJson(
        serializer.fromJson<int?>(json['interviewType']),
      ),
      taskDeadline: serializer.fromJson<DateTime?>(json['taskDeadline']),
      taskLink: serializer.fromJson<String>(json['taskLink']),
      offerSalary: serializer.fromJson<int?>(json['offerSalary']),
      vacancy: serializer.fromJson<int>(json['vacancy']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'type': serializer.toJson<int>(
        $StoryItemsTable.$convertertype.toJson(type),
      ),
      'commonTime': serializer.toJson<DateTime?>(commonTime),
      'commonComment': serializer.toJson<String>(commonComment),
      'interviewIsOnline': serializer.toJson<bool?>(interviewIsOnline),
      'interviewTarget': serializer.toJson<String>(interviewTarget),
      'interviewType': serializer.toJson<int?>(
        $StoryItemsTable.$converterinterviewTypen.toJson(interviewType),
      ),
      'taskDeadline': serializer.toJson<DateTime?>(taskDeadline),
      'taskLink': serializer.toJson<String>(taskLink),
      'offerSalary': serializer.toJson<int?>(offerSalary),
      'vacancy': serializer.toJson<int>(vacancy),
    };
  }

  StoryItemDto copyWith({
    int? id,
    DateTime? createdAt,
    StoryItemType? type,
    Value<DateTime?> commonTime = const Value.absent(),
    String? commonComment,
    Value<bool?> interviewIsOnline = const Value.absent(),
    String? interviewTarget,
    Value<InterviewType?> interviewType = const Value.absent(),
    Value<DateTime?> taskDeadline = const Value.absent(),
    String? taskLink,
    Value<int?> offerSalary = const Value.absent(),
    int? vacancy,
  }) => StoryItemDto(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    type: type ?? this.type,
    commonTime: commonTime.present ? commonTime.value : this.commonTime,
    commonComment: commonComment ?? this.commonComment,
    interviewIsOnline: interviewIsOnline.present
        ? interviewIsOnline.value
        : this.interviewIsOnline,
    interviewTarget: interviewTarget ?? this.interviewTarget,
    interviewType: interviewType.present
        ? interviewType.value
        : this.interviewType,
    taskDeadline: taskDeadline.present ? taskDeadline.value : this.taskDeadline,
    taskLink: taskLink ?? this.taskLink,
    offerSalary: offerSalary.present ? offerSalary.value : this.offerSalary,
    vacancy: vacancy ?? this.vacancy,
  );
  StoryItemDto copyWithCompanion(StoryItemsCompanion data) {
    return StoryItemDto(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      type: data.type.present ? data.type.value : this.type,
      commonTime: data.commonTime.present
          ? data.commonTime.value
          : this.commonTime,
      commonComment: data.commonComment.present
          ? data.commonComment.value
          : this.commonComment,
      interviewIsOnline: data.interviewIsOnline.present
          ? data.interviewIsOnline.value
          : this.interviewIsOnline,
      interviewTarget: data.interviewTarget.present
          ? data.interviewTarget.value
          : this.interviewTarget,
      interviewType: data.interviewType.present
          ? data.interviewType.value
          : this.interviewType,
      taskDeadline: data.taskDeadline.present
          ? data.taskDeadline.value
          : this.taskDeadline,
      taskLink: data.taskLink.present ? data.taskLink.value : this.taskLink,
      offerSalary: data.offerSalary.present
          ? data.offerSalary.value
          : this.offerSalary,
      vacancy: data.vacancy.present ? data.vacancy.value : this.vacancy,
    );
  }

  @override
  String toString() {
    return (StringBuffer('StoryItemDto(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('type: $type, ')
          ..write('commonTime: $commonTime, ')
          ..write('commonComment: $commonComment, ')
          ..write('interviewIsOnline: $interviewIsOnline, ')
          ..write('interviewTarget: $interviewTarget, ')
          ..write('interviewType: $interviewType, ')
          ..write('taskDeadline: $taskDeadline, ')
          ..write('taskLink: $taskLink, ')
          ..write('offerSalary: $offerSalary, ')
          ..write('vacancy: $vacancy')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    type,
    commonTime,
    commonComment,
    interviewIsOnline,
    interviewTarget,
    interviewType,
    taskDeadline,
    taskLink,
    offerSalary,
    vacancy,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StoryItemDto &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.type == this.type &&
          other.commonTime == this.commonTime &&
          other.commonComment == this.commonComment &&
          other.interviewIsOnline == this.interviewIsOnline &&
          other.interviewTarget == this.interviewTarget &&
          other.interviewType == this.interviewType &&
          other.taskDeadline == this.taskDeadline &&
          other.taskLink == this.taskLink &&
          other.offerSalary == this.offerSalary &&
          other.vacancy == this.vacancy);
}

class StoryItemsCompanion extends UpdateCompanion<StoryItemDto> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<StoryItemType> type;
  final Value<DateTime?> commonTime;
  final Value<String> commonComment;
  final Value<bool?> interviewIsOnline;
  final Value<String> interviewTarget;
  final Value<InterviewType?> interviewType;
  final Value<DateTime?> taskDeadline;
  final Value<String> taskLink;
  final Value<int?> offerSalary;
  final Value<int> vacancy;
  const StoryItemsCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.type = const Value.absent(),
    this.commonTime = const Value.absent(),
    this.commonComment = const Value.absent(),
    this.interviewIsOnline = const Value.absent(),
    this.interviewTarget = const Value.absent(),
    this.interviewType = const Value.absent(),
    this.taskDeadline = const Value.absent(),
    this.taskLink = const Value.absent(),
    this.offerSalary = const Value.absent(),
    this.vacancy = const Value.absent(),
  });
  StoryItemsCompanion.insert({
    this.id = const Value.absent(),
    required DateTime createdAt,
    required StoryItemType type,
    this.commonTime = const Value.absent(),
    this.commonComment = const Value.absent(),
    this.interviewIsOnline = const Value.absent(),
    this.interviewTarget = const Value.absent(),
    this.interviewType = const Value.absent(),
    this.taskDeadline = const Value.absent(),
    this.taskLink = const Value.absent(),
    this.offerSalary = const Value.absent(),
    required int vacancy,
  }) : createdAt = Value(createdAt),
       type = Value(type),
       vacancy = Value(vacancy);
  static Insertable<StoryItemDto> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<int>? type,
    Expression<DateTime>? commonTime,
    Expression<String>? commonComment,
    Expression<bool>? interviewIsOnline,
    Expression<String>? interviewTarget,
    Expression<int>? interviewType,
    Expression<DateTime>? taskDeadline,
    Expression<String>? taskLink,
    Expression<int>? offerSalary,
    Expression<int>? vacancy,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (type != null) 'type': type,
      if (commonTime != null) 'common_time': commonTime,
      if (commonComment != null) 'common_comment': commonComment,
      if (interviewIsOnline != null) 'interview_is_online': interviewIsOnline,
      if (interviewTarget != null) 'interview_target': interviewTarget,
      if (interviewType != null) 'interview_type': interviewType,
      if (taskDeadline != null) 'task_deadline': taskDeadline,
      if (taskLink != null) 'task_link': taskLink,
      if (offerSalary != null) 'offer_salary': offerSalary,
      if (vacancy != null) 'vacancy': vacancy,
    });
  }

  StoryItemsCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<StoryItemType>? type,
    Value<DateTime?>? commonTime,
    Value<String>? commonComment,
    Value<bool?>? interviewIsOnline,
    Value<String>? interviewTarget,
    Value<InterviewType?>? interviewType,
    Value<DateTime?>? taskDeadline,
    Value<String>? taskLink,
    Value<int?>? offerSalary,
    Value<int>? vacancy,
  }) {
    return StoryItemsCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      type: type ?? this.type,
      commonTime: commonTime ?? this.commonTime,
      commonComment: commonComment ?? this.commonComment,
      interviewIsOnline: interviewIsOnline ?? this.interviewIsOnline,
      interviewTarget: interviewTarget ?? this.interviewTarget,
      interviewType: interviewType ?? this.interviewType,
      taskDeadline: taskDeadline ?? this.taskDeadline,
      taskLink: taskLink ?? this.taskLink,
      offerSalary: offerSalary ?? this.offerSalary,
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
    if (type.present) {
      map['type'] = Variable<int>(
        $StoryItemsTable.$convertertype.toSql(type.value),
      );
    }
    if (commonTime.present) {
      map['common_time'] = Variable<DateTime>(commonTime.value);
    }
    if (commonComment.present) {
      map['common_comment'] = Variable<String>(commonComment.value);
    }
    if (interviewIsOnline.present) {
      map['interview_is_online'] = Variable<bool>(interviewIsOnline.value);
    }
    if (interviewTarget.present) {
      map['interview_target'] = Variable<String>(interviewTarget.value);
    }
    if (interviewType.present) {
      map['interview_type'] = Variable<int>(
        $StoryItemsTable.$converterinterviewTypen.toSql(interviewType.value),
      );
    }
    if (taskDeadline.present) {
      map['task_deadline'] = Variable<DateTime>(taskDeadline.value);
    }
    if (taskLink.present) {
      map['task_link'] = Variable<String>(taskLink.value);
    }
    if (offerSalary.present) {
      map['offer_salary'] = Variable<int>(offerSalary.value);
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
          ..write('type: $type, ')
          ..write('commonTime: $commonTime, ')
          ..write('commonComment: $commonComment, ')
          ..write('interviewIsOnline: $interviewIsOnline, ')
          ..write('interviewTarget: $interviewTarget, ')
          ..write('interviewType: $interviewType, ')
          ..write('taskDeadline: $taskDeadline, ')
          ..write('taskLink: $taskLink, ')
          ..write('offerSalary: $offerSalary, ')
          ..write('vacancy: $vacancy')
          ..write(')'))
        .toString();
  }
}

class $JobDirectionsTable extends JobDirections
    with TableInfo<$JobDirectionsTable, JobDirectionDto> {
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
    Insertable<JobDirectionDto> instance, {
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
  JobDirectionDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JobDirectionDto(
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

class JobDirectionDto extends DataClass implements Insertable<JobDirectionDto> {
  final int id;
  final String name;
  const JobDirectionDto({required this.id, required this.name});
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

  factory JobDirectionDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JobDirectionDto(
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

  JobDirectionDto copyWith({int? id, String? name}) =>
      JobDirectionDto(id: id ?? this.id, name: name ?? this.name);
  JobDirectionDto copyWithCompanion(JobDirectionsCompanion data) {
    return JobDirectionDto(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JobDirectionDto(')
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
      (other is JobDirectionDto &&
          other.id == this.id &&
          other.name == this.name);
}

class JobDirectionsCompanion extends UpdateCompanion<JobDirectionDto> {
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
  static Insertable<JobDirectionDto> custom({
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
    with TableInfo<$VacancyDirectionsTable, VacancyDirectionDto> {
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
    Insertable<VacancyDirectionDto> instance, {
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
  VacancyDirectionDto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VacancyDirectionDto(
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

class VacancyDirectionDto extends DataClass
    implements Insertable<VacancyDirectionDto> {
  final int vacancy;
  final int direction;
  final int order;
  const VacancyDirectionDto({
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

  factory VacancyDirectionDto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VacancyDirectionDto(
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

  VacancyDirectionDto copyWith({int? vacancy, int? direction, int? order}) =>
      VacancyDirectionDto(
        vacancy: vacancy ?? this.vacancy,
        direction: direction ?? this.direction,
        order: order ?? this.order,
      );
  VacancyDirectionDto copyWithCompanion(VacancyDirectionsCompanion data) {
    return VacancyDirectionDto(
      vacancy: data.vacancy.present ? data.vacancy.value : this.vacancy,
      direction: data.direction.present ? data.direction.value : this.direction,
      order: data.order.present ? data.order.value : this.order,
    );
  }

  @override
  String toString() {
    return (StringBuffer('VacancyDirectionDto(')
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
      (other is VacancyDirectionDto &&
          other.vacancy == this.vacancy &&
          other.direction == this.direction &&
          other.order == this.order);
}

class VacancyDirectionsCompanion extends UpdateCompanion<VacancyDirectionDto> {
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
  static Insertable<VacancyDirectionDto> custom({
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
    extends BaseReferences<_$AppDatabase, $CompaniesTable, CompanyDto> {
  $$CompaniesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$VacanciesTable, List<VacancyDto>>
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
          CompanyDto,
          $$CompaniesTableFilterComposer,
          $$CompaniesTableOrderingComposer,
          $$CompaniesTableAnnotationComposer,
          $$CompaniesTableCreateCompanionBuilder,
          $$CompaniesTableUpdateCompanionBuilder,
          (CompanyDto, $$CompaniesTableReferences),
          CompanyDto,
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
                      CompanyDto,
                      $CompaniesTable,
                      VacancyDto
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
      CompanyDto,
      $$CompaniesTableFilterComposer,
      $$CompaniesTableOrderingComposer,
      $$CompaniesTableAnnotationComposer,
      $$CompaniesTableCreateCompanionBuilder,
      $$CompaniesTableUpdateCompanionBuilder,
      (CompanyDto, $$CompaniesTableReferences),
      CompanyDto,
      PrefetchHooks Function({bool vacanciesRefs})
    >;
typedef $$VacanciesTableCreateCompanionBuilder =
    VacanciesCompanion Function({
      Value<int> id,
      required String link,
      Value<String> comment,
      required int company,
      required ISet<JobGrade> grades,
    });
typedef $$VacanciesTableUpdateCompanionBuilder =
    VacanciesCompanion Function({
      Value<int> id,
      Value<String> link,
      Value<String> comment,
      Value<int> company,
      Value<ISet<JobGrade>> grades,
    });

final class $$VacanciesTableReferences
    extends BaseReferences<_$AppDatabase, $VacanciesTable, VacancyDto> {
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

  static MultiTypedResultKey<$ContactsTable, List<ContactDto>>
  _contactsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
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

  static MultiTypedResultKey<$StoryItemsTable, List<StoryItemDto>>
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

  static MultiTypedResultKey<$VacancyDirectionsTable, List<VacancyDirectionDto>>
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

  ColumnFilters<ISet<JobGrade>> get grades => $composableBuilder(
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

  ColumnOrderings<ISet<JobGrade>> get grades => $composableBuilder(
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

  GeneratedColumn<ISet<JobGrade>> get grades =>
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
          VacancyDto,
          $$VacanciesTableFilterComposer,
          $$VacanciesTableOrderingComposer,
          $$VacanciesTableAnnotationComposer,
          $$VacanciesTableCreateCompanionBuilder,
          $$VacanciesTableUpdateCompanionBuilder,
          (VacancyDto, $$VacanciesTableReferences),
          VacancyDto,
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
                Value<ISet<JobGrade>> grades = const Value.absent(),
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
                required ISet<JobGrade> grades,
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
                          VacancyDto,
                          $VacanciesTable,
                          ContactDto
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
                          VacancyDto,
                          $VacanciesTable,
                          StoryItemDto
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
                          VacancyDto,
                          $VacanciesTable,
                          VacancyDirectionDto
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
      VacancyDto,
      $$VacanciesTableFilterComposer,
      $$VacanciesTableOrderingComposer,
      $$VacanciesTableAnnotationComposer,
      $$VacanciesTableCreateCompanionBuilder,
      $$VacanciesTableUpdateCompanionBuilder,
      (VacancyDto, $$VacanciesTableReferences),
      VacancyDto,
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
      required ContactType contactType,
      required String contactValue,
      Value<int> rowid,
    });
typedef $$ContactsTableUpdateCompanionBuilder =
    ContactsCompanion Function({
      Value<int> vacancy,
      Value<ContactType> contactType,
      Value<String> contactValue,
      Value<int> rowid,
    });

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, ContactDto> {
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
  ColumnWithTypeConverterFilters<ContactType, ContactType, int>
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
  GeneratedColumnWithTypeConverter<ContactType, int> get contactType =>
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
          ContactDto,
          $$ContactsTableFilterComposer,
          $$ContactsTableOrderingComposer,
          $$ContactsTableAnnotationComposer,
          $$ContactsTableCreateCompanionBuilder,
          $$ContactsTableUpdateCompanionBuilder,
          (ContactDto, $$ContactsTableReferences),
          ContactDto,
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
                Value<ContactType> contactType = const Value.absent(),
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
                required ContactType contactType,
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
      ContactDto,
      $$ContactsTableFilterComposer,
      $$ContactsTableOrderingComposer,
      $$ContactsTableAnnotationComposer,
      $$ContactsTableCreateCompanionBuilder,
      $$ContactsTableUpdateCompanionBuilder,
      (ContactDto, $$ContactsTableReferences),
      ContactDto,
      PrefetchHooks Function({bool vacancy})
    >;
typedef $$StoryItemsTableCreateCompanionBuilder =
    StoryItemsCompanion Function({
      Value<int> id,
      required DateTime createdAt,
      required StoryItemType type,
      Value<DateTime?> commonTime,
      Value<String> commonComment,
      Value<bool?> interviewIsOnline,
      Value<String> interviewTarget,
      Value<InterviewType?> interviewType,
      Value<DateTime?> taskDeadline,
      Value<String> taskLink,
      Value<int?> offerSalary,
      required int vacancy,
    });
typedef $$StoryItemsTableUpdateCompanionBuilder =
    StoryItemsCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<StoryItemType> type,
      Value<DateTime?> commonTime,
      Value<String> commonComment,
      Value<bool?> interviewIsOnline,
      Value<String> interviewTarget,
      Value<InterviewType?> interviewType,
      Value<DateTime?> taskDeadline,
      Value<String> taskLink,
      Value<int?> offerSalary,
      Value<int> vacancy,
    });

final class $$StoryItemsTableReferences
    extends BaseReferences<_$AppDatabase, $StoryItemsTable, StoryItemDto> {
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

  ColumnWithTypeConverterFilters<StoryItemType, StoryItemType, int> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get commonTime => $composableBuilder(
    column: $table.commonTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get commonComment => $composableBuilder(
    column: $table.commonComment,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get interviewIsOnline => $composableBuilder(
    column: $table.interviewIsOnline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get interviewTarget => $composableBuilder(
    column: $table.interviewTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<InterviewType?, InterviewType, int>
  get interviewType => $composableBuilder(
    column: $table.interviewType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get taskDeadline => $composableBuilder(
    column: $table.taskDeadline,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get taskLink => $composableBuilder(
    column: $table.taskLink,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get offerSalary => $composableBuilder(
    column: $table.offerSalary,
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

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get commonTime => $composableBuilder(
    column: $table.commonTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get commonComment => $composableBuilder(
    column: $table.commonComment,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get interviewIsOnline => $composableBuilder(
    column: $table.interviewIsOnline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get interviewTarget => $composableBuilder(
    column: $table.interviewTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get interviewType => $composableBuilder(
    column: $table.interviewType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get taskDeadline => $composableBuilder(
    column: $table.taskDeadline,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get taskLink => $composableBuilder(
    column: $table.taskLink,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get offerSalary => $composableBuilder(
    column: $table.offerSalary,
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

  GeneratedColumnWithTypeConverter<StoryItemType, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<DateTime> get commonTime => $composableBuilder(
    column: $table.commonTime,
    builder: (column) => column,
  );

  GeneratedColumn<String> get commonComment => $composableBuilder(
    column: $table.commonComment,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get interviewIsOnline => $composableBuilder(
    column: $table.interviewIsOnline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get interviewTarget => $composableBuilder(
    column: $table.interviewTarget,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<InterviewType?, int> get interviewType =>
      $composableBuilder(
        column: $table.interviewType,
        builder: (column) => column,
      );

  GeneratedColumn<DateTime> get taskDeadline => $composableBuilder(
    column: $table.taskDeadline,
    builder: (column) => column,
  );

  GeneratedColumn<String> get taskLink =>
      $composableBuilder(column: $table.taskLink, builder: (column) => column);

  GeneratedColumn<int> get offerSalary => $composableBuilder(
    column: $table.offerSalary,
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

class $$StoryItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $StoryItemsTable,
          StoryItemDto,
          $$StoryItemsTableFilterComposer,
          $$StoryItemsTableOrderingComposer,
          $$StoryItemsTableAnnotationComposer,
          $$StoryItemsTableCreateCompanionBuilder,
          $$StoryItemsTableUpdateCompanionBuilder,
          (StoryItemDto, $$StoryItemsTableReferences),
          StoryItemDto,
          PrefetchHooks Function({bool vacancy})
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
                Value<StoryItemType> type = const Value.absent(),
                Value<DateTime?> commonTime = const Value.absent(),
                Value<String> commonComment = const Value.absent(),
                Value<bool?> interviewIsOnline = const Value.absent(),
                Value<String> interviewTarget = const Value.absent(),
                Value<InterviewType?> interviewType = const Value.absent(),
                Value<DateTime?> taskDeadline = const Value.absent(),
                Value<String> taskLink = const Value.absent(),
                Value<int?> offerSalary = const Value.absent(),
                Value<int> vacancy = const Value.absent(),
              }) => StoryItemsCompanion(
                id: id,
                createdAt: createdAt,
                type: type,
                commonTime: commonTime,
                commonComment: commonComment,
                interviewIsOnline: interviewIsOnline,
                interviewTarget: interviewTarget,
                interviewType: interviewType,
                taskDeadline: taskDeadline,
                taskLink: taskLink,
                offerSalary: offerSalary,
                vacancy: vacancy,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required DateTime createdAt,
                required StoryItemType type,
                Value<DateTime?> commonTime = const Value.absent(),
                Value<String> commonComment = const Value.absent(),
                Value<bool?> interviewIsOnline = const Value.absent(),
                Value<String> interviewTarget = const Value.absent(),
                Value<InterviewType?> interviewType = const Value.absent(),
                Value<DateTime?> taskDeadline = const Value.absent(),
                Value<String> taskLink = const Value.absent(),
                Value<int?> offerSalary = const Value.absent(),
                required int vacancy,
              }) => StoryItemsCompanion.insert(
                id: id,
                createdAt: createdAt,
                type: type,
                commonTime: commonTime,
                commonComment: commonComment,
                interviewIsOnline: interviewIsOnline,
                interviewTarget: interviewTarget,
                interviewType: interviewType,
                taskDeadline: taskDeadline,
                taskLink: taskLink,
                offerSalary: offerSalary,
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
                                referencedTable: $$StoryItemsTableReferences
                                    ._vacancyTable(db),
                                referencedColumn: $$StoryItemsTableReferences
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

typedef $$StoryItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $StoryItemsTable,
      StoryItemDto,
      $$StoryItemsTableFilterComposer,
      $$StoryItemsTableOrderingComposer,
      $$StoryItemsTableAnnotationComposer,
      $$StoryItemsTableCreateCompanionBuilder,
      $$StoryItemsTableUpdateCompanionBuilder,
      (StoryItemDto, $$StoryItemsTableReferences),
      StoryItemDto,
      PrefetchHooks Function({bool vacancy})
    >;
typedef $$JobDirectionsTableCreateCompanionBuilder =
    JobDirectionsCompanion Function({Value<int> id, required String name});
typedef $$JobDirectionsTableUpdateCompanionBuilder =
    JobDirectionsCompanion Function({Value<int> id, Value<String> name});

final class $$JobDirectionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $JobDirectionsTable, JobDirectionDto> {
  $$JobDirectionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$VacancyDirectionsTable, List<VacancyDirectionDto>>
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
          JobDirectionDto,
          $$JobDirectionsTableFilterComposer,
          $$JobDirectionsTableOrderingComposer,
          $$JobDirectionsTableAnnotationComposer,
          $$JobDirectionsTableCreateCompanionBuilder,
          $$JobDirectionsTableUpdateCompanionBuilder,
          (JobDirectionDto, $$JobDirectionsTableReferences),
          JobDirectionDto,
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
                      JobDirectionDto,
                      $JobDirectionsTable,
                      VacancyDirectionDto
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
      JobDirectionDto,
      $$JobDirectionsTableFilterComposer,
      $$JobDirectionsTableOrderingComposer,
      $$JobDirectionsTableAnnotationComposer,
      $$JobDirectionsTableCreateCompanionBuilder,
      $$JobDirectionsTableUpdateCompanionBuilder,
      (JobDirectionDto, $$JobDirectionsTableReferences),
      JobDirectionDto,
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
          VacancyDirectionDto
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
          VacancyDirectionDto,
          $$VacancyDirectionsTableFilterComposer,
          $$VacancyDirectionsTableOrderingComposer,
          $$VacancyDirectionsTableAnnotationComposer,
          $$VacancyDirectionsTableCreateCompanionBuilder,
          $$VacancyDirectionsTableUpdateCompanionBuilder,
          (VacancyDirectionDto, $$VacancyDirectionsTableReferences),
          VacancyDirectionDto,
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
      VacancyDirectionDto,
      $$VacancyDirectionsTableFilterComposer,
      $$VacancyDirectionsTableOrderingComposer,
      $$VacancyDirectionsTableAnnotationComposer,
      $$VacancyDirectionsTableCreateCompanionBuilder,
      $$VacancyDirectionsTableUpdateCompanionBuilder,
      (VacancyDirectionDto, $$VacancyDirectionsTableReferences),
      VacancyDirectionDto,
      PrefetchHooks Function({bool vacancy, bool direction})
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
}
