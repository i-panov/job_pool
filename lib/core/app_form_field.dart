import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

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

  bool get hasError => error.isNotEmpty;

  bool get canSubmit => !isValidating && !hasError;

  @override
  List<Object?> get props => [value, error, isValidating, key];
}
