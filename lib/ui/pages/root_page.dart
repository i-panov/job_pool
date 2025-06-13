import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';

@RoutePage()
class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: RootTabs.values.length,
      child: AutoTabsRouter(
        routes: RootTabs.values.map((tab) => tab.route).toList(),
        builder: (context, child) {
          final tabsRouter = AutoTabsRouter.of(context);

          return Scaffold(
            body: Padding(padding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 20,
            ), child: child),
            bottomNavigationBar: TabBar(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              //indicator: const BoxDecoration(),
              labelPadding: const EdgeInsets.symmetric(horizontal: 0),
              labelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
              unselectedLabelStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
                color: Colors.grey,
              ),
              tabs: [
                for (final tab in RootTabs.values)
                  Tab(icon: Icon(tab.iconData), text: tab.label),
              ],
              onTap: (index) => tabsRouter.setActiveIndex(index),
            ),
          );
        },
      ),
    );
  }
}

enum RootTabs {
  interviews(
    iconData: Icons.group,
    label: 'Собеседования',
    route: HomeTab(),
  ),
  tasks(iconData: Icons.task, label: 'ТЗ', route: TasksTab()),
  //vacancies(iconData: Icons.work, label: 'Вакансии', route: VacanciesTab()),
  companies(iconData: Icons.business, label: 'Компании', route: CompaniesTab());

  final IconData iconData;
  final String label;
  final PageRouteInfo route;

  const RootTabs({
    required this.iconData,
    required this.label,
    required this.route,
  });
}
