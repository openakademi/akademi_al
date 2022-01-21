import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/new_user_dto.dart';
import 'package:akademi_al_mobile_app/src/login_scenes/register/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'register_event.dart';

part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this.authenticationRepository) : super(RegisterState());

  final AuthenticationRepository authenticationRepository;

  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event,) async* {
    if (event is RegisterNameChanged) {
      yield _mapNameChangedToState(event, state);
    } else if (event is RegisterSurnameChanged) {
      yield _mapSurnameChangedToState(event, state);
    } else if (event is RegisterBirthdayChanged) {
      yield _mapBirthdayChangedToState(event, state);
    } else if (event is NextPage) {
      yield _mapNextPageToState(event, state);
    } else if (event is PreviousPage) {
      yield _mapPreviousPageToState(event, state);
    } else if (event is RegisterEmailChanged) {
      yield _mapEmailChangedToState(event, state);
    } else if (event is RegisterUsernameChanged) {
      yield _mapUsernameChangedToState(event, state);
    } else if (event is RegisterPasswordChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is FinishRegistration) {
      yield* _mapFinishRegistrationToState(event, state);
    } else if (event is ResendEmail) {
      yield* _mapResendEmailToState(event, state);
    }
  }

  RegisterState _mapNameChangedToState(RegisterNameChanged event,
      RegisterState state) {
    final name = Name.dirty(event.name);
    return state.copyWith(
        name: name, firstPageStatus: Formz.validate([state.surname, name]));
  }

  RegisterState _mapSurnameChangedToState(RegisterSurnameChanged event,
      RegisterState state) {
    final surname = Surname.dirty(event.surname);
    return state.copyWith(
        surname: surname,
        firstPageStatus: Formz.validate([state.name, surname]));
  }

  RegisterState _mapBirthdayChangedToState(RegisterBirthdayChanged event,
      RegisterState state) {
    final birthday = Birthday.dirty(event.birthday);
    DateTime dateTime = DateTime.tryParse(birthday.value);
    DateTime now = DateTime.now();
    final difference = (now
        .difference(dateTime)
        .inDays / 365).floor();
    return state.copyWith(
        birthday: birthday,
        isUnder13: difference < 13,
        secondPageStatus: Formz.validate([birthday]));
  }

  RegisterState _mapNextPageToState(NextPage event, RegisterState state) {
    final newIndex = state.currentIndex + 1;
    return state.copyWith(currentIndex: newIndex);
  }

  RegisterState _mapPreviousPageToState(PreviousPage event,
      RegisterState state) {
    final newIndex = state.currentIndex - 1;
    return state.copyWith(currentIndex: newIndex > 0 ? newIndex : 0, existingUser: false);
  }

  RegisterState _mapEmailChangedToState(RegisterEmailChanged event,
      RegisterState state) {
    final email = Email.dirty(event.email);
    return state.copyWith(
        email: email,
        thirdPageStatus:
        Formz.validate([email, if (state.isUnder13) state.username]));
  }

  RegisterState _mapUsernameChangedToState(RegisterUsernameChanged event,
      RegisterState state) {
    final username = Username.dirty(event.username);
    return state.copyWith(
        username: username,
        thirdPageStatus: Formz.validate([username, state.email]));
  }

  RegisterState _mapPasswordChangedToState(RegisterPasswordChanged event,
      RegisterState state) {
    final password = Password.dirty(event.password);
    return state.copyWith(
        password: password, fourthPageStatus: Formz.validate([password]), existingUser: false);
  }

  Stream<RegisterState> _mapFinishRegistrationToState(FinishRegistration event,
      RegisterState state) async* {
    yield state.copyWith(submitting: true);
    final uuid = Uuid().v4().toString();
    final newUser = new NewUserDto(
        id: uuid,
        email: state.isUnder13 ? null : state.email.value,
        parentEmail: state.isUnder13 ? state.email.value : null,
        username: state.isUnder13
            ? state.username.value
            : "${state.email.value.substring(
            0, state.email.value.indexOf("@"))}${Uuid().v4()
            .toString()
            .substring(0, 4)}",
        password: state.password.value,
        dateOfBirth: state.birthday.value,
        firstName: state.name.value,
        lastName: state.surname.value,
        recaptchaValue: "",
        roleCode: "_STUDENT");

    try {
      final response = await authenticationRepository.signUp(newUser);
      yield state.copyWith(registrationSuccess: true, submitting: true);
    } catch (e) {
      yield state.copyWith(
          registrationSuccess: false, submitting: false, existingUser: true);
    }
  }

  Stream<RegisterState> _mapResendEmailToState(ResendEmail event,
      RegisterState state) async* {
    yield state.copyWith(resendEmail: true);
  }
}
