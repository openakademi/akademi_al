import 'package:hive/hive.dart';

part 'file_entity.g.dart';


@HiveType(typeId: 20)
class File {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String name;
  @HiveField(4)
  String contentType;
  @HiveField(5)
  int size;
  @HiveField(6)
  String filePath;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String updatedAt;
  @HiveField(9)
  String deletedAt;
  @HiveField(10)
  String assignmentUserCommitId;

  File(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.name,
      this.contentType,
      this.size,
      this.filePath,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.assignmentUserCommitId});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    contentType = json['contentType'];
    size = json['size'];
    filePath = json['filePath'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['filePath'] = this.filePath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }

  Map<String, dynamic> toAssignmentFileJson(String assignmentCommitId) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['FileId'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['contentType'] = this.contentType;
    data['size'] = this.size;
    data['filePath'] = this.filePath;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['AssignmentUserCommitId'] = assignmentCommitId;
    return data;
  }
}
