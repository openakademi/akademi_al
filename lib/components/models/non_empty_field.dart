import 'package:formz/formz.dart';

enum NonEmptyFieldValidationError { empty }

class NonEmptyField extends FormzInput<String, NonEmptyFieldValidationError> {
  const NonEmptyField.pure() : super.pure('');
  const NonEmptyField.dirty([String value = '']) : super.dirty(value);

  @override
  NonEmptyFieldValidationError validator(String value) {
    return value?.isNotEmpty == true ? null : NonEmptyFieldValidationError.empty;
  }
}
