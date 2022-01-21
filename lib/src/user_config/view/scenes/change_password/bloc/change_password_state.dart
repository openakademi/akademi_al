part of 'change_password_bloc.dart';

class ChangePasswordState extends Equatable {
  const ChangePasswordState(
      {this.password = const NonEmptyField.pure(),
      this.newPassword = const Password.pure(),
      this.newRepeatedPassword = const Password.pure(),
      this.submitting,
      this.pageStatus,
      this.success});

  final NonEmptyField password;
  final Password newPassword;
  final Password newRepeatedPassword;
  final bool submitting;
  final bool success;
  final FormzStatus pageStatus;

  ChangePasswordState copyWith(
      {NonEmptyField password,
      Password newPassword,
      Password newRepeatedPassword,
      bool submitting,
      FormzStatus pageStatus,
      bool success}) {
    return new ChangePasswordState(
      password: password ?? this.password,
      newPassword: newPassword ?? this.newPassword,
      newRepeatedPassword: newRepeatedPassword ?? this.newRepeatedPassword,
      submitting: submitting ?? this.submitting,
      pageStatus: pageStatus ?? this.pageStatus,
      success: success ?? this.success,
    );
  }

  @override
  List<Object> get props => [
        password,
        newPassword,
        newRepeatedPassword,
        submitting,
        pageStatus,
        success
      ];
}
