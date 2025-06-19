import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:job_pool/ui/providers/parsing_provider.dart';
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
    final parsingState = ref.watch(parsingProvider);

    ref.listen(parsingProvider, (previous, next) {
      if (next is ParsingSuccess) {
        context.router.push(VacancyRoute(vacancyId: next.vacancyId));
      } else if (next is ParsingFailure) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error)));
      }
    });

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
                IconButton(
                  onPressed: parsingState is ParsingInitial
                      ? () async {
                          final uri = await showDialog<Uri>(
                            context: context,
                            builder: (context) => _LinkDialog(),
                          );

                          if (uri != null) {
                            await ref.read(parsingProvider.notifier).parse(uri);
                          }
                        }
                      : null,
                  color: Colors.blue,
                  tooltip: 'Добавить вакансию (по ссылке)',
                  icon: parsingState is ParsingInitial
                      ? Icon(Icons.link, size: 32)
                      : CircularProgressIndicator(strokeWidth: 32),
                ),
                IconButton(
                  onPressed: () => context.router.push(CompanyFormRoute()),
                  color: Colors.green,
                  tooltip: 'Добавить компанию (вручную)',
                  icon: Icon(Icons.add, size: 32),
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
          autofocus: true,
          decoration: InputDecoration(
            hintText: 'https://hh.ru/vacancy/12345678',
          ),
          onChanged: (value) => _link = value,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Ссылка не может быть пустой';
            }

            final uri = _tryParseVacancyUrl(value);

            if (uri == null) {
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
                final uri = _tryParseVacancyUrl(_link);

                if (uri != null) {
                  Navigator.of(context).pop(uri);
                }
              }
            },
            child: Text('Добавить'),
          ),
        ],
      ),
    );
  }

  Uri? _tryParseVacancyUrl(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    const pattern = r'https:\/\/(?:[a-zA-Z0-9.-]+\.)?hh\.ru\/vacancy\/\d+';
    final url = RegExp(pattern).firstMatch(value)?.group(0);
    return url != null ? Uri.tryParse(url) : null;
  }
}
