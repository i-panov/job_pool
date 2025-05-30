// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:flutter/material.dart' as _i8;
import 'package:job_pool/ui/pages/companies_page.dart' as _i1;
import 'package:job_pool/ui/pages/company_form_page.dart' as _i2;
import 'package:job_pool/ui/pages/home_page.dart' as _i3;
import 'package:job_pool/ui/pages/root_page.dart' as _i4;
import 'package:job_pool/ui/pages/tasks_page.dart' as _i5;
import 'package:job_pool/ui/pages/vacancies_page.dart' as _i6;

/// generated route for
/// [_i1.CompaniesPage]
class CompaniesTab extends _i7.PageRouteInfo<void> {
  const CompaniesTab({List<_i7.PageRouteInfo>? children})
    : super(CompaniesTab.name, initialChildren: children);

  static const String name = 'CompaniesTab';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.CompaniesPage();
    },
  );
}

/// generated route for
/// [_i2.CompanyFormPage]
class CompanyFormRoute extends _i7.PageRouteInfo<CompanyFormRouteArgs> {
  CompanyFormRoute({
    _i8.Key? key,
    int? companyId,
    List<_i7.PageRouteInfo>? children,
  }) : super(
         CompanyFormRoute.name,
         args: CompanyFormRouteArgs(key: key, companyId: companyId),
         initialChildren: children,
       );

  static const String name = 'CompanyFormRoute';

  static _i7.PageInfo page = _i7.PageInfo(
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

  final _i8.Key? key;

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
/// [_i3.HomePage]
class HomeTab extends _i7.PageRouteInfo<void> {
  const HomeTab({List<_i7.PageRouteInfo>? children})
    : super(HomeTab.name, initialChildren: children);

  static const String name = 'HomeTab';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomePage();
    },
  );
}

/// generated route for
/// [_i4.RootPage]
class RootRoute extends _i7.PageRouteInfo<void> {
  const RootRoute({List<_i7.PageRouteInfo>? children})
    : super(RootRoute.name, initialChildren: children);

  static const String name = 'RootRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i4.RootPage();
    },
  );
}

/// generated route for
/// [_i5.TasksPage]
class TasksTab extends _i7.PageRouteInfo<void> {
  const TasksTab({List<_i7.PageRouteInfo>? children})
    : super(TasksTab.name, initialChildren: children);

  static const String name = 'TasksTab';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.TasksPage();
    },
  );
}

/// generated route for
/// [_i6.VacanciesPage]
class VacanciesTab extends _i7.PageRouteInfo<void> {
  const VacanciesTab({List<_i7.PageRouteInfo>? children})
    : super(VacanciesTab.name, initialChildren: children);

  static const String name = 'VacanciesTab';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.VacanciesPage();
    },
  );
}
