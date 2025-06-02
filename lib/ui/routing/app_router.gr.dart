// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:job_pool/ui/pages/companies_page.dart' as _i1;
import 'package:job_pool/ui/pages/company_form_page.dart' as _i2;
import 'package:job_pool/ui/pages/company_page.dart' as _i3;
import 'package:job_pool/ui/pages/home_page.dart' as _i4;
import 'package:job_pool/ui/pages/root_page.dart' as _i5;
import 'package:job_pool/ui/pages/tasks_page.dart' as _i6;
import 'package:job_pool/ui/pages/vacancies_page.dart' as _i7;
import 'package:job_pool/ui/pages/vacancy_form_page.dart' as _i8;

/// generated route for
/// [_i1.CompaniesPage]
class CompaniesTab extends _i9.PageRouteInfo<void> {
  const CompaniesTab({List<_i9.PageRouteInfo>? children})
    : super(CompaniesTab.name, initialChildren: children);

  static const String name = 'CompaniesTab';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.CompaniesPage();
    },
  );
}

/// generated route for
/// [_i2.CompanyFormPage]
class CompanyFormRoute extends _i9.PageRouteInfo<CompanyFormRouteArgs> {
  CompanyFormRoute({
    _i10.Key? key,
    int? companyId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         CompanyFormRoute.name,
         args: CompanyFormRouteArgs(key: key, companyId: companyId),
         initialChildren: children,
       );

  static const String name = 'CompanyFormRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyFormRouteArgs>(
        orElse: () => const CompanyFormRouteArgs(),
      );
      return _i2.CompanyFormPage(key: args.key, companyId: args.companyId);
    },
  );
}

class CompanyFormRouteArgs {
  const CompanyFormRouteArgs({this.key, this.companyId});

  final _i10.Key? key;

  final int? companyId;

  @override
  String toString() {
    return 'CompanyFormRouteArgs{key: $key, companyId: $companyId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyFormRouteArgs) return false;
    return key == other.key && companyId == other.companyId;
  }

  @override
  int get hashCode => key.hashCode ^ companyId.hashCode;
}

/// generated route for
/// [_i3.CompanyPage]
class CompanyRoute extends _i9.PageRouteInfo<CompanyRouteArgs> {
  CompanyRoute({
    _i10.Key? key,
    required int companyId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         CompanyRoute.name,
         args: CompanyRouteArgs(key: key, companyId: companyId),
         initialChildren: children,
       );

  static const String name = 'CompanyRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyRouteArgs>();
      return _i3.CompanyPage(key: args.key, companyId: args.companyId);
    },
  );
}

class CompanyRouteArgs {
  const CompanyRouteArgs({this.key, required this.companyId});

  final _i10.Key? key;

  final int companyId;

  @override
  String toString() {
    return 'CompanyRouteArgs{key: $key, companyId: $companyId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyRouteArgs) return false;
    return key == other.key && companyId == other.companyId;
  }

  @override
  int get hashCode => key.hashCode ^ companyId.hashCode;
}

/// generated route for
/// [_i4.HomePage]
class HomeTab extends _i9.PageRouteInfo<void> {
  const HomeTab({List<_i9.PageRouteInfo>? children})
    : super(HomeTab.name, initialChildren: children);

  static const String name = 'HomeTab';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomePage();
    },
  );
}

/// generated route for
/// [_i5.RootPage]
class RootRoute extends _i9.PageRouteInfo<void> {
  const RootRoute({List<_i9.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.RootPage();
    },
  );
}

/// generated route for
/// [_i6.TasksPage]
class TasksTab extends _i9.PageRouteInfo<void> {
  const TasksTab({List<_i9.PageRouteInfo>? children})
    : super(TasksTab.name, initialChildren: children);

  static const String name = 'TasksTab';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.TasksPage();
    },
  );
}

/// generated route for
/// [_i7.VacanciesPage]
class VacanciesTab extends _i9.PageRouteInfo<void> {
  const VacanciesTab({List<_i9.PageRouteInfo>? children})
    : super(VacanciesTab.name, initialChildren: children);

  static const String name = 'VacanciesTab';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.VacanciesPage();
    },
  );
}

/// generated route for
/// [_i8.VacancyFormPage]
class VacancyFormRoute extends _i9.PageRouteInfo<VacancyFormRouteArgs> {
  VacancyFormRoute({
    _i10.Key? key,
    int? vacancyId,
    required int companyId,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         VacancyFormRoute.name,
         args: VacancyFormRouteArgs(
           key: key,
           vacancyId: vacancyId,
           companyId: companyId,
         ),
         initialChildren: children,
       );

  static const String name = 'VacancyFormRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<VacancyFormRouteArgs>();
      return _i8.VacancyFormPage(
        key: args.key,
        vacancyId: args.vacancyId,
        companyId: args.companyId,
      );
    },
  );
}

class VacancyFormRouteArgs {
  const VacancyFormRouteArgs({
    this.key,
    this.vacancyId,
    required this.companyId,
  });

  final _i10.Key? key;

  final int? vacancyId;

  final int companyId;

  @override
  String toString() {
    return 'VacancyFormRouteArgs{key: $key, vacancyId: $vacancyId, companyId: $companyId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! VacancyFormRouteArgs) return false;
    return key == other.key &&
        vacancyId == other.vacancyId &&
        companyId == other.companyId;
  }

  @override
  int get hashCode => key.hashCode ^ vacancyId.hashCode ^ companyId.hashCode;
}
