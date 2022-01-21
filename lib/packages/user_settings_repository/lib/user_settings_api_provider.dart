
import 'dart:convert';
import 'dart:developer';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';

const relative_url = "/user-settings";

class UserSettingsApiProvider extends ApiServiceData {
  UserSettingsApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<UserAvatarEntity> getAvatar(String userId) async {
    final response = await getRequest("$relative_url/get-avatar/$userId");
    if(response is List) {

    } else {
      return UserAvatarEntity.fromJson(response);
    }
  }
  
  Future<UserAvatarEntity> updateAvatar(UserAvatarEntity userAvatarEntity) async {
    final response = await this.update("$relative_url/update-avatar", {
      "profilePicture": userAvatarEntity.profilePicture != null ? userAvatarEntity.profilePicture : "",
      "profilePictureType": userAvatarEntity.profilePictureType,
      "profilePictureFile": userAvatarEntity.profilePictureFile?.toJson()
    });
    // return UserAvatarEntity.fromJson(response);
  }
}