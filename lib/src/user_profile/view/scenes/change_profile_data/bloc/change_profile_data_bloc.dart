import 'dart:async';

import 'package:akademi_al_mobile_app/components/models/non_empty_field.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:akademi_al_mobile_app/src/user_profile/view/scenes/change_profile_data/view/change_profile.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

part 'change_profile_data_event.dart';

part 'change_profile_data_state.dart';

class ChangeProfileDataBloc
    extends Bloc<ChangeProfileDataEvent, ChangeProfileDataState> {
  ChangeProfileDataBloc({this.userRepository, this.authenticationRepository, this.organizationRepository})
      : super(ChangeProfileDataState());
  final UserRepository userRepository;
  final AuthenticationRepository authenticationRepository;
  final OrganizationRepository organizationRepository;

  @override
  Stream<ChangeProfileDataState> mapEventToState(
    ChangeProfileDataEvent event,
  ) async* {
    if (event is LoadUserEntity) {
      yield _mapLoadUserEntityToState(event, state);
    } else if (event is ChangeName) {
      yield _mapChangeNameToState(event, state);
    } else if (event is ChangeUsername) {
      yield _mapChangeUsernameToState(event, state);
    } else if (event is ChangeSurname) {
      yield _mapChangeSurnameToState(event, state);
    } else if (event is ChangeNationality) {
      yield _mapChangeNationalityToState(event, state);
    } else if (event is RequestChangeNameAndSurname) {
      yield* _mapRequestChangeNameAndSurnameToState(event, state);
    } else if (event is RequestChangeUsername) {
      yield* _mapRequestChangeUsernameToState(event, state);
    }
  }

  ChangeProfileDataState _mapLoadUserEntityToState(
      LoadUserEntity event, ChangeProfileDataState state) {
    final userEntity = event.userEntity;
    return state.copyWith(
      userEntity: userEntity,
      name: NonEmptyField.dirty(userEntity.firstName),
      surname: NonEmptyField.dirty(userEntity.lastName),
      nationality: NonEmptyField.dirty(userEntity.nationality),
      userName: NonEmptyField.dirty(userEntity.username),
      changed: false
    );
  }

  ChangeProfileDataState _mapChangeNameToState(
      ChangeName event, ChangeProfileDataState state) {
    final newName = NonEmptyField.dirty(event.newName);

    return state.copyWith(
        name: newName,
        nameChangePageStatus: Formz.validate([newName, state.surname]),
        changed: true
    );
  }

  ChangeProfileDataState _mapChangeSurnameToState(
      ChangeSurname event, ChangeProfileDataState state) {
    final newSurname = NonEmptyField.dirty(event.surname);
    return state.copyWith(
        surname: newSurname,
        nameChangePageStatus: Formz.validate([newSurname, state.name]),
        changed: true
    );
  }

  Stream<ChangeProfileDataState> _mapRequestChangeNameAndSurnameToState(
      RequestChangeNameAndSurname event, ChangeProfileDataState state) async* {
    yield state.copyWith(submitting: true);
    try {
      await userRepository.updateProfile(state.name.value, state.surname.value,
          state.userName.value, state.nationality.value);
      final selectedOrganizationId = await organizationRepository.getSelectedOrganization();
      await authenticationRepository.refreshToken(selectedOrganizationId);
      yield state.copyWith(submitting: false, success: true);
    } catch (e) {
      print("$e");
      yield state.copyWith(submitting: false, success: false);
    }
  }

  ChangeProfileDataState _mapChangeUsernameToState(ChangeUsername event, ChangeProfileDataState state) {

    final newName = NonEmptyField.dirty(event.username);

    return state.copyWith(
        userName: newName,
        usernameChangePageStatus: Formz.validate([newName]),
        changed: true
    );
  }

  Stream<ChangeProfileDataState> _mapRequestChangeUsernameToState(RequestChangeUsername event, ChangeProfileDataState state) async* {
    yield state.copyWith(submitting: true);
    try {
      await userRepository.updateProfile(state.name.value, state.surname.value,
          state.userName.value, state.nationality.value);
      final selectedOrganizationId = await organizationRepository.getSelectedOrganization();
      await authenticationRepository.refreshToken(selectedOrganizationId);
      yield state.copyWith(submitting: false, success: true);
    } catch (e) {
      print("$e");
      yield state.copyWith(submitting: false, success: false);
    }
  }

  ChangeProfileDataState _mapChangeNationalityToState(ChangeNationality event, ChangeProfileDataState state) {
    final newNationality = NonEmptyField.dirty(event.nationality);

    return state.copyWith(
        nationality: newNationality,
        nationalityChangePageStatus: Formz.validate([newNationality]),
        changed: true
    );
  }
}
