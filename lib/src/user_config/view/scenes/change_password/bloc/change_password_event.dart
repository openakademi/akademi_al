part of 'change_password_bloc.dart';

class ChangePasswordEvent extends Equatable {
  const ChangePasswordEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentPassword extends ChangePasswordEvent {
  final String currentPassword;

  ChangeCurrentPassword(this.currentPassword);

  @override
  List<Object> get props => [currentPassword];
}

class ChangeNewPassword extends ChangePasswordEvent {
  final String newPassword;

  ChangeNewPassword(this.newPassword);

  @override
  List<Object> get props => [newPassword];
}


class ChangeRepeatPassword extends ChangePasswordEvent {
  final String repeatPassword;

  ChangeRepeatPassword(this.repeatPassword);

  @override
  List<Object> get props => [repeatPassword];
}


class ChangePasswordRequest extends ChangePasswordEvent {

  @override
  List<Object> get props => [];
}

