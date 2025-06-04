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
    final params = VacancyFormParams(
      companyId: companyId,
      vacancyId: vacancyId,
    );

    final state = ref.watch(vacancyFormProvider(params));
    final form = ref.read(vacancyFormProvider(params).notifier);

    ref.listen(vacancyFormProvider(params), (prev, next) {
      if (next.error.isNotEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.error))
        );
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
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    key: const ValueKey('link_field'),
                    initialValue: state.link.value,
                    onChanged: form.changeLink,
                    decoration: InputDecoration(
                      labelText: 'Ссылка на вакансию',
                      errorText: state.link.errorOrNull,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    key: const ValueKey('comment_field'),
                    initialValue: state.comment,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Комментарий'),
                    onChanged: form.changeComment,
                  ),
                  const SizedBox(height: 20),
                  _GradesSelect(
                    initialValue: state.grades,
                    toggle: form.toggleGrade,
                  ),
                  const SizedBox(height: 20),
                  _VacancyDirectionsSelect(
                    initialValue: state.directionIds,
                    toggle: form.toggleDirection,
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton(
                      onPressed: state.canSubmit ? form.submit : null,
                      child: const Text('Сохранить'),
                    ),
                  ),
                ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Грейды:', style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: JobGrades.values.map((grade) {
            return FilterChip(
              label: Text(grade.name),
              selected: initialValue.contains(grade),
              onSelected: (selected) => toggle(grade),
              showCheckmark: true,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _VacancyDirectionsSelect extends ConsumerWidget {
  final IList<int> initialValue;
  final void Function(int) toggle;

  const _VacancyDirectionsSelect({
    required this.initialValue,
    required this.toggle,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(jobDirectionsProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (directions) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Направления:', style: TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: directions.map((direction) {
              return FilterChip(
                label: Text(direction.name),
                selected: initialValue.contains(direction.id),
                onSelected: (selected) => toggle(direction.id),
                showCheckmark: true,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
