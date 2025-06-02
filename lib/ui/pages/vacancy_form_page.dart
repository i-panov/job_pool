import 'package:auto_route/auto_route.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/ui/providers/vacancy_form_provider.dart';

@RoutePage()
class VacancyFormPage extends ConsumerWidget {
  final int? vacancyId;
  final int companyId;

  const VacancyFormPage({super.key, this.vacancyId, required this.companyId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = vacancyFormProvider(
      VacancyFormParams(companyId: companyId, vacancyId: vacancyId),
    );

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
          vacancyId == null ? 'Новая вакансия' : 'Редактирование вакансии',
        ),
      ),
      body: state.isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(20),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 20,
                  children: [
                    TextFormField(
                      initialValue: state.link.value,
                      onChanged: form.changeLink,
                      decoration: InputDecoration(
                        labelText: 'Ссылка на вакансию',
                        errorText: state.link.errorOrNull,
                      ),
                    ),
                    TextFormField(
                      initialValue: state.comment,
                      maxLines: 5,
                      decoration: InputDecoration(labelText: 'Комментарий'),
                      onChanged: form.changeComment,
                    ),
                    _GradesSelect(
                      initialValue: state.grades,
                      toggle: form.toggleGrade,
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

class _GradesSelect extends StatelessWidget {
  final ISet<JobGrades> initialValue;
  final void Function(JobGrades) toggle;

  const _GradesSelect({required this.initialValue, required this.toggle});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: JobGrades.values.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Text('Грейды:');
        }

        final grade = JobGrades.values[index - 1];

        return CheckboxListTile(
          value: initialValue.contains(grade),
          onChanged: (value) => toggle(grade),
          title: Text(grade.name),
        );
      },
    );
  }
}
