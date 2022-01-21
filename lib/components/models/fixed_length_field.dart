import 'package:formz/formz.dart';

enum FixedLengthFieldValidationError { empty }

class FixedLengthField extends FormzInput<String, FixedLengthFieldValidationError> {
  const FixedLengthField.pure() : super.pure('');
  const FixedLengthField.dirty([String value = '']) : super.dirty(value);

  @override
  FixedLengthFieldValidationError validator(String value) {
    return value?.isNotEmpty == true && value.length >= 8 ? null : FixedLengthFieldValidationError.empty;
  }
}
