import 'dart:convert';

import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart' as ClassroomEntity;
import 'package:hive/hive.dart';

import 'file_entity.dart';

part 'subject_plan_tree.g.dart';

@HiveType(typeId: 12)
class SubjectPlanTree {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String name;
  @HiveField(4)
  String description;
  @HiveField(5)
  int left;
  @HiveField(6)
  int right;
  @HiveField(7)
  int level;
  @HiveField(8)
  String subjectPlanId;
  @HiveField(9)
  String startDate;
  @HiveField(10)
  String endDate;
  @HiveField(11)
  String createdAt;
  @HiveField(12)
  String updatedAt;
  @HiveField(13)
  bool isRoot;
  @HiveField(14)
  String deletedAt;
  @HiveField(15)
  List<SubjectPlanTree> children;
  @HiveField(16)
  List<Lessons> lessons;

  ClassroomEntity.SubjectPlan subjectPlan;

  SubjectPlanTree({
    this.id,
    this.createdBy,
    this.updatedBy,
    this.name,
    this.description,
    this.left,
    this.right,
    this.level,
    this.subjectPlanId,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.lessons,
    this.isRoot,
    this.children,
    this.subjectPlan
  });

  SubjectPlanTree.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    description = json['description'];
    left = json['left'];
    right = json['right'];
    level = json['level'];
    subjectPlanId = json['SubjectPlanId'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    isRoot = json['isRoot'];
    if (json['children'] != null) {
      children = new List<SubjectPlanTree>();
      json['children'].forEach((v) {
        children.add(new SubjectPlanTree.fromJson(v));
      });
    }
    if (json['lessons'] != null) {
      lessons = new List<Lessons>();
      json['lessons'].forEach((v) {
        lessons.add(new Lessons.fromJson(v));
      });
    }
    if (json['Lessons'] != null) {
      lessons = new List<Lessons>();
      json['Lessons'].forEach((v) {
        lessons.add(new Lessons.fromJson(v));
      });
    }
    if(json['SubjectPlan'] != null) {
      subjectPlan = ClassroomEntity.SubjectPlan.fromJson(json['SubjectPlan']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['description'] = this.description;
    data['left'] = this.left;
    data['right'] = this.right;
    data['level'] = this.level;
    data['SubjectPlanId'] = this.subjectPlanId;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    data['isRoot'] = this.isRoot;
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    if (this.lessons != null) {
      data['lessons'] = this.lessons.map((v) => v.toJson()).toList();
    }
    return data;
  }

  @override
  String toString() {
    return 'SubjectPlanTree{id: $id, createdBy: $createdBy, updatedBy: $updatedBy, name: $name, description: $description, left: $left, right: $right, level: $level, subjectPlanId: $subjectPlanId, startDate: $startDate, endDate: $endDate, createdAt: $createdAt, updatedAt: $updatedAt, isRoot: $isRoot, deletedAt: $deletedAt, children: $children, lessons: $lessons}';
  }
}

@HiveType(typeId: 13)
class Lessons {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String name;
  @HiveField(4)
  String description;
  @HiveField(5)
  String startDate;
  @HiveField(6)
  String endDate;
  @HiveField(7)
  String videoUrl;
  @HiveField(8)
  String weekId;
  @HiveField(9)
  String fileId;
  @HiveField(10)
  String lessonType;
  @HiveField(11)
  String copiedFromLessonId;
  @HiveField(12)
  String createdAt;
  @HiveField(13)
  String updatedAt;
  @HiveField(14)
  String deletedAt;
  @HiveField(15)
  SubjectPlanTreeLessons subjectPlanTreeLessons;
  Week week;
  // @HiveField(17)
  AssignmentEvaluation assignmentEvaluation;
  // @HiveField(18)
  ProgressLessonEnrollment progressLessonEnrollment;
  @HiveField(19)
  List<LessonSections> lessonSections;
  @HiveField(20)
  List<Quiz> lessonMetaInfo;
  @HiveField(21)
  File file;
  @HiveField(22)
  ZoomLesson zoomLesson;
  @HiveField(23)
  String localVideoUrl;
  @HiveField(24)
  String classroomName;
  @HiveField(25)
  String userId;
  @HiveField(26)
  List<String> localVideoUrls = [];

  List<SubjectPlanTree> subjectPlanTrees;

  String fileSize;


  Lessons(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.name,
      this.description,
      this.startDate,
      this.endDate,
      this.videoUrl,
      this.weekId,
      this.fileId,
      this.lessonType,
      this.copiedFromLessonId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.subjectPlanTreeLessons,
      this.week,
      this.lessonSections,
      this.assignmentEvaluation,
      this.progressLessonEnrollment,
      this.lessonMetaInfo,
      this.file,
      this.zoomLesson,
      this.subjectPlanTrees,
      });

  Lessons.fromJson(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    createdBy = jsonObject['createdBy'];
    updatedBy = jsonObject['updatedBy'];
    name = jsonObject['name'];
    description = jsonObject['description'];
    startDate = jsonObject['startDate'];
    endDate = jsonObject['endDate'];
    videoUrl = jsonObject['videoUrl'];
    weekId = jsonObject['WeekId'];
    fileId = jsonObject['FileId'];
    lessonType = jsonObject['lessonType'];
    copiedFromLessonId = jsonObject['CopiedFromLessonId'];
    createdAt = jsonObject['createdAt'];
    updatedAt = jsonObject['updatedAt'];
    deletedAt = jsonObject['deletedAt'];
    file = jsonObject['File'] != null
        ? new File.fromJson(jsonObject['File'])
        : null;
    subjectPlanTreeLessons = jsonObject['SubjectPlanTreeLessons'] != null
        ? new SubjectPlanTreeLessons.fromJson(
            jsonObject['SubjectPlanTreeLessons'])
        : null;
    week = jsonObject['Week'] != null
        ? new Week.fromJson(jsonObject['Week'])
        : null;
    assignmentEvaluation = jsonObject['AssignmentEvaluation'] != null
        ? new AssignmentEvaluation.fromJson(jsonObject['AssignmentEvaluation'])
        : null;
    progressLessonEnrollment = jsonObject['ProgressLessonEnrollment'] != null
        ? new ProgressLessonEnrollment.fromJson(
            jsonObject['ProgressLessonEnrollment'])
        : null;
    if (jsonObject['LessonSections'] != null) {
      lessonSections = new List<LessonSections>();
      jsonObject['LessonSections'].forEach((v) {
        lessonSections.add(new LessonSections.fromJson(v));
      });
    }
    if(jsonObject['SubjectPlanTrees'] != null) {
      subjectPlanTrees = [];
      jsonObject['SubjectPlanTrees'].forEach((v) {
        subjectPlanTrees.add(SubjectPlanTree.fromJson(v));
      });
    }
    if (jsonObject['lessonMetaInfo'] != null) {
      var tempLessonMetaInfo;
      try {
        tempLessonMetaInfo = jsonDecode(jsonObject['lessonMetaInfo']);
      } catch (e) {
        tempLessonMetaInfo = jsonObject['lessonMetaInfo'];
      }
      if (tempLessonMetaInfo is List) {
        lessonMetaInfo =
            tempLessonMetaInfo.map<Quiz>((v) => new Quiz.fromJson(v)).toList();
      } else {
        zoomLesson = ZoomLesson.fromJson(tempLessonMetaInfo);
      }
    } else {
      lessonMetaInfo = null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['description'] = this.description;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['videoUrl'] = this.videoUrl;
    data['WeekId'] = this.weekId;
    data['FileId'] = this.fileId;
    data['lessonType'] = this.lessonType;
    data['CopiedFromLessonId'] = this.copiedFromLessonId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.subjectPlanTreeLessons != null) {
      data['SubjectPlanTreeLessons'] = this.subjectPlanTreeLessons.toJson();
    }
    if (this.week != null) {
      data['Week'] = this.week.toJson();
    }
    if (this.assignmentEvaluation != null) {
      data['AssignmentEvaluation'] = this.assignmentEvaluation.toJson();
    }
    if (this.progressLessonEnrollment != null) {
      data['ProgressLessonEnrollment'] = this.progressLessonEnrollment.toJson();
    }
    if (this.lessonSections != null) {
      data['LessonSections'] =
          this.lessonSections.map((v) => v.toJson()).toList();
    }
    if (this.lessonMetaInfo != null) {
      data['lessonMetaInfo'] =
          jsonEncode(this.lessonMetaInfo.map((e) => e.toJson()).toList())
              .toString();
    }
    return data;
  }

  @override
  String toString() {
    return 'Lessons{id: $id, createdBy: $createdBy, updatedBy: $updatedBy, name: $name, description: $description, startDate: $startDate, endDate: $endDate, videoUrl: $videoUrl, weekId: $weekId, fileId: $fileId, lessonType: $lessonType, copiedFromLessonId: $copiedFromLessonId, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, subjectPlanTreeLessons: $subjectPlanTreeLessons, week: $week, assignmentEvaluation: $assignmentEvaluation, progressLessonEnrollment: $progressLessonEnrollment, lessonSections: $lessonSections, lessonMetaInfo: $lessonMetaInfo, file: $file, zoomLesson: $zoomLesson, localVideoUrl: $localVideoUrl, classroomName: $classroomName, subjectPlanTrees: $subjectPlanTrees, fileSize: $fileSize}';
  }
}

class SubjectPlanTreeLessons {
  String id;
  String createdBy;
  String updatedBy;
  String subjectPlanTreeId;
  String lessonId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  SubjectPlanTreeLessons(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.subjectPlanTreeId,
      this.lessonId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  SubjectPlanTreeLessons.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    subjectPlanTreeId = json['SubjectPlanTreeId'];
    lessonId = json['LessonId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['SubjectPlanTreeId'] = this.subjectPlanTreeId;
    data['LessonId'] = this.lessonId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

@HiveType(typeId: 19)
class LessonSections {
  @HiveField(0)
  String id;
  @HiveField(1)
  String createdBy;
  @HiveField(2)
  String updatedBy;
  @HiveField(3)
  String name;
  @HiveField(4)
  String description;
  @HiveField(5)
  String url;
  @HiveField(6)
  String lessonId;
  @HiveField(7)
  String fileId;
  @HiveField(8)
  String createdAt;
  @HiveField(9)
  String updatedAt;
  @HiveField(10)
  String deletedAt;
  @HiveField(11)
  File file;

  LessonSections(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.name,
      this.description,
      this.url,
      this.lessonId,
      this.fileId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.file});

  LessonSections.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    name = json['name'];
    description = json['description'];
    url = json['url'];
    lessonId = json['LessonId'];
    fileId = json['FileId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    file = json['File'] != null ? new File.fromJson(json['File']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['name'] = this.name;
    data['description'] = this.description;
    data['url'] = this.url;
    data['LessonId'] = this.lessonId;
    data['FileId'] = this.fileId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.file != null) {
      data['File'] = this.file.toJson();
    }
    return data;
  }
}

class Week {
  String id;
  String name;
  int priority;
  String startDate;
  String endDate;
  String createdAt;
  String updatedAt;
  String deletedAt;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Week &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          priority == other.priority &&
          startDate == other.startDate &&
          endDate == other.endDate &&
          createdAt == other.createdAt &&
          updatedAt == other.updatedAt &&
          deletedAt == other.deletedAt;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      priority.hashCode ^
      startDate.hashCode ^
      endDate.hashCode ^
      createdAt.hashCode ^
      updatedAt.hashCode ^
      deletedAt.hashCode;

  Week(
      {this.id,
      this.name,
      this.priority,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Week.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    priority = json['priority'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['priority'] = this.priority;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class AssignmentEvaluation {
  String id;
  String lessonId;
  bool isEvaluated;
  String evaluatedOn;
  String createdAt;
  String updatedAt;
  String deletedAt;

  AssignmentEvaluation(
      {this.id,
      this.lessonId,
      this.isEvaluated,
      this.evaluatedOn,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  AssignmentEvaluation.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lessonId = json['LessonId'];
    isEvaluated = json['isEvaluated'];
    evaluatedOn = json['evaluatedOn'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['LessonId'] = this.lessonId;
    data['isEvaluated'] = this.isEvaluated;
    data['evaluatedOn'] = this.evaluatedOn;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class ProgressLessonEnrollment {
  String id;
  String createdBy;
  String updatedBy;
  String enrollmentId;
  String lessonId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  ProgressLessonEnrollment(
      {this.id,
      this.createdBy,
      this.updatedBy,
      this.enrollmentId,
      this.lessonId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  ProgressLessonEnrollment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdBy = json['createdBy'];
    updatedBy = json['updatedBy'];
    enrollmentId = json['EnrollmentId'];
    lessonId = json['LessonId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['createdBy'] = this.createdBy;
    data['updatedBy'] = this.updatedBy;
    data['EnrollmentId'] = this.enrollmentId;
    data['LessonId'] = this.lessonId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class ZoomLesson {
  String id;
  int type;
  String startTime;
  int duration;
  String joinUrl;

  ZoomLesson({this.id, this.type, this.startTime, this.duration, this.joinUrl});

  ZoomLesson.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    startTime = json['startTime'];
    duration = json['duration'];
    joinUrl = json['joinUrl'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['startTime'] = this.startTime;
    data['duration'] = this.duration;
    data['joinUrl'] = this.joinUrl;
    return data;
  }
}

class Quiz {
  String id;
  String questionTitle;
  String questionType;
  List<Answers> answers;
  List<File> fileList;
  String answerTitle;
  String correctAnswerId;
  List<String> fileUrls;

  Quiz(
      {this.id,
      this.questionTitle,
      this.questionType,
      this.answers,
      this.fileList,
      this.answerTitle,
      this.correctAnswerId});

  Quiz.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    questionTitle = json['questionTitle'];
    questionType = json['questionType'];
    if (json['answers'] != null) {
      answers = new List<Answers>();
      json['answers'].forEach((v) {
        answers.add(new Answers.fromJson(v));
      });
    }
    if (json['fileList'] != null) {
      fileList = new List<Null>();
      json['fileList'].forEach((v) {
        fileList.add(new File.fromJson(v));
      });
    }
    answerTitle = json['answerTitle'];
    correctAnswerId = json['correctAnswerId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['questionTitle'] = this.questionTitle;
    data['questionType'] = this.questionType;
    if (this.answers != null) {
      data['answers'] = this.answers.map((v) => v.toJson()).toList();
    }
    if (this.fileList != null) {
      data['fileList'] = this.fileList.map((v) => v.toJson()).toList();
    }
    data['answerTitle'] = this.answerTitle;
    data['correctAnswerId'] = this.correctAnswerId;
    return data;
  }

  @override
  String toString() {
    return 'Quiz{id: $id, questionTitle: $questionTitle, questionType: $questionType, answers: $answers, fileList: $fileList, answerTitle: $answerTitle, correctAnswerId: $correctAnswerId}';
  }
}

class Answers {
  String title;
  String id;
  bool correct;
  File answerFile;
  String fileUrl;

  Answers({this.title, this.id, this.correct, this.answerFile});

  Answers.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    id = json['id'];
    correct = json['correct'];
    answerFile = json['answerFile'] != null
        ? new File.fromJson(json['answerFile'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['id'] = this.id;
    data['correct'] = this.correct;
    if (this.answerFile != null) {
      data['answerFile'] = this.answerFile.toJson();
    }
    return data;
  }
}
