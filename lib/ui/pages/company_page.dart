import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class CompanyPage extends ConsumerWidget {
  final int companyId;

  const CompanyPage({super.key, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesState = ref.watch(companyProvider(companyId));
    final vacanciesState = ref.watch(vacanciesProvider(companyId));

    return companiesState.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text(error.toString())),
      data: (company) => Scaffold(
        appBar: AppBar(
          title: Text(company.name),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () =>
                  context.router.push(CompanyFormRoute(companyId: company.id)),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              context.router.push(VacancyFormRoute(companyId: company.id)),
          backgroundColor: Colors.green,
          child: Icon(Icons.add, color: Colors.white),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Основная информация
              Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Основная информация',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(color: Colors.grey.shade700),
                      ),
                      SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'IT-аккредитация',
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Chip(
                            label: Text(
                              company.isIT ? 'Есть' : 'Нет',
                              style: TextStyle(
                                color: company.isIT
                                    ? Colors.green.shade700
                                    : Colors.grey.shade700,
                              ),
                            ),
                            backgroundColor: company.isIT
                                ? Colors.green.shade50
                                : Colors.grey.shade100,
                          ),
                        ],
                      ),
                      if (company.comment.isNotEmpty) ...[
                        SizedBox(height: 16),
                        Text(
                          'Комментарий',
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          company.comment,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Ссылки
              if (company.links.isNotEmpty) ...[
                Text(
                  'Ссылки',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey.shade700,
                  ),
                ),
                SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      for (final link in company.links)
                        InkWell(
                          onTap: () => launchUrlString(link),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 12,
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    Uri.parse(link).host,
                                    style: TextStyle(
                                      color: Colors.blue.shade700,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ),
                                Icon(
                                  Icons.open_in_new,
                                  size: 16,
                                  color: Colors.blue.shade700,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],

              // Вакансии
              Text(
                'Вакансии',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(color: Colors.grey.shade700),
              ),
              SizedBox(height: 12),
              vacanciesState.when(
                loading: () => Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(child: Text(error.toString())),
                data: (vacancies) {
                  if (vacancies.isEmpty) {
                    return Card(
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Вакансий пока нет',
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ),
                      ),
                    );
                  }

                  return Card(
                    child: Column(
                      children: [
                        for (var i = 0; i < vacancies.length; i++) ...[
                          VacancyListItem(vacancy: vacancies[i]),
                          if (i < vacancies.length - 1) Divider(height: 1),
                        ],
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class VacancyListItem extends StatelessWidget {
  final VacancyDto vacancy;

  const VacancyListItem({super.key, required this.vacancy});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.router.push(VacancyRoute(vacancyId: vacancy.id)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vacancy.link,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                  if (vacancy.comment.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(
                      vacancy.comment,
                      style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            IconButton(
              icon: Icon(
                Icons.open_in_new,
                size: 16,
                color: Colors.blue.shade700,
              ),
              onPressed: () => launchUrlString(vacancy.link),
            ),
          ],
        ),
      ),
    );
  }
}

final companyProvider = StreamProvider.autoDispose.family<CompanyDto, int>((
  ref,
  companyId,
) {
  final db = ref.watch(dbProvider);
  final query = db.companies.select()..where((c) => c.id.equals(companyId));
  return query.watchSingle();
});

final vacanciesProvider = StreamProvider.autoDispose
    .family<List<VacancyDto>, int>((ref, companyId) {
      final db = ref.watch(dbProvider);
      final query = db.vacancies.select()
        ..where((v) => v.company.equals(companyId));
      return query.watch().map((vacancies) => vacancies);
    });
