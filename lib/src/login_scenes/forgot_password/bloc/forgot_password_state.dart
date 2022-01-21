part of 'forgot_password_bloc.dart';

@immutable
class ForgotPasswordState extends Equatable {
  final Email email;
  final FormzStatus status;
  final bool sentEmail;
  final bool emailExist;
  final bool resentEmail;

  ForgotPasswordState({this.email = const Email.pure(),
    this.status = FormzStatus.pure,
    this.sentEmail = false,
    this.emailExist = true,
    this.resentEmail = false
  });

  ForgotPasswordState copyWith({
    Email email,
    FormzStatus status,
    bool sentEmail,
    bool emailExist,
    bool resentEmail,
  }) {
    return new ForgotPasswordState(
        email: email ?? this.email,
        status: status ?? this.status,
        sentEmail: sentEmail ?? this.sentEmail,
        emailExist: emailExist ?? this.emailExist,
        resentEmail: resentEmail ?? this.resentEmail
    );
  }

  @override
  List<Object> get props => [email, status, sentEmail, emailExist, resentEmail];
}
