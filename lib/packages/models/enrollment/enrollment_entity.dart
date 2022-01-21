import 'dart:convert';
import 'dart:developer';

import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/models.dart';
import 'package:akademi_al_mobile_app/packages/models/user/organizations.dart';
import 'package:hive/hive.dart';

part 'enrollment_entity.g.dart';

@HiveType(typeId: 3)
class EnrollmentEntity extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String status;

  @HiveField(2)
  String userId;

  @HiveField(3)
  String classroomId;

  @HiveField(4)
  ClassroomEntity classroom;

  @HiveField(5)
  String enrolledAt;

  @HiveField(6)
  List<Lessons> lessons;

  @HiveField(7)
  String lastSyncDate;

  @HiveField(8)
  bool isUpdated;

  @HiveField(9)
  bool isDeleted;

  @HiveField(10)
  User user;

  EnrollmentEntity(
      {this.id,
      this.status,
      this.userId,
      this.classroomId,
      this.classroom,
      this.enrolledAt,
      this.lessons,
      this.lastSyncDate,
      this.isDeleted,
      this.isUpdated,
      this.user
      });

  EnrollmentEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    status = json['status'];
    userId = json['UserId'];
    classroomId = json['ClassroomId'];
    enrolledAt = json['enrolledAt'];
    classroom = json['Classroom'] != null
        ? new ClassroomEntity.fromJson(json['Classroom'])
        : null;
    if (json['Lessons'] != null) {
      lessons = new List<Lessons>();
      json['Lessons'].forEach((v) {
        lessons.add(new Lessons.fromJson(v));
      });
    }
    lastSyncDate = json['lastSyncDate'];
    isUpdated = json['isUpdated'];
    isDeleted = json['isDeleted'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['status'] = this.status;
    data['UserId'] = this.userId;
    data['ClassroomId'] = this.classroomId;
    data['enrolledAt'] = this.enrolledAt;
    if (this.classroom != null) {
      data['Classroom'] = this.classroom.toJson();
    }
    if (this.lessons != null) {
      data['Lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
    data['lastSyncDate'] = this.lastSyncDate;
    data['isUpdated'] = this.isUpdated;
    data['isDeleted'] = this.isDeleted;
    if (this.user != null) {
      data['User'] = this.user.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'EnrollmentEntity{id: $id, status: $status, userId: $userId, classroomId: $classroomId, classroom: $classroom, enrolledAt: $enrolledAt, lessons: $lessons, lastSyncDate: $lastSyncDate, isUpdated: $isUpdated, isDeleted: $isDeleted}';
  }
}

@HiveType(typeId: 5)
class EnrollmentClassroomUserCreatedBy {
  @HiveField(0)
  String firstName;
  @HiveField(1)
  String lastName;
  bool manuallyActivated;
  Null manuallyActivatedBy;
  Null manuallyActivatedOn;

  EnrollmentClassroomUserCreatedBy(
      {this.firstName,
      this.lastName,
      this.manuallyActivated,
      this.manuallyActivatedBy,
      this.manuallyActivatedOn});

  EnrollmentClassroomUserCreatedBy.fromJson(Map<String, dynamic> json) {
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

@HiveType(typeId: 6)
class EnrollmentClassroomFile {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  String filePath;

  EnrollmentClassroomFile();
}

class SubjectPlan {
  String id;
  Organization organization;

  SubjectPlan({this.id, this.organization});

  SubjectPlan.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    organization = json['Organization'] != null
        ? new Organization.fromJson(json['Organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.organization != null) {
      data['Organization'] = this.organization.toJson();
    }
    return data;
  }
}
