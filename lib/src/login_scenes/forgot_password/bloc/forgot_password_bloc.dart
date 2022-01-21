import 'dart:async';

import 'package:akademi_al_mobile_app/packages/send_email_repository/lib/send_email_api_provider.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/forgot_password/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:meta/meta.dart';

part 'forgot_password_event.dart';

part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(this.apiProvider) : super(ForgotPasswordState());

  final SendEmailApiProvider apiProvider;
  @override
  Stream<ForgotPasswordState> mapEventToState(
    ForgotPasswordEvent event,
  ) async* {
    if (event is ForgotPasswordEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if(event is SendSubmitted) {
      yield* _mapSendToState(event, state);
    }
  }

  ForgotPasswordState _mapEmailChangedToState(
      ForgotPasswordEmailChanged event, ForgotPasswordState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(email: email, status: Formz.validate([email]));
  }

  Stream<ForgotPasswordState> _mapSendToState(
      SendSubmitted event, ForgotPasswordState state) async*{
    yield state.copyWith(
      status: FormzStatus.submissionInProgress,
    );
    print("${state.resentEmail}");
    print("${state.sentEmail}");
    try {
      await apiProvider.sendForgotPasswordEmail(state.email.value);
      final test = state.copyWith(sentEmail: true, resentEmail: state.sentEmail);
      yield test;
    } catch(e) {
      yield state.copyWith(
        emailExist: false
      );
    }
  }
}
