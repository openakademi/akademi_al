part of 'register_bloc.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();
}

class RegisterNameChanged extends RegisterEvent {
  const RegisterNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class RegisterSurnameChanged extends RegisterEvent {
  const RegisterSurnameChanged(this.surname);

  final String surname;

  @override
  List<Object> get props => [surname];
}

class RegisterBirthdayChanged extends RegisterEvent {
  const RegisterBirthdayChanged(this.birthday);

  final String birthday;

  @override
  List<Object> get props => [birthday];
}

class RegisterEmailChanged extends RegisterEvent {
  const RegisterEmailChanged(this.email);

  final String email;

  @override
  List<Object> get props => [email];
}

class RegisterUsernameChanged extends RegisterEvent {
  const RegisterUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

class RegisterPasswordChanged extends RegisterEvent {
  final String password;

  RegisterPasswordChanged(this.password);

  @override
  List<Object> get props => [password];
}

class NextPage extends RegisterEvent {
  NextPage();

  @override
  List<Object> get props => [];
}

class PreviousPage extends RegisterEvent {
  PreviousPage();

  @override
  List<Object> get props => [];
}

class FinishRegistration extends RegisterEvent {
  final String tokenResult;

  FinishRegistration(this.tokenResult);

  @override
  List<Object> get props => [];
}

class ResendEmail extends RegisterEvent {
  ResendEmail();

  @override
  List<Object> get props => [];
}
