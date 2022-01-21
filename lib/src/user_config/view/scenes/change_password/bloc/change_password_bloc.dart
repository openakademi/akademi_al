import 'dart:async';

import 'package:akademi_al_mobile_app/components/models/non_empty_field.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'change_password_event.dart';

part 'change_password_state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc({this.userRepository}) : super(ChangePasswordState());
  final UserRepository userRepository;

  @override
  Stream<ChangePasswordState> mapEventToState(
    ChangePasswordEvent event,
  ) async* {
    if (event is ChangeCurrentPassword) {
      yield _mapChangeCurrentPasswordToState(event, state);
    } else if (event is ChangeNewPassword) {
      yield _mapChangeNewPassword(event, state);
    } else if (event is ChangeRepeatPassword) {
      yield _mapChangeRepeatPassword(event, state);
    } else if (event is ChangePasswordRequest) {
      yield* _mapChangePasswordRequestToState(event, state);
    }
  }

  ChangePasswordState _mapChangeCurrentPasswordToState(
      ChangeCurrentPassword event, ChangePasswordState state) {
    final password = NonEmptyField.dirty(event.currentPassword);

    return state.copyWith(
      password: password,
      pageStatus: Formz.validate(
          [password, state.newPassword, state.newRepeatedPassword]),
    );
  }

  ChangePasswordState _mapChangeNewPassword(
      ChangeNewPassword event, ChangePasswordState state) {
    final password = Password.dirty(event.newPassword);

    return state.copyWith(
        newPassword: password,
        pageStatus: Formz.validate(
            [password, state.newRepeatedPassword, state.password]));
  }

  ChangePasswordState _mapChangeRepeatPassword(
      ChangeRepeatPassword event, ChangePasswordState state) {
    final password = Password.dirty(event.repeatPassword);

    return state.copyWith(
        newRepeatedPassword: password,
        pageStatus:
            Formz.validate([password, state.newPassword, state.password]));
  }

  Stream<ChangePasswordState> _mapChangePasswordRequestToState(
      ChangePasswordRequest event, ChangePasswordState state) async* {
    yield state.copyWith(submitting: true);
    try {
      await userRepository.changePassword(
          state.password.value, state.newPassword.value);
      yield state.copyWith(submitting: false, success: true);
    } catch (e) {
      yield state.copyWith(submitting: false, success: false);
    }
  }
}
