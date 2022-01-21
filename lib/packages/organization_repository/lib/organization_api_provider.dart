import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organization_entity.dart';

const relative_url = "/organizations";

class OrganizationApiProvider extends ApiServiceData {
  OrganizationApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<List<OrganizationEntity>> getMyOrganizations() async {
    List<dynamic> organizationEntitiesJson = await this.getRequest("$relative_url/enrolled/me");
    final organizationEntities = organizationEntitiesJson.map((element) => OrganizationEntity.fromJson(element)).toList();
    return organizationEntities;
  }

  Future<List<void>> joinOrganizationByCode(String organizationCode) async {
   await this.post("$relative_url//join-by-role", {
      "organizationCode": organizationCode,
      "roleCode": "_STUDENT"
    });
  }
}
