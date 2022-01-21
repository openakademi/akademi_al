
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_entity.dart';
import 'package:hive/hive.dart';

part 'async_subject.g.dart';

@HiveType(typeId: 17)
class AsyncSubject {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  String description;
  @HiveField(3)
  String icon;
  @HiveField(7)
  List<GradeSubjects> gradeSubjects;
  @HiveField(4)
  String lastSyncDate;
  @HiveField(5)
  bool isUpdated;
  @HiveField(6)
  bool isDeleted;
  AsyncSubject(
      {this.id, this.name, this.description, this.icon, this.gradeSubjects, this.isDeleted, this.lastSyncDate, this.isUpdated});

  AsyncSubject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    icon = json['icon'];
    if (json['GradeSubjects'] != null) {
      gradeSubjects = new List<GradeSubjects>();
      json['GradeSubjects'].forEach((v) {
        gradeSubjects.add(new GradeSubjects.fromJson(v));
      });
    }
    lastSyncDate = json['lastSyncDate'];
    isUpdated = json['isUpdated'];
    isDeleted = json['isDeleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['icon'] = this.icon;
    if (this.gradeSubjects != null) {
      data['GradeSubjects'] =
          this.gradeSubjects.map((v) => v.toJson()).toList();
    }
    data['lastSyncDate'] = this.lastSyncDate;
    data['isUpdated'] = this.isUpdated;
    data['isDeleted'] = this.isDeleted;
    return data;
  }
}

@HiveType(typeId: 18)
class GradeSubjects {
  @HiveField(0)
  String id;
  @HiveField(1)
  List<ClassroomEntity> classrooms;

  GradeSubjects({this.id, this.classrooms});

  GradeSubjects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['Classrooms'] != null) {
      classrooms = new List<ClassroomEntity>();
      json['Classrooms'].forEach((v) {
        classrooms.add(new ClassroomEntity.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.classrooms != null) {
      data['Classrooms'] = this.classrooms.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
