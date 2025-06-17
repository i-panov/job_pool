import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/core/parse.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/routing/app_router.gr.dart';
import 'package:url_launcher/url_launcher_string.dart';

final companiesProvider = StreamProvider.autoDispose((ref) {
  return ref.read(companiesRepository).selectAll().watch();
});

@RoutePage(name: 'CompaniesTab')
class CompaniesPage extends ConsumerWidget {
  const CompaniesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final companiesValue = ref.watch(companiesProvider);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          companiesValue.when(
            error: (error, _) => Center(
              child: Text(
                'Ошибка загрузки компаний: $error',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge?.copyWith(color: Colors.red),
              ),
            ),
            loading: () => Center(child: CircularProgressIndicator()),
            data: (companies) {
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
                            color: company.isIT
                                ? Colors.blue.shade200
                                : Colors.grey.shade300,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
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
                                        await launchUrlString(
                                          company.links.first,
                                        );
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
            child: Column(
              spacing: 10,
              children: [
                FloatingActionButton(
                  onPressed: () async {
                    final url = await showDialog<String>(
                      context: context,
                      builder: (context) => _LinkDialog(),
                    );

                    if (url != null && url.isNotEmpty) {
                      final parsedVacancy = await parseHeadHunterVacancy(url);
                      print(parsedVacancy);
                    }
                  },
                  backgroundColor: Colors.blue,
                  tooltip: 'Добавить вакансию (по ссылке)',
                  child: Icon(Icons.link, size: 32),
                ),
                FloatingActionButton(
                  onPressed: () => context.router.push(CompanyFormRoute()),
                  backgroundColor: Colors.green,
                  tooltip: 'Добавить компанию (вручную)',
                  child: Icon(Icons.add, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LinkDialog extends StatefulWidget {
  const _LinkDialog();

  @override
  _LinkDialogState createState() => _LinkDialogState();
}

class _LinkDialogState extends State<_LinkDialog> {
  final _formKey = GlobalKey<FormState>();
  var _link = '';

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [Text('Введите ссылку на'), Text('вакансию (только HH)')],
        ),
        content: TextFormField(
          initialValue: _link,
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'https://hh.ru/vacancy/12345678',
          ),
          onChanged: (value) => _link = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ссылка не может быть пустой';
            }

            final uri = Uri.tryParse(value);

            if (uri == null ||
                !uri.isAbsolute ||
                !uri.host.endsWith('hh.ru') ||
                !uri.path.startsWith('/vacancy/')) {
              return 'Некорректная ссылка на вакансию HH';
            }

            return null;
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Отмена'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Navigator.of(context).pop(_link);
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }
}
