import 'package:drift/drift.dart';
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
  final String error;
  final bool isLoading, isSubmitted;

  CompanyFormState({
    String name = '',
    this.isIT = false,
    Iterable<String> links = const [],
    this.comment = '',
    this.error = '',
    this.isLoading = false,
  }) : name = AppFormField(value: name),
       links = links.map((link) => AppFormField(value: link)).toIList(),
       isSubmitted = false;

  const CompanyFormState._({
    required this.name,
    this.isIT = false,
    this.links = const IList.empty(),
    this.comment = '',
    this.error = '',
    this.isLoading = false,
    this.isSubmitted = false,
  });

  CompanyFormState copyWith({
    AppFormField<String>? name,
    bool? isIT,
    IList<AppFormField<String>>? links,
    String? comment,
    String? error,
    bool? isLoading,
    bool? isSubmitted,
  }) => CompanyFormState._(
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    links: links ?? this.links,
    comment: comment ?? this.comment,
    error: error ?? this.error,
    isLoading: isLoading ?? this.isLoading,
    isSubmitted: isSubmitted ?? this.isSubmitted,
  );

  @override
  List<Object?> get props => [
    name,
    isIT,
    links,
    comment,
    error,
    isLoading,
    isSubmitted,
  ];

  bool get canSubmit =>
      name.canSubmit &&
      links.every((l) => l.canSubmit) &&
      error.isEmpty &&
      !isLoading &&
      !isSubmitted;
}

class CompanyFormNotifier extends StateNotifier<CompanyFormState> {
  static const _nameValidators = [AppValidator.required];

  static const _urlValidators = [AppValidator.required, AppValidator.url];

  final AppDatabase db;
  final int? companyId;

  CompanyFormNotifier({required this.db, this.companyId})
    : super(CompanyFormState(isLoading: companyId != null)) {
    _init();
  }

  Future<void> _init() async {
    if (companyId != null) {
      final company = await db.getCompany(companyId!);

      if (company != null) {
        state = state.copyWith(
          name: state.name.copyWith(value: company.name),
          isIT: company.isIT,
          links: company.links
              .map((link) => AppFormField(value: link))
              .toIList(),
          isLoading: false,
        );
      } else {
        state = state.copyWith(error: 'Компания не найдена', isLoading: false);
      }
    }
  }

  void changeName(String value) {
    state = state.copyWith(
      name: state.name.copyWith(
        value: value,
        error: _nameValidators.validate(value) ?? '',
      ),
    );
  }

  void changeComment(String value) {
    state = state.copyWith(comment: value);
  }

  void changeIsIT(bool value) {
    state = state.copyWith(isIT: value);
  }

  void addLink() {
    state = state.copyWith(links: state.links.add(AppFormField(value: '')));
  }

  void removeLink(int index) {
    if (!_checkLinksIndex(index)) {
      return;
    }

    state = state.copyWith(links: state.links.removeAt(index));
  }

  void changeLink(int index, String value) {
    if (!_checkLinksIndex(index)) {
      return;
    }

    final link = state.links[index].copyWith(
      value: value,
      error: _urlValidators.validate(value) ?? '',
    );

    state = state.copyWith(links: state.links.replace(index, link));
  }

  void moveLink(int from, int to) {
    if (from == to || !_checkLinksIndex(from) || !_checkLinksIndex(to)) {
      return;
    }

    final value = state.links[from];
    to = to > from ? to - 1 : to;
    state = state.copyWith(links: state.links.removeAt(from).insert(to, value));
  }

  Future<bool> _validateNameAsync() async {
    state = state.copyWith(name: state.name.copyWith(isValidating: true));

    try {
      final company = await db.findCompanyByName(state.name.value);

      if (company != null && (companyId == null || company.id != companyId)) {
        state = state.copyWith(
          name: state.name.copyWith(
            error: 'Название занято',
            isValidating: false,
          ),
        );

        return false;
      }
    } catch (e) {
      state = state.copyWith(
        name: state.name.copyWith(error: e.toString(), isValidating: false),
      );

      return false;
    } finally {
      state = state.copyWith(name: state.name.copyWith(isValidating: false));
    }

    return true;
  }

  Future<bool> _validateName() async {
    final nameError = _nameValidators.validate(state.name.value) ?? '';

    if (nameError.isNotEmpty) {
      state = state.copyWith(name: state.name.copyWith(error: nameError));
      return false;
    }

    if (!(await _validateNameAsync())) {
      return false;
    }

    return true;
  }

  bool _validateLinks() {
    final links = state.links.unlock;
    var errorsCount = 0;

    for (final (index, link) in state.links.indexed) {
      final error = _urlValidators.validate(link.value) ?? '';

      if (error.isNotEmpty) {
        links[index] = links[index].copyWith(error: error);
        errorsCount++;
      }
    }

    if (errorsCount > 0) {
      state = state.copyWith(links: links.lock);
      return false;
    }

    return true;
  }

  Future<void> submit() async {
    if (!state.canSubmit) {
      return;
    }

    if (!await _validateName()) {
      return;
    }

    if (!_validateLinks()) {
      return;
    }

    state = state.copyWith(isLoading: true);

    final commentValue = state.comment.isEmpty
        ? Value<String>.absent()
        : Value(state.comment);

    if (companyId != null) {
      final stmt = db.update(db.companies)
        ..where((c) => c.id.equals(companyId!));

      await stmt.write(
        CompaniesCompanion(
          name: Value(state.name.value),
          isIT: Value(state.isIT),
          links: Value(state.links.map((l) => l.value).toISet()),
          comment: commentValue,
        ),
      );
    } else {
      await db
          .into(db.companies)
          .insert(
            CompaniesCompanion.insert(
              name: state.name.value,
              isIT: state.isIT,
              links: state.links.map((l) => l.value).toISet(),
              comment: commentValue,
            ),
          );
    }

    state = state.copyWith(isLoading: false, isSubmitted: true);
  }

  bool _checkLinksIndex(int index) => index >= 0 && index < state.links.length;
}

final companyFormProvider =
    AutoDisposeStateNotifierProvider.family<
      CompanyFormNotifier,
      CompanyFormState,
      int?
    >((ref, companyId) {
      return CompanyFormNotifier(
        db: ref.watch(dbProvider),
        companyId: companyId,
      );
    });
