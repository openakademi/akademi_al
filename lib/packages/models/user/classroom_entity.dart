
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:hive/hive.dart';

import 'organizations.dart';

part 'classroom_entity.g.dart';

@HiveType(typeId: 4)
class ClassroomEntity {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String name;
  @HiveField(3)
  String code;
  @HiveField(4)
  String description;
  @HiveField(5)
  bool isAsync;
  @HiveField(6)
  String gradeSubjectId;
  @HiveField(7)
  bool requireApproval;
  @HiveField(8)
  SubjectPlan subjectPlan;
  @HiveField(9)
  File file;
  @HiveField(10)
  GradeSubject gradeSubject;
  @HiveField(11)
  UserCreatedBy userCreatedBy;
  @HiveField(12)
  Organization organization;
  @HiveField(13)
  String lastSyncDate;
  @HiveField(14)
  bool isUpdated;
  @HiveField(15)
  bool isDeleted;

  String fileUrl;

  ClassroomEntity(
      {this.id,
        this.createdBy,
        this.name,
        this.code,
        this.description,
        this.isAsync,
        this.gradeSubjectId,
        this.requireApproval,
        this.subjectPlan,
        this.file,
        this.gradeSubject,
        this.userCreatedBy,
        this.organization,
        this.lastSyncDate,
        this.isUpdated,
        this.isDeleted,
      });

  ClassroomEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    name = json['name'];
    code = json['code'];
    description = json['description'];
    isAsync = json['isAsync'];
    gradeSubjectId = json['GradeSubjectId'];
    requireApproval = json['requireApproval'];
    subjectPlan = json['SubjectPlan'] != null
        ? new SubjectPlan.fromJson(json['SubjectPlan'])
        : null;
    file = json['File'] != null ? new File.fromJson(json['File']) : null;
    gradeSubject = json['GradeSubject'] != null
        ? new GradeSubject.fromJson(json['GradeSubject'])
        : null;

    userCreatedBy = json['UserCreatedBy'] != null
        ? new UserCreatedBy.fromJson(json['UserCreatedBy'])
        : null;
    organization = json['Organization'] != null
        ? new Organization.fromJson(json['Organization'])
        : null;

    lastSyncDate = json['lastSyncDate'];
    isUpdated = json['isUpdated'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['name'] = this.name;
    data['code'] = this.code;
    data['description'] = this.description;
    data['isAsync'] = this.isAsync;
    data['GradeSubjectId'] = this.gradeSubjectId;
    data['requireApproval'] = this.requireApproval;
    if (this.subjectPlan != null) {
      data['SubjectPlan'] = this.subjectPlan.toJson();
    }
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    if (this.gradeSubject != null) {
      data['GradeSubject'] = this.gradeSubject.toJson();
    }
    if (this.userCreatedBy != null) {
      data['UserCreatedBy'] = this.userCreatedBy.toJson();
    }
    if (this.organization != null) {
      data['Organization'] = this.organization.toJson();
    }
    data['lastSyncDate'] = this.lastSyncDate;
    data['isUpdated'] = this.isUpdated;
    data['isDeleted'] = this.isDeleted;

    return data;
  }
}

@HiveType(typeId: 11)
class SubjectPlan {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String name;
  @HiveField(4)
  String status;
  @HiveField(5)
  String classroomId;
  @HiveField(6)
  String organizationId;
  @HiveField(7)
  String createdAt;
  @HiveField(8)
  String updatedAt;
  @HiveField(9)
  String deletedAt;
  @HiveField(10)
  SubjectPlanTree subjectPlanTree;

  String classroomName;

  SubjectPlan(
      {this.id,
        this.createdBy,
        this.updatedBy,
        this.name,
        this.status,
        this.classroomId,
        this.organizationId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.subjectPlanTree,
        this.classroomName
      });

  SubjectPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    status = json['status'];
    classroomId = json['ClassroomId'];
    organizationId = json['OrganizationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    classroomName = json['name'];
    subjectPlanTree = json['SubjectPlanTree'] != null
        ? new SubjectPlanTree.fromJson(json['SubjectPlanTree'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['status'] = this.status;
    data['ClassroomId'] = this.classroomId;
    data['OrganizationId'] = this.organizationId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.subjectPlanTree != null) {
      data['SubjectPlanTree'] = this.subjectPlanTree.toJson();
    }
    return data;
  }
}

@HiveType(typeId: (15))
class File {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String filePath;

  File({this.id, this.name, this.filePath});

  File.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    filePath = json['filePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['filePath'] = this.filePath;
    return data;
  }
}

@HiveType(typeId: 14)
class GradeSubject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String gradeId;
  @HiveField(2)
  Grade grade;
  @HiveField(3)
  Subject subject;

  GradeSubject({this.id, this.gradeId, this.grade, this.subject});

  GradeSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeId = json['GradeId'];
    grade = json['Grade'] != null ? new Grade.fromJson(json['Grade']) : null;
    subject =
    json['Subject'] != null ? new Subject.fromJson(json['Subject']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['GradeId'] = this.gradeId;
    if (this.grade != null) {
      data['Grade'] = this.grade.toJson();
    }
    if (this.subject != null) {
      data['Subject'] = this.subject.toJson();
    }
    return data;
  }
}

class Grade {
  String name;
  String id;
  String level;

  Grade({this.name, this.id, this.level});

  Grade.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['level'] = this.level;
    return data;
  }
}

class Subject {
  String name;
  String id;
  String icon;

  Subject({this.name, this.id, this.icon});

  Subject.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['icon'] = this.icon;
    return data;
  }
}

@HiveType(typeId: 16)
class UserCreatedBy {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  @HiveField(2)
  bool manuallyActivated;
  @HiveField(3)
  String manuallyActivatedBy;
  @HiveField(5)
  String manuallyActivatedOn;

  UserCreatedBy(
      {this.firstName,
        this.lastName,
        this.manuallyActivated,
        this.manuallyActivatedBy,
        this.manuallyActivatedOn});

  UserCreatedBy.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    manuallyActivated = json['manuallyActivated'];
    manuallyActivatedBy = json['manuallyActivatedBy'];
    manuallyActivatedOn = json['manuallyActivatedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['manuallyActivated'] = this.manuallyActivated;
    data['manuallyActivatedBy'] = this.manuallyActivatedBy;
    data['manuallyActivatedOn'] = this.manuallyActivatedOn;
    return data;
  }
}
