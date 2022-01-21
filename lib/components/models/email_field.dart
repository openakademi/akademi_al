import 'package:email_validator/email_validator.dart';
import 'package:formz/formz.dart';

enum EmailFieldValidationError { notEmail }

class EmailField extends FormzInput<String, EmailFieldValidationError> {
  const EmailField.pure() : super.pure('');
  const EmailField.dirty([String value = '']) : super.dirty(value);

  @override
  EmailFieldValidationError validator(String value) {
    return EmailValidator.validate(value) ? null : EmailFieldValidationError.notEmail;
  }
}
