import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart';

class AssignmentUserCommitFile {
  String id;
  String assignmentUserCommitId;
  String fileId;
  File file;

  AssignmentUserCommitFile(
      {this.id, this.assignmentUserCommitId, this.file, this.fileId});

  AssignmentUserCommitFile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentUserCommitId = json['AssignmentUserCommitId'];
    fileId = json['FileId'];
    if (json['File'] != null) {
        file = new File.fromJson(json['File']);
    }
  }

  Map<String, dynamic> toJson(String userCommitId) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['AssignmentUserCommitId'] = userCommitId;
    data['FileId'] = this.file.id;
    if (this.file != null) {
      data['File'] =
          this.file.toJson();
    }
    return data;
  }
}
