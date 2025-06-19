import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/core/app_form_field.dart';
import 'package:job_pool/core/enums.dart';
import 'package:job_pool/core/extensions.dart';
import 'package:job_pool/core/validators.dart';
import 'package:job_pool/data/db/db.dart';
import 'package:job_pool/data/dto/vacancy_save_args.dart';
import 'package:job_pool/domain/models/contact.dart';
import 'package:job_pool/ui/providers/app_providers.dart';

class ContactItem extends Equatable {
  final ContactType type;
  final AppFormField<String> value;

  const ContactItem(this.type, this.value);

  ContactItem.fromDto(ContactDto dto)
    : type = dto.contactType,
      value = AppFormField(value: dto.contactValue);

  List<AppValidator> get valueValidators {
    return switch (type) {
      ContactType.phone => [AppValidator.required, AppValidator.phone],
      ContactType.email => [AppValidator.required, AppValidator.email],
      ContactType.telegram => [AppValidator.required],
      ContactType.whatsapp => [AppValidator.required, AppValidator.phone],
    };
  }

  ContactItem getValidated([String? newValue]) {
    newValue ??= value.value;

    return ContactItem(
      type,
      value.copyWith(
        value: newValue,
        error: valueValidators.validate(newValue) ?? '',
      ),
    );
  }

  @override
  List<Object?> get props => [type, value];
}

class VacancyFormState extends Equatable {
  final AppFormField<String> link;
  final ISet<JobGrade> grades;
  final IList<int> directionIds;
  final IList<ContactItem> contacts;
  final String comment;
  final bool isSubmitted;

  VacancyFormState({
    String link = '',
    this.comment = '',
    this.grades = const ISet.empty(),
    this.directionIds = const IList.empty(),
    this.contacts = const IList.empty(),
    this.isSubmitted = false,
  }) : link = AppFormField(value: link);

  const VacancyFormState._({
    required this.link,
    required this.comment,
    this.grades = const ISet.empty(),
    this.directionIds = const IList.empty(),
    this.contacts = const IList.empty(),
    this.isSubmitted = false,
  });

  VacancyFormState copyWith({
    AppFormField<String>? link,
    String? comment,
    ISet<JobGrade>? grades,
    IList<int>? directionIds,
    IList<ContactItem>? contacts,
    bool? isSubmitted,
  }) => VacancyFormState._(
    link: link ?? this.link,
    comment: comment ?? this.comment,
    grades: grades ?? this.grades,
    directionIds: directionIds ?? this.directionIds,
    contacts: contacts ?? this.contacts,
    isSubmitted: isSubmitted ?? this.isSubmitted,
  );

  @override
  List<Object?> get props => [
    link,
    comment,
    grades,
    directionIds,
    contacts,
    isSubmitted,
  ];

  bool get canSubmit =>
      link.canSubmit &&
      contacts.every((c) => c.value.canSubmit) &&
      !isSubmitted;
}

class VacancyFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<VacancyFormState, VacancyFormArgs> {
  static const _linkValidators = [AppValidator.required, AppValidator.url];

  late final repository = ref.read(vacanciesRepository);

  VacancyFormNotifier();

  @override
  FutureOr<VacancyFormState> build(VacancyFormArgs args) async {
    if (args.vacancyId != null) {
      final vacancy = await repository.select(arg.vacancyId!).getSingleOrNull();

      if (vacancy == null) {
        throw Exception('Вакансия не найдена');
      }

      return VacancyFormState(
        link: vacancy.link,
        comment: vacancy.comment,
        grades: vacancy.grades,
        directionIds: vacancy.directions.map((d) => d.id).toIList(),
        contacts: [
          for (final c in vacancy.contacts)
            ContactItem(c.type, AppFormField(value: c.value)),
        ].lock,
      );
    }

    return VacancyFormState();
  }

  void changeLink(String value) {
    state = AsyncValue.data(
      state.requireValue.copyWith(
        link: AppFormField(
          value: value,
          error: _linkValidators.validate(value) ?? '',
        ),
      ),
    );
  }

  void changeComment(String value) {
    state = AsyncValue.data(state.requireValue.copyWith(comment: value));
  }

  void toggleGrade(JobGrade grade) {
    final current = state.requireValue;

    final changedGrades = current.grades.contains(grade)
        ? current.grades.remove(grade)
        : current.grades.add(grade);

    state = AsyncValue.data(current.copyWith(grades: changedGrades));
  }

  void toggleDirection(int directionId) {
    final current = state.requireValue;

    final directionIds = current.directionIds.contains(directionId)
        ? current.directionIds.remove(directionId)
        : current.directionIds.add(directionId);

    state = AsyncValue.data(current.copyWith(directionIds: directionIds));
  }

  void moveDirection(int from, int to) {
    final current = state.requireValue;
    final directionIds = current.directionIds;

    if (from == to ||
        !directionIds.isValidIndex(from) ||
        !directionIds.isValidIndex(to)) {
      return;
    }

    final value = directionIds[from];
    to = to > from ? to - 1 : to;

    final changedDirectionIds = directionIds.removeAt(from).insert(to, value);

    state = AsyncValue.data(
      current.copyWith(directionIds: changedDirectionIds),
    );
  }

  void addContact() {
    state = AsyncValue.data(
      state.requireValue.copyWith(
        contacts: state.requireValue.contacts.add(
          ContactItem(ContactType.phone, AppFormField(value: '')),
        ),
      ),
    );
  }

  void removeContact(int index) {
    final current = state.requireValue;

    state = AsyncValue.data(
      current.copyWith(contacts: current.contacts.removeAt(index)),
    );
  }

  void changeContactType(int index, ContactType type) {
    final current = state.requireValue;

    if (!current.contacts.isValidIndex(index)) {
      return;
    }

    final value = current.contacts[index].value;

    state = AsyncValue.data(
      current.copyWith(
        contacts: current.contacts.replace(
          index,
          ContactItem(type, value).getValidated(),
        ),
      ),
    );
  }

  void changeContactValue(int index, String value) {
    final current = state.requireValue;

    if (!current.contacts.isValidIndex(index)) {
      return;
    }

    state = AsyncValue.data(
      current.copyWith(
        contacts: current.contacts.replace(
          index,
          current.contacts[index].getValidated(value),
        ),
      ),
    );
  }

  bool _validateContacts() {
    final current = state.requireValue;
    final contacts = current.contacts.unlock;
    var errorsCount = 0;

    for (final (index, contact) in current.contacts.indexed) {
      final validatedContact = contact.getValidated(contact.value.value);

      if (validatedContact.value.error.isNotEmpty) {
        contacts[index] = validatedContact;
        errorsCount++;
      }
    }

    if (errorsCount > 0) {
      state = AsyncValue.data(current.copyWith(contacts: contacts.lock));
      return false;
    }

    return true;
  }

  Future<void> submit() async {
    final current = state.requireValue;

    if (!current.canSubmit) {
      return;
    }

    final linkError = _linkValidators.validate(current.link.value);

    if (linkError != null) {
      state = AsyncValue.data(
        current.copyWith(
          link: AppFormField(value: current.link.value, error: linkError),
        ),
      );
      return;
    }

    if (!_validateContacts()) {
      return;
    }

    state = const AsyncValue.loading();

    final contacts = current.contacts
        .map((c) => Contact(type: c.type, value: c.value.value))
        .toIList();

    try {
      if (arg.vacancyId == null) {
        await repository.insert(
          VacancySaveArgs(
            companyId: arg.companyId,
            link: current.link.value,
            comment: current.comment,
            grades: current.grades,
            directionIds: current.directionIds.toISet(),
            contacts: contacts,
          ),
        );
      } else {
        await repository.update(
          VacancySaveArgs(
            id: arg.vacancyId!,
            companyId: arg.companyId,
            link: current.link.value,
            comment: current.comment,
            grades: current.grades,
            directionIds: current.directionIds.toISet(),
            contacts: contacts,
          ),
        );
      }

      state = AsyncValue.data(current.copyWith(isSubmitted: true));
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

class VacancyFormArgs extends Equatable {
  final int? vacancyId;
  final int companyId;

  const VacancyFormArgs({this.vacancyId, required this.companyId});

  @override
  List<Object?> get props => [vacancyId, companyId];
}

final vacancyFormProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      VacancyFormNotifier,
      VacancyFormState,
      VacancyFormArgs
    >(() => VacancyFormNotifier());

final jobDirectionsProvider = AutoDisposeFutureProvider((ref) {
  final db = ref.watch(dbProvider);
  return db.select(db.jobDirections).get();
});
