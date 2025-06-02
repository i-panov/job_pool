import 'package:validators/validators.dart';

final _phoneRegex = RegExp(r'\+?\d{1,4} ?\(?\d{1,3}\)? ?\d{1,4} ?\d{1,4} ?\d{1,4}');

enum AppValidator {
  required('Обязательное поле'),
  url('Некорректный URL'),
  email('Некорректный email'),
  phone('Некорректный телефон');

  final String error;

  const AppValidator(this.error);

  bool Function(String) get isValid => switch (this) {
    AppValidator.required => (value) => value.isNotEmpty,
    AppValidator.url => (value) => isURL(
      value,
      protocols: ['http', 'https'],
      requireTld: true,
    ),
    AppValidator.email => (value) => isEmail(value),
    AppValidator.phone => (value) => _phoneRegex.hasMatch(value),
  };
}

extension AppValidatorExtension on Iterable<AppValidator> {
  String? validate(String value) {
    for (final validator in this) {
      if (!validator.isValid(value)) {
        return validator.error;
      }
    }

    return null;
  }
}
