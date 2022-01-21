import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_entity.dart';

const relative_url = "/users";

class UserApiProvider extends ApiServiceData {
  UserApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<UserEntity> getCurrentUserEntity() async {
    final userId = await authenticationRepository.getCurrentUserId();
    final response = await getRequest("$relative_url/$userId");
    final userEntity = UserEntity.fromJson(response);
    return userEntity;
  }
  
  Future<void> changePassword(String oldPassword, String newPassword) async {
    await post("$relative_url/change-password", {
      "oldPassword": oldPassword,
      "newPassword": newPassword
    });
  }

  Future<void> updateProfile(String name, String lastName, String userName, String nationality) async{
    final userId = await authenticationRepository.getCurrentUserId();
    await update("$relative_url/update-profile/$userId", {
      "firstName": name,
      "lastName": lastName,
      "username": userName,
      "nationality": nationality
    });
  }
}
