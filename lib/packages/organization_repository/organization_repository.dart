import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organization_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organizations.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/lib/organization_hive_repository.dart';

import 'lib/organization_api_provider.dart';

class OrganizationRepository {
  static OrganizationRepository _instance;

  OrganizationRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new OrganizationApiProvider(authenticationRepository),
        _hiveRepository = OrganizationHiveRepository(),
      authenticationRepository = authenticationRepository
  {
    _instance = this;
  }

  factory OrganizationRepository(
      {AuthenticationRepository authenticationRepository}) =>
      _instance ??
          OrganizationRepository._privateConstructor(authenticationRepository);

  final OrganizationApiProvider _apiProvider;
  final OrganizationHiveRepository _hiveRepository;
  final AuthenticationRepository authenticationRepository;


  Future<String> getSelectedOrganization() async {
    final userId = await authenticationRepository.getCurrentUserId();

    try {
      final selectedOrganization = await _hiveRepository
          .getSelectedOrganization(userId);
      return selectedOrganization;

    } catch(e) {
      return "";
    }
  }

  Future<String> getSelectedOrganizationName() async {
    final selectedOrganization = await _hiveRepository
        .getSelectedOrganizationName();
    return selectedOrganization;
  }

  Future<List<OrganizationEntity>> getMyOrganizations() async {
    final myOrganizations = await _apiProvider.getMyOrganizations();
    return myOrganizations;
  }

  Future<void> saveSelectedOrganization(String organizationId, String organizationName) async {
    final userId = await authenticationRepository.getCurrentUserId();
    await _hiveRepository.saveSelectedOrganization(organizationId, userId, organizationName);
  }

  Future<void> joinOrganizationByRole(String organizationCode) async {
    await _apiProvider.joinOrganizationByCode(organizationCode);
  }
}
