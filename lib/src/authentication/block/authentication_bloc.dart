import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/authorization_token.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/models/user/roles.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : assert(authenticationRepository != null),
        _authenticationRepository = authenticationRepository,
        _organizationRepository = OrganizationRepository(authenticationRepository: authenticationRepository),
        super(const AuthenticationState.unknown()) {
    _authenticationStatusSubscription = _authenticationRepository.status.listen(
      (status) => add(AuthenticationStatusChanged(status)),
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final OrganizationRepository _organizationRepository;
  StreamSubscription<AuthenticationStatus> _authenticationStatusSubscription;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is AuthenticationLogoutRequested) {
      _authenticationRepository.logOut();
    } else if (event is RefreshTokenRequested) {
      await _authenticationRepository.refreshToken(event.selectedOrganization);
    }
  }

  @override
  Future<void> close() {
    _authenticationStatusSubscription?.cancel();
    return super.close();
  }

  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
    AuthenticationStatusChanged event,
  ) async {
    switch (event.status) {
      case AuthenticationStatus.unauthenticated:
        return const AuthenticationState.unauthenticated();
      case AuthenticationStatus.authenticated:
        final token = await _tryGetToken();

        final user = await _tryGetUser();

        final roles = await _tryGetRoles();
        final tokenObject = await _tryGetTokenObject();
        final selectedOrganization = await _tryGetSelectedOrganization();
        var connectivityResult = await (Connectivity().checkConnectivity());

        if(connectivityResult != ConnectivityResult.none) {
          try {
            await _authenticationRepository.refreshToken(selectedOrganization);
          } catch (e) {
            print("$e");
            return const AuthenticationState.unauthenticated();
          }
        }
        return token != null && user != null
            ? AuthenticationState.authenticated(user, roles, tokenObject, selectedOrganization)
            : const AuthenticationState.unauthenticated();
      default:
        return const AuthenticationState.unknown();
    }
  }

  Future<String> _tryGetToken() async {
    final token = await _authenticationRepository.getToken();
    return token;
  }

  Future<AuthorizationToken> _tryGetTokenObject() async {
    final token = await _authenticationRepository.getTokenObject();
    return token;
  }

  Future<String> _tryGetSelectedOrganization() async {
    final selectedOrganization = await _organizationRepository.getSelectedOrganization();
    return selectedOrganization;
  }


  Future<List<Roles>> _tryGetRoles() async {
    final roles = await _authenticationRepository.getCurrentUserRole();
    return roles;
  }

  Future<User> _tryGetUser() async {
    try {
      final user = await _authenticationRepository.getCurrentUser();
      return user;
    } on Exception {
      return null;
    }
  }
}
