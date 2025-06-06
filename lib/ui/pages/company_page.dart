import 'package:auto_route/auto_route.dart';
import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:url_launcher/url_launcher_string.dart';

@RoutePage()
class CompanyPage extends ConsumerStatefulWidget {
  final int companyId;

  const CompanyPage({super.key, required this.companyId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CompanyPageState();
}

class _CompanyPageState extends ConsumerState<CompanyPage> {
  late final db = ref.watch(dbProvider);

  late final companyQuery = db.companies.select()
    ..where((c) => c.id.equals(widget.companyId));

  late final vacanciesQuery = db.vacancies.select()
    ..where((v) => v.company.equals(widget.companyId));

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: companyQuery.watchSingle(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text(snapshot.error.toString()));
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        final company = snapshot.data!;

        return Scaffold(
          appBar: AppBar(
            title: Text(company.name),
            actions: [
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () => context.router.push(
                  CompanyFormRoute(companyId: company.id),
                ),
              ),
            ],
          ),
          floatingActionButton: IconButton(
            onPressed: () =>
                context.router.push(VacancyFormRoute(companyId: company.id)),
            icon: Icon(Icons.add_circle, color: Colors.green, size: 50),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('IT-аккредитация: '),
                    SizedBox(width: 50),
                    Text(company.isIT ? 'Есть' : 'Нет'),
                  ],
                ),
                if (company.comment.isNotEmpty) Text(company.comment),
                for (final link in company.links)
                  Row(
                    children: [
                      Text(link),
                      Spacer(),
                      IconButton(
                        icon: Icon(Icons.open_in_new),
                        onPressed: () => launchUrlString(link),
                      ),
                    ],
                  ),
                Text('Вакансии:'),
                StreamBuilder(
                  stream: vacanciesQuery.watch(),
                  builder: (context, snapshot) {
                    final vacancies = snapshot.data ?? [];

                    if (vacancies.isEmpty) {
                      return Text('Вакансий нет');
                    }

                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: vacancies.length,
                      itemBuilder: (context, index) {
                        final vacancy = vacancies[index];

                        return ListTile(
                          onTap: () => context.router.push(VacancyRoute(
                            vacancyId: vacancy.id,
                          )),
                          title: Text(vacancy.link),
                          subtitle: Text(vacancy.comment),
                          trailing: IconButton(
                            icon: Icon(Icons.open_in_new),
                            onPressed: () => launchUrlString(vacancy.link),
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
