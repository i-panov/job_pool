import 'package:equatable/equatable.dart';
import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:job_pool/data/storage/db/db.dart';
import 'package:job_pool/ui/providers/app_providers.dart';
import 'package:validators/validators.dart';

class AppFormField<T> extends Equatable {
  final T value;
  final String error;
  final bool isValidating;
  final Key key;

  AppFormField({
    required this.value,
    this.error = '',
    this.isValidating = false,
    Key? key,
  }) : key = key ?? UniqueKey();

  AppFormField<T> copyWith({T? value, String? error, bool? isValidating}) =>
      AppFormField(
        value: value ?? this.value,
        error: error ?? this.error,
        isValidating: isValidating ?? this.isValidating,
        key: key,
      );

  String? get errorOrNull => error.isEmpty ? null : error;

  @override
  List<Object?> get props => [value, error, isValidating, key];
}

class CompanyFormState extends Equatable {
  final AppFormField<String> name;
  final bool isIT;
  final IList<AppFormField<String>> links;

  const CompanyFormState({
    required this.name,
    this.isIT = false,
    this.links = const IList.empty(),
  });

  CompanyFormState copyWith({
    AppFormField<String>? name,
    bool? isIT,
    IList<AppFormField<String>>? links,
  }) => CompanyFormState(
    name: name ?? this.name,
    isIT: isIT ?? this.isIT,
    links: links ?? this.links,
  );

  @override
  List<Object?> get props => [name, isIT, links];
}

String? validateString(
  String value,
  Map<String, bool Function(String)> validators,
) {
  for (final MapEntry(key: error, value: validate) in validators.entries) {
    if (!validate(value)) {
      return error;
    }
  }

  return null;
}

class CompanyFormNotifier extends StateNotifier<CompanyFormState> {
  final AppDatabase db;
  final int? companyId;

  CompanyFormNotifier({required this.db, this.companyId})
    : super(CompanyFormState(name: AppFormField(value: ''))) {
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
        );
      }
    }
  }

  void changeName(String value) {
    state = state.copyWith(
      name: state.name.copyWith(
        value: value,
        error: value.isEmpty ? 'Введите название компании' : '',
      ),
    );
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
      error: validateString(value, {
        'Ввежите URL': (value) => value.isEmpty,
        'Ввежите корректный URL': (value) => !_validateUrl(value),
      }),
    );

    state = state.copyWith(
      links: state.links.replace(index, link),
    );
  }

  void moveLink(int from, int to) {
    if (from == to || !_checkLinksIndex(from) || !_checkLinksIndex(to)) {
      return;
    }

    final value = state.links[from];
    to = to > from ? to - 1 : to;
    state = state.copyWith(links: state.links.removeAt(from).insert(to, value));
  }

  Future<void> validateName() async {
    if (state.name.value.isEmpty) {
      state = state.copyWith(
        name: state.name.copyWith(
          value: '',
          error: 'Ввежите название компании',
        ),
      );

      return;
    }

    state = state.copyWith(name: state.name.copyWith(isValidating: true));

    try {
      final company = await db.findCompanyByName(state.name.value);

      if (company != null && (companyId == null || company.id != companyId)) {
        state = state.copyWith(
          name: state.name.copyWith(
            error: 'Компания с таким названием уже существует',
            isValidating: false,
          ),
        );
      }
    } catch (e) {
      state = state.copyWith(
        name: state.name.copyWith(
          error: 'Не удалось проверить название компании',
          isValidating: false,
        ),
      );
    } finally {
      state = state.copyWith(name: state.name.copyWith(isValidating: false));
    }
  }

  bool _checkLinksIndex(int index) => index >= 0 && index < state.links.length;

  bool _validateUrl(String value) {
    return isURL(value, protocols: ['http', 'https'], requireTld: true);
  }
}

final companyFormProvider =
    StateNotifierProvider.family<CompanyFormNotifier, CompanyFormState, int?>((
      ref,
      companyId,
    ) {
      return CompanyFormNotifier(
        db: ref.watch(dbProvider),
        companyId: companyId,
      );
    });
