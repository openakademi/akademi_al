import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organization_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organizations.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'select_organization_event.dart';

part 'select_organization_state.dart';

class SelectOrganizationBloc
    extends Bloc<SelectOrganizationEvent, SelectOrganizationState> {
  SelectOrganizationBloc(
      {this.organizationRepository, this.authenticationRepository})
      : super(SelectOrganizationState());

  final OrganizationRepository organizationRepository;
  final AuthenticationRepository authenticationRepository;

  @override
  Stream<SelectOrganizationState> mapEventToState(
    SelectOrganizationEvent event,
  ) async* {
    if (event is LoadOrganizationsEvent) {
      yield* _mapLoadOrganizationsEvent(event, state);
    } else if (event is ChoosenOrganizationsEvent) {
      yield* _mapChoosenOrganizationEventToState(event, state);
    } else if (event is UpdateOrganizationsEvent) {
      yield* _mapUpdateOrganizationsEventToState(event, state);
    }
  }

  Stream<SelectOrganizationState> _mapLoadOrganizationsEvent(
      LoadOrganizationsEvent event, SelectOrganizationState state) async* {
    yield state.copyWith(loading: true);
    var myOrganizations = <OrganizationEntity>[];
    try {
      myOrganizations = await organizationRepository.getMyOrganizations();
    } catch(e) {
      print("e $e");
    }

    yield state.copyWith(
        myOrganizations: myOrganizations
            // .where((element) => !element.defaultOrganization)
            .where((element) => element.userRoles.any((role) => role.role.code == "_STUDENT"))
            .toList(),
        loading: false);
  }

  Stream<SelectOrganizationState> _mapChoosenOrganizationEventToState(
      ChoosenOrganizationsEvent event, SelectOrganizationState state) async* {
    yield state.copyWith(submitting: true);

    await authenticationRepository.refreshToken(event.organizationId);

    await organizationRepository.saveSelectedOrganization(event.organizationId, event.organizationName);
    yield state.copyWith(submitting: false, done: true);
  }

  Stream<SelectOrganizationState> _mapUpdateOrganizationsEventToState(
      UpdateOrganizationsEvent event, SelectOrganizationState state) async* {

    await authenticationRepository.refreshToken(event.organizationId);

    await organizationRepository.saveSelectedOrganization(event.organizationId, event.organizationName);
  }
}
