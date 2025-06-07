import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage(name: 'CompaniesTab')
class CompaniesPage extends ConsumerWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.read(dbProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          StreamBuilder(
            stream: db.companies.select().watch(),
            builder: (context, snapshot) {
              final companies = snapshot.data ?? [];

              if (companies.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.business, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'Список компаний пуст',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                );
              }

              return ListView.separated(
                padding: EdgeInsets.all(16),
                itemCount: companies.length,
                separatorBuilder: (context, index) => SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final company = companies[index];
                  return Card(
                    elevation: 2,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(8),
                      onTap: () => context.router.push(
                        CompanyRoute(companyId: company.id),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: company.isIT ? Colors.blue.shade200 : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          title: Text(
                            company.name,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: company.isIT ? Colors.blue.shade700 : null,
                            ),
                          ),
                          trailing: company.links.isEmpty
                              ? null
                              : Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.open_in_new,
                                        color: Colors.blue,
                                      ),
                                      tooltip: 'Открыть сайт компании',
                                      onPressed: () async {
                                        await launchUrlString(company.links.first);
                                      },
                                    ),
                                  ],
                                ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton(
              onPressed: () => context.router.push(CompanyFormRoute()),
              backgroundColor: Colors.green,
              child: Icon(Icons.add, size: 32),
            ),
          ),
        ],
      ),
    );
  }
}
