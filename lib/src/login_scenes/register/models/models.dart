import 'package:akademi_al_mobile_app/components/models/email_field.dart';
import 'package:akademi_al_mobile_app/components/models/non_empty_field.dart';
import 'package:formz/formz.dart';

final numberRegex = RegExp(r"[0-9]");
final lowercaseRegx = RegExp(r"[a-z]");
final uppercaseRegx = RegExp(r"[A-Z]");
final specialCharRegx = RegExp(r"[<>'()`.,\+\-_=\/\\|:;?{}[\]~?!@#$%^&*]");

class Name extends NonEmptyField {
  const Name.dirty(String name) : super.dirty(name);

  const Name.pure() : super.pure();
}

class Surname extends NonEmptyField {
  const Surname.dirty(String surname) : super.dirty(surname);

  const Surname.pure() : super.pure();
}

enum NonEmptyBirthdayFieldValidationError { empty, under3 }

class Birthday extends FormzInput<String, NonEmptyBirthdayFieldValidationError> {
  const Birthday.dirty(String birthday) : super.dirty(birthday);

  const Birthday.pure() : super.pure('');

  @override
  NonEmptyBirthdayFieldValidationError validator(String value) {
    try{
      var date = DateTime.tryParse(value);
      if(DateTime.now().year - date.year <= 3) {
        return NonEmptyBirthdayFieldValidationError.under3;
      }
    } catch (e) {

    }
    return value?.isNotEmpty == true ? null : NonEmptyBirthdayFieldValidationError.empty;
  }
}

class Email extends EmailField {
  const Email.dirty(String email) : super.dirty(email);

  const Email.pure() : super.pure();
}

class Username extends NonEmptyField {
  const Username.dirty(String username) : super.dirty(username);

  const Username.pure() : super.pure();
}

enum PasswordFieldValidationError {
  noEightChars,
  noMacro,
  noSpecialChar,
  notNumber
}

class Password extends FormzInput<String, List<PasswordFieldValidationError>> {
  const Password.pure() : super.pure('');

  const Password.dirty([String value = '']) : super.dirty(value);

  @override
  List<PasswordFieldValidationError> validator(String value) {
    List<PasswordFieldValidationError> errors = new List();

    if (value.length < 8) {
      errors.add(PasswordFieldValidationError.noEightChars);
    }
    if (!numberRegex.hasMatch(value)) {
      errors.add(PasswordFieldValidationError.notNumber);
    }
    if (!uppercaseRegx.hasMatch(value)) {
      errors.add(PasswordFieldValidationError.noMacro);
    }
    if (!specialCharRegx.hasMatch(value)) {
      errors.add(PasswordFieldValidationError.noSpecialChar);
    }
    return errors.isEmpty ? null: errors;
  }
}
