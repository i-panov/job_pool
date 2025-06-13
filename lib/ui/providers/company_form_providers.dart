import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/core/app_form_field.dart';
import 'package:job_pool/core/validators.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/ui/providers/app_providers.dart';

class CompanyFormState extends Equatable {
  final AppFormField<String> name;
  final bool isIT;
  final IList<AppFormField<String>> links;
  final String comment;
  final bool isSubmitted;

  CompanyFormState({
    String name = '',
    this.isIT = false,
    Iterable<String> links = const [],
    this.comment = '',
  }) : name = AppFormField(value: name),
       links = links.map((link) => AppFormField(value: link)).toIList(),
       isSubmitted = false;

  const CompanyFormState._({
    required this.name,
    this.isIT = false,
    this.links = const IList.empty(),
    this.comment = '',
    this.isSubmitted = false,
  });

  CompanyFormState copyWith({
    AppFormField<String>? name,
    bool? isIT,
    IList<AppFormField<String>>? links,
    String? comment,
    bool? isSubmitted,
  }) => CompanyFormState._(
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    links: links ?? this.links,
    comment: comment ?? this.comment,
    isSubmitted: isSubmitted ?? this.isSubmitted,
  );

  @override
  List<Object?> get props => [name, isIT, links, comment, isSubmitted];

  bool get canSubmit =>
      name.canSubmit && links.every((l) => l.canSubmit) && !isSubmitted;
}

class CompanyFormNotifier
    extends AutoDisposeFamilyAsyncNotifier<CompanyFormState, int?> {
  static const _nameValidators = [AppValidator.required];

  static const _urlValidators = [AppValidator.required, AppValidator.url];

  late final AppDatabase db = ref.watch(dbProvider);

  CompanyFormNotifier();

  @override
  FutureOr<CompanyFormState> build(int? companyId) async {
    if (companyId != null) {
      final company = await db.getCompany(companyId);

      if (company == null) {
        throw Exception('Компания не найдена');
      }

      return CompanyFormState(
        name: company.name,
        isIT: company.isIT,
        links: company.links,
        comment: company.comment,
      );
    }

    return CompanyFormState();
  }

  void changeName(String value) {
    final current = state.requireValue;

    state = AsyncValue.data(
      current.copyWith(
        name: current.name.copyWith(
          value: value,
          error: _nameValidators.validate(value) ?? '',
        ),
      ),
    );
  }

  void changeComment(String value) {
    state = AsyncValue.data(state.requireValue.copyWith(comment: value));
  }

  void changeIsIT(bool value) {
    state = AsyncValue.data(state.requireValue.copyWith(isIT: value));
  }

  void addLink() {
    final current = state.requireValue;

    state = AsyncValue.data(
      current.copyWith(
        links: current.links.add(AppFormField(value: '', error: '')),
      ),
    );
  }

  void removeLink(int index) {
    if (!_checkLinksIndex(index)) {
      return;
    }

    final current = state.requireValue;

    state = AsyncValue.data(
      current.copyWith(links: current.links.removeAt(index)),
    );
  }

  void changeLink(int index, String value) {
    if (!_checkLinksIndex(index)) {
      return;
    }

    final current = state.requireValue;

    final link = current.links[index].copyWith(
      value: value,
      error: _urlValidators.validate(value) ?? '',
    );

    state = AsyncValue.data(
      current.copyWith(links: current.links.replace(index, link)),
    );
  }

  void moveLink(int from, int to) {
    if (from == to || !_checkLinksIndex(from) || !_checkLinksIndex(to)) {
      return;
    }

    final current = state.requireValue;
    final value = current.links[from];
    to = to > from ? to - 1 : to;

    state = AsyncValue.data(
      current.copyWith(links: current.links.removeAt(from).insert(to, value)),
    );
  }

  Future<bool> _validateNameAsync() async {
    final current = state.requireValue;
    state = AsyncValue.data(
      current.copyWith(name: current.name.copyWith(isValidating: true)),
    );

    try {
      final company = await db.findCompanyByName(current.name.value);

      if (company != null && (arg == null || company.id != arg)) {
        state = AsyncValue.data(
          current.copyWith(
            name: current.name.copyWith(
              error: 'Название занято',
              isValidating: false,
            ),
          ),
        );

        return false;
      }
    } catch (e) {
      state = AsyncValue.data(
        current.copyWith(
          name: current.name.copyWith(error: e.toString(), isValidating: false),
        ),
      );

      return false;
    } finally {
      state = AsyncValue.data(
        current.copyWith(name: current.name.copyWith(isValidating: false)),
      );
    }

    return true;
  }

  Future<bool> _validateName() async {
    final current = state.requireValue;
    final nameError = _nameValidators.validate(current.name.value) ?? '';

    if (nameError.isNotEmpty) {
      state = AsyncValue.data(
        current.copyWith(name: current.name.copyWith(error: nameError)),
      );
      return false;
    }

    if (!(await _validateNameAsync())) {
      return false;
    }

    return true;
  }

  bool _validateLinks() {
    final current = state.requireValue;
    final links = current.links.unlock;
    var errorsCount = 0;

    for (final (index, link) in current.links.indexed) {
      final error = _urlValidators.validate(link.value) ?? '';

      if (error.isNotEmpty) {
        links[index] = links[index].copyWith(error: error);
        errorsCount++;
      }
    }

    if (errorsCount > 0) {
      state = AsyncValue.data(current.copyWith(links: links.lock));
      return false;
    }

    return true;
  }

  Future<void> submit() async {
    final current = state.requireValue;

    if (!current.canSubmit) {
      return;
    }

    if (!await _validateName()) {
      return;
    }

    if (!_validateLinks()) {
      return;
    }

    state = const AsyncValue.loading();

    if (arg != null) {
      await db.updateCompany(
        id: arg!,
        name: current.name.value,
        isIT: current.isIT,
        links: current.links.map((l) => l.value).toISet(),
        comment: current.comment,
      );
    } else {
      await db.insertCompany(
        name: current.name.value,
        isIT: current.isIT,
        links: current.links.map((l) => l.value).toISet(),
        comment: current.comment,
      );
    }

    state = AsyncValue.data(current.copyWith(isSubmitted: true));
  }

  bool _checkLinksIndex(int index) {
    final links = state.valueOrNull?.links;
    return index >= 0 && links != null && index < links.length;
  }
}

final companyFormProvider =
    AutoDisposeAsyncNotifierProviderFamily<
      CompanyFormNotifier,
      CompanyFormState,
      int?
    >(() => CompanyFormNotifier());
