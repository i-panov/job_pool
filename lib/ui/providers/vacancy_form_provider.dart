import 'package:drift/drift.dart';
import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/core/app_form_field.dart';
import 'package:job_pool/core/validators.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/data/storage/schemas/dictionaries.dart';
import 'package:job_pool/ui/providers/app_providers.dart';

class ContactItem extends Equatable {
  final ContactType type;
  final AppFormField<String> value;

  const ContactItem(this.type, this.value);

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
  final String comment, error;
  final bool isLoading, isSubmitted;

  VacancyFormState({
    String link = '',
    this.comment = '',
    this.grades = const ISet.empty(),
    this.directionIds = const IList.empty(),
    this.contacts = const IList.empty(),
    this.error = '',
    this.isLoading = false,
    this.isSubmitted = false,
  }) : link = AppFormField(value: link);

  const VacancyFormState._({
    required this.link,
    required this.comment,
    this.grades = const ISet.empty(),
    this.directionIds = const IList.empty(),
    this.contacts = const IList.empty(),
    this.error = '',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  VacancyFormState copyWith({
    AppFormField<String>? link,
    String? comment,
    ISet<JobGrade>? grades,
    IList<int>? directionIds,
    IList<ContactItem>? contacts,
    String? error,
    bool? isLoading,
    bool? isSubmitted,
  }) => VacancyFormState._(
    link: link ?? this.link,
    comment: comment ?? this.comment,
    grades: grades ?? this.grades,
    directionIds: directionIds ?? this.directionIds,
    contacts: contacts ?? this.contacts,
    error: error ?? this.error,
    isLoading: isLoading ?? this.isLoading,
    isSubmitted: isSubmitted ?? this.isSubmitted,
  );

  @override
  List<Object?> get props => [
    link,
    comment,
    grades,
    directionIds,
    contacts,
    error,
    isLoading,
    isSubmitted,
  ];

  bool get canSubmit =>
      link.canSubmit &&
      contacts.every((c) => c.value.canSubmit) &&
      error.isEmpty &&
      !isLoading &&
      !isSubmitted;
}

class VacancyFormNotifier
    extends AutoDisposeFamilyNotifier<VacancyFormState, VacancyFormParams> {
  static const _linkValidators = [AppValidator.required, AppValidator.url];

  late final db = ref.read(dbProvider);

  VacancyFormNotifier();

  @override
  VacancyFormState build(VacancyFormParams params) {
    if (params.vacancyId != null) {
      Future.microtask(_init);
    }

    return VacancyFormState(isLoading: params.vacancyId != null);
  }

  Future<void> _init() async {
    if (arg.vacancyId != null) {
      final vacancy = await db.getVacancy(arg.vacancyId!);

      if (vacancy != null) {
        final directionIds = await db.getVacancyDirectionIds(arg.vacancyId!);
        final contacts = await db.getVacancyContacts(arg.vacancyId!);

        state = state.copyWith(
          link: AppFormField(value: vacancy.link),
          comment: vacancy.comment,
          grades: vacancy.grades,
          directionIds: directionIds.toIList(),
          contacts: contacts
              .map(
                (c) => ContactItem(
                  c.contactType,
                  AppFormField(value: c.contactValue),
                ),
              )
              .toIList(),
          isLoading: false,
        );
      } else {
        state = state.copyWith(error: 'Вакансия не найдена', isLoading: false);
      }
    }
  }

  void changeLink(String value) {
    state = state.copyWith(
      link: AppFormField(
        value: value,
        error: _linkValidators.validate(value) ?? '',
      ),
    );
  }

  void changeComment(String value) {
    state = state.copyWith(comment: value);
  }

  void toggleGrade(JobGrade grade) {
    if (state.grades.contains(grade)) {
      state = state.copyWith(grades: state.grades.remove(grade));
    } else {
      state = state.copyWith(grades: state.grades.add(grade));
    }
  }

  void toggleDirection(int directionId) {
    if (state.directionIds.contains(directionId)) {
      state = state.copyWith(
        directionIds: state.directionIds.remove(directionId),
      );
    } else {
      state = state.copyWith(directionIds: state.directionIds.add(directionId));
    }
  }

  void moveDirection(int from, int to) {
    if (from == to ||
        !_checkDirectionsIndex(from) ||
        !_checkDirectionsIndex(to)) {
      return;
    }

    final value = state.directionIds[from];
    to = to > from ? to - 1 : to;

    state = state.copyWith(
      directionIds: state.directionIds.removeAt(from).insert(to, value),
    );
  }

  bool _checkDirectionsIndex(int index) =>
      index >= 0 && index < state.directionIds.length;

  void addContact() {
    state = state.copyWith(
      contacts: state.contacts.add(
        ContactItem(ContactType.phone, AppFormField(value: '')),
      ),
    );
  }

  void removeContact(int index) {
    state = state.copyWith(contacts: state.contacts.removeAt(index));
  }

  void changeContactType(int index, ContactType type) {
    if (index < 0 || index >= state.contacts.length) {
      return;
    }

    final value = state.contacts[index].value;

    state = state.copyWith(
      contacts: state.contacts.replace(
        index,
        ContactItem(type, value).getValidated(),
      ),
    );
  }

  void changeContactValue(int index, String value) {
    if (index < 0 || index >= state.contacts.length) {
      return;
    }

    state = state.copyWith(
      contacts: state.contacts.replace(
        index,
        state.contacts[index].getValidated(value),
      ),
    );
  }

  bool _validateContacts() {
    final contacts = state.contacts.unlock;
    var errorsCount = 0;

    for (final (index, contact) in state.contacts.indexed) {
      final validatedContact = contact.getValidated(contact.value.value);

      if (validatedContact.value.error.isNotEmpty) {
        contacts[index] = validatedContact;
        errorsCount++;
      }
    }

    if (errorsCount > 0) {
      state = state.copyWith(contacts: contacts.lock);
      return false;
    }

    return true;
  }

  Future<void> submit() async {
    if (!state.canSubmit) {
      return;
    }

    final linkError = _linkValidators.validate(state.link.value);

    if (linkError != null) {
      state = state.copyWith(
        link: AppFormField(value: state.link.value, error: linkError),
      );
      return;
    }

    if (!_validateContacts()) {
      return;
    }

    state = state.copyWith(isLoading: true);

    if (arg.vacancyId == null) {
      await db.insertVacancy(
        companyId: arg.companyId,
        link: state.link.value,
        comment: state.comment,
        grades: state.grades,
        directionIds: state.directionIds,
        contactsList: state.contacts
            .map((c) => (type: c.type, value: c.value.value))
            .toIList(),
      );
    } else {
      await db.updateVacancy(
        id: arg.vacancyId!,
        link: state.link.value,
        comment: state.comment,
        grades: state.grades,
        directionIds: state.directionIds,
        contactsList: state.contacts
            .map((c) => (type: c.type, value: c.value.value))
            .toIList(),
      );
    }

    state = state.copyWith(isLoading: false, isSubmitted: true);
  }
}

class VacancyFormParams extends Equatable {
  final int? vacancyId;
  final int companyId;

  const VacancyFormParams({this.vacancyId, required this.companyId});

  @override
  List<Object?> get props => [vacancyId, companyId];
}

final vacancyFormProvider =
    AutoDisposeNotifierProviderFamily<
      VacancyFormNotifier,
      VacancyFormState,
      VacancyFormParams
    >(() => VacancyFormNotifier());

final jobDirectionsProvider = AutoDisposeFutureProvider((ref) {
  final db = ref.watch(dbProvider);
  return db.select(db.jobDirections).get();
});
