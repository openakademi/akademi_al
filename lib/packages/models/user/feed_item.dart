
import 'classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart' as FileEntity;

class FeedItem {
  String id;
  String createdBy;
  String updatedBy;
  String message;
  String userId;
  String classroomId;
  String fileId;
  String parentId;
  String navigateUrl;
  String type;
  String createdAt;
  String updatedAt;
  String deletedAt;
  FileEntity.File file;
  UserCreatedBy userCreatedBy;

  FeedItem(
      {this.id,
        this.createdBy,
        this.updatedBy,
        this.message,
        this.userId,
        this.classroomId,
        this.fileId,
        this.parentId,
        this.navigateUrl,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.file,
        this.userCreatedBy});

  FeedItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    message = json['message'];
    userId = json['UserId'];
    classroomId = json['ClassroomId'];
    fileId = json['FileId'];
    parentId = json['ParentId'];
    navigateUrl = json['navigateUrl'];
    type = json['type'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    file = json['File'] != null ? new FileEntity.File.fromJson(json['File']) : null;
    userCreatedBy = json['UserCreatedBy'] != null
        ? new UserCreatedBy.fromJson(json['UserCreatedBy'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['message'] = this.message;
    data['UserId'] = this.userId;
    data['ClassroomId'] = this.classroomId;
    data['FileId'] = this.fileId;
    data['ParentId'] = this.parentId;
    data['navigateUrl'] = this.navigateUrl;
    data['type'] = this.type;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.userCreatedBy != null) {
      data['UserCreatedBy'] = this.userCreatedBy.toJson();
    }
    return data;
  }

  Map<String, dynamic> toSaveJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['message'] = this.message;
    data['UserId'] = this.userId;
    data['ClassroomId'] = this.classroomId;
    data['FileId'] = this.fileId;
    data['ParentId'] = this.parentId;
    data['navigateUrl'] = this.navigateUrl;
    data['type'] = this.type;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    return data;
  }
}
