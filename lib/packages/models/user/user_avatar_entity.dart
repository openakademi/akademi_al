import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart';

class UserAvatarEntity {
  String profilePicture;
  String profilePictureType;
  File profilePictureFile;
  String fileUrl;

  UserAvatarEntity(
      {this.profilePicture, this.profilePictureType, this.profilePictureFile});

  UserAvatarEntity.fromJson(Map<String, dynamic> json) {
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    profilePictureFile = json['profilePictureFile'] != null
        ? new File.fromJson(json['profilePictureFile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    if (this.profilePictureFile != null) {
      data['profilePictureFile'] = this.profilePictureFile.toJson();
    }
    return data;
  }
}
