import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/ui/blocs/company_form_bloc.dart';

@RoutePage()
class CompanyFormPage extends StatefulWidget {
  final int? companyId;

  const CompanyFormPage({super.key, this.companyId});

  @override
  State<StatefulWidget> createState() => _CompanyFormPageState();
}

class _CompanyFormPageState extends State<CompanyFormPage> {
  final _formKey = GlobalKey<FormState>();

  late final _bloc = CompanyFormBloc(
    companyId: widget.companyId,
    db: context.read<AppDatabase>(),
  );

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.companyId == null
              ? 'Новая компания'
              : 'Редактирование компании',
        ),
      ),
      body: BlocBuilder<CompanyFormBloc, CompanyFormState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is! CompanyFormStateLoaded) {
            return Center(child: CircularProgressIndicator());
          }
    
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 30,
                  children: [
                    TextFormField(
                      initialValue: state.name,
                      decoration: const InputDecoration(
                        labelText: 'Название',
                      ),
                      onChanged: _bloc.changeName,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Введите название';
                        }
    
                        return null;
                      },
                    ),
                    Row(
                      spacing: 30,
                      children: [
                        Text('IT-аккредитация'),
                        Switch.adaptive(
                          value: state.isIT,
                          onChanged: _bloc.changeIsIT,
                        ),
                      ],
                    ),
                    Row(
                      spacing: 30,
                      children: [
                        Text('Ссылки'),
                        IconButton(
                          icon: Icon(Icons.add),
                          onPressed: _bloc.addLink,
                        ),
                      ],
                    ),
                    ReorderableListView(
                      shrinkWrap: true,
                      itemExtent: 70,
                      onReorder: _bloc.moveLink,
                      children: [
                        for (int i = 0; i < state.links.length; i++)
                          ListTile(
                            key: Key('link_$i'),
                            title: TextFormField(
                              initialValue: state.links[i],
                              onChanged: (value) => _bloc.changeLink(i, value),
                              decoration: InputDecoration(
                                labelText: 'Ссылка ${i + 1}',
                                suffixIcon: IconButton(
                                  icon: Icon(Icons.remove),
                                  onPressed: () => _bloc.removeLink(i),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Введите ссылку';
                                }
    
                                if (!(Uri.tryParse(value)?.isAbsolute ??
                                    false)) {
                                  return 'Введите корректный URL';
                                }
    
                                return null;
                              },
                            ),
                            trailing: ReorderableDragStartListener(
                              index: i,
                              child: Icon(Icons.drag_handle),
                            ),
                          ),
                      ],
                    ),
                    ElevatedButton(
                      child: Text('Сохранить'),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
