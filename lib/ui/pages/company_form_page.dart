import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/ui/providers/company_form_providers.dart';

@RoutePage()
class CompanyFormPage extends ConsumerWidget {
  final int? companyId;

  const CompanyFormPage({super.key, this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = companyFormProvider(companyId);
    final state = ref.watch(provider);
    final form = ref.read(provider.notifier);

    ref.listen(provider, (prev, next) {
      if (next.error.isNotEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.error)));

        context.router.pop();
      } else if (next.isSubmitted) {
        context.router.pop();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          companyId == null ? 'Новая компания' : 'Редактирование компании',
        ),
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 30,
                  children: [
                    TextFormField(
                      initialValue: state.name.value,
                      decoration: InputDecoration(
                        labelText: 'Название',
                        errorText: state.name.errorOrNull,
                        suffixIconConstraints: BoxConstraints(
                          maxWidth: 16,
                          maxHeight: 16,
                        ),
                        suffixIcon: state.name.isValidating
                            ? CircularProgressIndicator()
                            : null,
                      ),
                      onChanged: form.changeName,
                    ),
                    Row(
                      spacing: 30,
                      children: [
                        Text('IT-аккредитация'),
                        Switch.adaptive(
                          value: state.isIT,
                          onChanged: form.changeIsIT,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 30,
                      children: [
                        Text('Ссылки'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: form.addLink,
                        ),
                      ],
                    ),
                    ReorderableListView.builder(
                      shrinkWrap: true,
                      itemExtent: 70,
                      onReorder: form.moveLink,
                      itemCount: state.links.length,
                      itemBuilder: (context, index) {
                        final link = state.links[index];

                        return ListTile(
                          key: link.key,
                          title: TextFormField(
                            initialValue: link.value,
                            onChanged: (value) => form.changeLink(index, value),
                            decoration: InputDecoration(
                              labelText: 'Ссылка ${index + 1}',
                              errorText: link.errorOrNull,
                              suffixIcon: IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () => form.removeLink(index),
                              ),
                            ),
                          ),
                          trailing: ReorderableDragStartListener(
                            index: index,
                            child: Icon(Icons.drag_handle),
                          ),
                        );
                      },
                    ),
                    ElevatedButton(
                      onPressed: state.canSubmit ? form.submit : null,
                      child: Text('Сохранить'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
