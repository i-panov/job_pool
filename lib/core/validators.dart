import 'package:validators/validators.dart';

enum AppValidator {
  required('Обязательное поле'),
  url('Некорректный URL'),
  email('Некорректный email');

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
