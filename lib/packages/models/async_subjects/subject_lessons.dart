import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:hive/hive.dart';

part 'subject_lessons.g.dart';

@HiveType(typeId: 21)
class SubjectLessons {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String parentId;
  @HiveField(4)
  String organizationId;
  @HiveField(5)
  bool asyncOnly;
  @HiveField(6)
  String deletedAt;
  @HiveField(7)
  bool isGlobal;
  @HiveField(8)
  String name;
  @HiveField(9)
  String priority;
  @HiveField(10)
  String target;
  @HiveField(11)
  List<ClassroomTags> classroomTags;
  @HiveField(12)
  SubjectOrganization organization;

  SubjectLessons({
    this.updatedBy,
    this.deletedAt,
    this.createdBy,
    this.asyncOnly,
    this.classroomTags,
    this.id,
    this.isGlobal,
    this.name,
    this.organization,
    this.organizationId,
    this.parentId,
    this.priority,
    this.target
  });

  SubjectLessons.fromJson(Map<String, dynamic> jsonObject){
    id = jsonObject['id'];
    createdBy = jsonObject['createdBy'];
    updatedBy = jsonObject['updatedBy'];
    parentId = jsonObject['ParentId'];
    organizationId = jsonObject['OrganizationId'];
    asyncOnly = jsonObject['asyncOnly'];
    deletedAt = jsonObject['deletedAt'];
    isGlobal = jsonObject['isGlobal'];
    name = jsonObject['name'];
    priority = jsonObject['priority'];
    target = jsonObject['target'];
    if (jsonObject['ClassroomTags'] != null) {
      classroomTags = <ClassroomTags>[];
      jsonObject['ClassroomTags'].forEach((v) {
        classroomTags.add(new ClassroomTags.fromJson(v));
      });
    }
    organization = jsonObject['Organization'] != null
        ? new SubjectOrganization.fromJson(jsonObject['Organization'])
        : null;

  }

}

@HiveType(typeId: 22)
class ClassroomTags {
  @HiveField(0)
  String classroomId;
  @HiveField(1)
  String tagId;
  @HiveField(2)
  String createdAt;
  @HiveField(3)
  String createdBy;
  @HiveField(4)
  String deletedAt;
  @HiveField(5)
  String id;
  @HiveField(6)
  int priority;
  @HiveField(7)
  String updatedAt;
  @HiveField(8)
  String updatedBy;
  @HiveField(9)
  List<LessonClassroomTag> lessonClassroomTag;

  ClassroomTags({
    this.priority,
    this.id,
    this.createdBy,
    this.deletedAt,
    this.updatedBy,
    this.updatedAt,
    this.createdAt,
    this.classroomId,
    this.lessonClassroomTag,
    this.tagId
});

  ClassroomTags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    classroomId = json['ClassroomId'];
    tagId = json['TagId'];
    priority = json['priority'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    if (json['LessonClassroomTag'] != null) {
      lessonClassroomTag = <LessonClassroomTag>[];
      json['LessonClassroomTag'].forEach((v) {
        lessonClassroomTag.add(new LessonClassroomTag.fromJson(v));
      });
    }
  }
}

@HiveType(typeId: 23)
class LessonClassroomTag {
  @HiveField(0)
  String id;
  @HiveField(1)
  int priority;
  @HiveField(2)
  String lessonId;
  @HiveField(3)
  String createdAt;
  @HiveField(4)
  String deletedAt;
  @HiveField(5)
  String updatedAt;
  @HiveField(6)
  String classroomTagId;
  @HiveField(7)
  Lessons lesson;

  LessonClassroomTag({
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.id,
    this.priority,
    this.classroomTagId,
    this.lesson,
    this.lessonId
});

  LessonClassroomTag.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['LessonId'];
    classroomTagId = json['ClassroomTagId'];
    priority = json['priority'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    lesson = json['Lesson'] != null
        ? new Lessons.fromJson(json['Lesson'])
        : null;
  }
}

// @HiveType(typeId: 24)
// class Lesson {
//   @HiveField(0)
//   String id;
//   @HiveField(1)
//   String createdBy;
//   @HiveField(2)
//   String updatedBy;
//   @HiveField(3)
//   String name;
//   @HiveField(4)
//   String description;
//   @HiveField(5)
//   String startDate;
//   @HiveField(6)
//   String endDate;
//   @HiveField(7)
//   String videoUrl;
//   @HiveField(8)
//   String weekId;
//   @HiveField(9)
//   String fileId;
//   @HiveField(10)
//   String lessonType;
//   @HiveField(11)
//   String copiedFromLessonId;
//   @HiveField(12)
//   String createdAt;
//   @HiveField(13)
//   String updatedAt;
//   @HiveField(14)
//   String deletedAt;
//   ProgressLessonEnrollment progressLessonEnrollment;
//
//   Lesson(
//       {this.id,
//         this.createdBy,
//         this.updatedBy,
//         this.name,
//         this.description,
//         this.startDate,
//         this.endDate,
//         this.videoUrl,
//         this.weekId,
//         this.fileId,
//         this.lessonType,
//         this.copiedFromLessonId,
//         this.createdAt,
//         this.updatedAt,
//         this.deletedAt,
//         this.progressLessonEnrollment,
//       });
//
//   Lesson.fromJson(Map<String, dynamic> jsonObject) {
//     id = jsonObject['id'];
//     createdBy = jsonObject['createdBy'];
//     updatedBy = jsonObject['updatedBy'];
//     name = jsonObject['name'];
//     description = jsonObject['description'];
//     startDate = jsonObject['startDate'];
//     endDate = jsonObject['endDate'];
//     videoUrl = jsonObject['videoUrl'];
//     weekId = jsonObject['WeekId'];
//     fileId = jsonObject['FileId'];
//     lessonType = jsonObject['lessonType'];
//     copiedFromLessonId = jsonObject['CopiedFromLessonId'];
//     createdAt = jsonObject['createdAt'];
//     updatedAt = jsonObject['updatedAt'];
//     deletedAt = jsonObject['deletedAt'];
//     progressLessonEnrollment = jsonObject['ProgressLessonEnrollment'] != null
//         ? new ProgressLessonEnrollment.fromJson(
//         jsonObject['ProgressLessonEnrollment'])
//         : null;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['createdBy'] = this.createdBy;
//     data['updatedBy'] = this.updatedBy;
//     data['name'] = this.name;
//     data['description'] = this.description;
//     data['startDate'] = this.startDate;
//     data['endDate'] = this.endDate;
//     data['videoUrl'] = this.videoUrl;
//     data['WeekId'] = this.weekId;
//     data['FileId'] = this.fileId;
//     data['lessonType'] = this.lessonType;
//     data['CopiedFromLessonId'] = this.copiedFromLessonId;
//     data['createdAt'] = this.createdAt;
//     data['updatedAt'] = this.updatedAt;
//     data['deletedAt'] = this.deletedAt;
//     if (this.progressLessonEnrollment != null) {
//       data['ProgressLessonEnrollment'] = this.progressLessonEnrollment.toJson();
//     }
//     return data;
//   }
//
//   @override
//   String toString() {
//     return 'Lessons{id: $id, createdBy: $createdBy, updatedBy: $updatedBy, name: $name, description: $description, startDate: $startDate, endDate: $endDate, videoUrl: $videoUrl, weekId: $weekId, fileId: $fileId, lessonType: $lessonType, copiedFromLessonId: $copiedFromLessonId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt}';
//   }
// }

@HiveType(typeId: 25)
class SubjectOrganization {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String contentType;
  @HiveField(3)
  String parentOrganizationId;
  @HiveField(4)
  String nationality;
  @HiveField(5)
  String code;
  @HiveField(6)
  String createdAt;
  @HiveField(7)
  String createdBy;
  @HiveField(8)
  bool defaultValue;
  @HiveField(9)
  String domain;
  @HiveField(10)
  int numberOfUsers;
  @HiveField(11)
  String ownerEmail;
  @HiveField(12)
  String price;
  @HiveField(13)
  String ratio;
  @HiveField(14)
  bool requireApproval;
  @HiveField(15)
  String sector;
  @HiveField(16)
  String status;
  @HiveField(17)
  bool superOrganization;
  @HiveField(18)
  String type;
  @HiveField(19)
  String updatedAt;
  @HiveField(20)
  String updatedBy;
  @HiveField(21)
  String deletedAt;

  SubjectOrganization({
    this.parentOrganizationId,
    this.name,
    this.code,
    this.id,
    this.contentType,
    this.createdAt,
    this.createdBy,
    this.defaultValue,
    this.deletedAt,
    this.domain,
    this.nationality,
    this.numberOfUsers,
    this.ownerEmail,
    this.price,
    this.ratio,
    this.requireApproval,
    this.sector,
    this.status,
    this.superOrganization,
    this.type,
    this.updatedAt,
    this.updatedBy
  });

  SubjectOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    parentOrganizationId = json['parentOrganizationId'];
    contentType = json['contentType'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
    defaultValue = json['defaultValue'];
    deletedAt = json['deletedAt'];
    domain = json['domain'];
    nationality = json['nationality'];
    numberOfUsers = json['numberOfUsers'];
    ownerEmail = json['ownerEmail'];
    price = json['price'];
    ratio = json['ratio'];
    requireApproval = json['requireApproval'];
    sector = json['sector'];
    status = json['status'];
    superOrganization = json['superOrganization'];
    type = json['type'];
    updatedAt = json['updatedAt'];
    updatedBy = json['updatedBy'];
  }

}