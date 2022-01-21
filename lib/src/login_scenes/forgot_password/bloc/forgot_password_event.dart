part of 'forgot_password_bloc.dart';

@immutable
abstract class ForgotPasswordEvent extends Equatable {}

class ForgotPasswordEmailChanged extends ForgotPasswordEvent {
  final String email;

  ForgotPasswordEmailChanged(this.email);

  @override
  List<Object> get props => [email];
}

class SendSubmitted extends ForgotPasswordEvent {
  @override
  List<Object> get props => [];
}
