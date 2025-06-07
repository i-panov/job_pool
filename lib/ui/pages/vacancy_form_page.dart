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
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 20,
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
                  TextFormField(
                    key: const ValueKey('comment_field'),
                    initialValue: state.comment,
                    maxLines: 5,
                    decoration: const InputDecoration(labelText: 'Комментарий'),
                    onChanged: form.changeComment,
                  ),
                  _GradesSelect(
                    initialValue: state.grades,
                    toggle: form.toggleGrade,
                  ),
                  _VacancyDirectionsSelect(
                    initialValue: state.directionIds,
                    toggle: form.toggleDirection,
                  ),
                  _Contacts(
                    contacts: state.contacts,
                    changeType: form.changeContactType,
                    changeValue: form.changeContactValue,
                    add: form.addContact,
                    remove: form.removeContact,
                  ),
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

class _GradesSelect extends StatefulWidget {
  final ISet<JobGrade> initialValue;
  final void Function(JobGrade) toggle;

  const _GradesSelect({required this.initialValue, required this.toggle});

  @override
  State<_GradesSelect> createState() => _GradesSelectState();
}

class _GradesSelectState extends State<_GradesSelect> {
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
          children: JobGrade.values.map((grade) {
            return FilterChip(
              label: Text(grade.name),
              selected: widget.initialValue.contains(grade),
              onSelected: (selected) => widget.toggle(grade),
              showCheckmark: true,
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _VacancyDirectionsSelect extends ConsumerStatefulWidget {
  final IList<int> initialValue;
  final void Function(int) toggle;

  const _VacancyDirectionsSelect({
    required this.initialValue,
    required this.toggle,
  });

  @override
  ConsumerState<_VacancyDirectionsSelect> createState() => _VacancyDirectionsSelectState();
}

class _VacancyDirectionsSelectState extends ConsumerState<_VacancyDirectionsSelect> {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(jobDirectionsProvider);

    return state.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Text('Error: $error'),
      data: (directions) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Направления:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: directions.map((direction) {
              return FilterChip(
                label: Text(direction.name),
                selected: widget.initialValue.contains(direction.id),
                onSelected: (selected) => widget.toggle(direction.id),
                showCheckmark: true,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class _Contacts extends StatelessWidget {
  final IList<ContactItem> contacts;
  final void Function(int, ContactType) changeType;
  final void Function(int, String) changeValue;
  final void Function() add;
  final void Function(int) remove;

  const _Contacts({
    required this.contacts,
    required this.changeType,
    required this.changeValue,
    required this.add,
    required this.remove,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Text('Контакты:', style: TextStyle(fontWeight: FontWeight.bold)),
            Spacer(),
            IconButton(icon: Icon(Icons.add), onPressed: add),
          ],
        ),
        for (final (index, contact) in contacts.indexed)
          ListTile(
            leading: DropdownButton(
              value: contact.type,
              items: [
                for (final type in ContactType.values)
                  DropdownMenuItem(value: type, child: Text(type.name)),
              ],
              onChanged: (type) => changeType(index, type!),
            ),
            title: TextFormField(
              initialValue: contact.value.value,
              decoration: InputDecoration(errorText: contact.value.errorOrNull),
              onChanged: (value) => changeValue(index, value),
            ),
            trailing: IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => remove(index),
            ),
          ),
      ],
    );
  }
}
