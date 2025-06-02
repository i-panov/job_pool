import 'package:auto_route/auto_route.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => RouteType.adaptive();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      path: '/',
      page: RootRoute.page,
      children: [
        AutoRoute(
          path: 'home',
          page: HomeTab.page,
        ),
        AutoRoute(
          path: 'tasks',
          page: TasksTab.page,
        ),
        AutoRoute(
          path: 'vacancies',
          page: VacanciesTab.page,
        ),
        AutoRoute(
          path: 'companies',
          page: CompaniesTab.page,
        ),
      ],
    ),
    AutoRoute(
      path: '/company',
      page: CompanyFormRoute.page,
    ),
    AutoRoute(
      path: '/company/:id',
      page: CompanyRoute.page,
    ),
    AutoRoute(
      path: '/vacancy/:id',
      page: VacancyFormRoute.page,
    ),
  ];
}
