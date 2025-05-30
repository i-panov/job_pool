import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage(name: 'VacanciesTab')
class VacanciesPage extends StatelessWidget {
  const VacanciesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Vacancies'),
    );
  }
}
