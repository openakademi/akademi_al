import 'create_assignment_user_commit.dart';

class AssignmentUserCommit {
  String id;
  String userId;
  String lessonId;
  String description;
  bool isCommitted;
  String grade;
  bool isEvaluated;
  String createdAt;
  String updatedAt;
  String deletedAt;

  // List<File> assignmentUserCommitFiles;
  List<AssignmentUserCommitFile> assignmentUserCommitFiles;

  AssignmentUserCommit(
      {this.id,
      this.userId,
      this.lessonId,
      this.description,
      this.isCommitted,
      this.grade,
      this.isEvaluated,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.assignmentUserCommitFiles});

  AssignmentUserCommit.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    lessonId = json['LessonId'];
    description = json['description'];
    isCommitted = json['isCommitted'];
    grade = json['grade'];
    isEvaluated = json['isEvaluated'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['AssignmentUserCommitFiles'] != null) {
      assignmentUserCommitFiles = new List<AssignmentUserCommitFile>();
      json['AssignmentUserCommitFiles'].forEach((v) {
        assignmentUserCommitFiles.add(new AssignmentUserCommitFile.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['LessonId'] = this.lessonId;
    data['description'] = this.description;
    data['isCommitted'] = this.isCommitted;
    data['grade'] = this.grade;
    data['isEvaluated'] = this.isEvaluated;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.assignmentUserCommitFiles != null) {
      data['AssignmentUserCommitFiles'] =
          this.assignmentUserCommitFiles.map((v) => v.toJson(this.id)).toList();
    }
    return data;
  }

  Map<String, dynamic> toSaveJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['LessonId'] = this.lessonId;
    data['description'] = this.description;
    data['isCommitted'] = this.isCommitted;
    data['isEvaluated'] = this.isEvaluated;
    if (this.assignmentUserCommitFiles != null) {
      data['AssignmentUserCommitFiles'] =
          this.assignmentUserCommitFiles.map((v) => v.toJson(this.id)).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'AssignmentUserCommit{id: $id, userId: $userId, lessonId: $lessonId, description: $description, isCommitted: $isCommitted, grade: $grade, isEvaluated: $isEvaluated, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, assignmentUserCommitFiles: $assignmentUserCommitFiles}';
  }
}
