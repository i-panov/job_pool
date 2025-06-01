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

    return Stack(
      alignment: Alignment.topCenter,
      children: [
        StreamBuilder(
          stream: db.companies.select().watch(),
          builder: (context, snapshot) {
            final companies = snapshot.data ?? [];

            if (companies.isEmpty) {
              return Center(child: Text('Список пуст'));
            }

            return ListView(
              scrollDirection: Axis.vertical,
              children: [
                for (final company in companies)
                  ListTile(
                    tileColor: company.isIT ? Colors.lightBlueAccent : null,
                    title: InkWell(
                      child: Text(company.name),
                      onTap: () => context.router.push(
                        CompanyRoute(companyId: company.id),
                      ),
                    ),
                    trailing: company.links.isEmpty
                        ? null
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.open_in_new),
                                onPressed: () async {
                                  await launchUrlString(company.links.first);
                                },
                              ),
                            ],
                          ),
                  ),
              ],
            );
          },
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: IconButton(
            icon: Icon(Icons.add_circle, color: Colors.green, size: 50),
            onPressed: () => context.router.push(CompanyFormRoute()),
          ),
        ),
      ],
    );
  }
}
