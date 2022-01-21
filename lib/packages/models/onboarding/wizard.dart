import 'dart:convert';

import 'profile_picture_file.dart';

class Wizard {
  String id;
  State state;
  String wizardType;

  Wizard({this.id, this.state, this.wizardType});

  Wizard copyWith({
    String id,
    State state,
    String wizardType,
  }) {
    return new Wizard(
      id: id ?? this.id,
      state: state ?? this.state,
      wizardType: wizardType ?? this.wizardType,
    );
  }

  Wizard.fromJson(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    state = jsonObject['State'] != null
        ? new State.fromJson(jsonDecode(jsonObject['State']))
        : null;
    wizardType = jsonObject['WizardType'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.state != null) {
      data['State'] = jsonEncode(this.state.toJson()).toString();
    }
    data['WizardType'] = this.wizardType;
    return data;
  }

  Map<String, dynamic> toFinishDtoJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['wizardId'] = this.id;
    // data['role'] = this.state.role;
    data['nationality'] = this.state.nationality;
    data['profilePicture'] = this.state.profilePicture;
    data['profilePictureType'] = this.state.profilePictureType;
    if(this.state.grade != null && this.state.grade != ""){
      data['grade'] = this.state.grade;
    }
    data['virtualClassCode'] = this.state.virtualClassCode;
    if (this.state.classRooms != null) {
      data['classRooms'] = this.state.classRooms.map((v) => v).toList();
    }
    if (this.state.profilePictureFile != null) {
      data["profilePictureFile"] = this.state.profilePictureFile.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'Wizard{id: $id, state: ${state.toString()}, wizardType: $wizardType, profilePicture}';
  }
}

class State {
  List<NavigationItems> navigationItems;
  String role;
  String nationality;
  String profilePicture;
  String profilePictureType;
  String level;
  String grade;
  String education;
  List<String> classRooms;
  String virtualClassCode;
  ProfilePictureFile profilePictureFile;

  State(
      {this.navigationItems,
      this.role,
      this.nationality,
      this.profilePicture,
      this.profilePictureType,
      this.level,
      this.grade,
      this.education,
      this.classRooms,
      this.virtualClassCode,
      this.profilePictureFile});

  State copyWith(
      {List<NavigationItems> navigationItems,
      String role,
      String nationality,
      String profilePicture,
      String profilePictureType,
      String level,
      String grade,
      String education,
      List<String> classRooms,
      String virtualClassCode,
      ProfilePictureFile profilePictureFile}) {
    return new State(
        navigationItems: navigationItems ?? this.navigationItems,
        role: role ?? this.role,
        nationality: nationality ?? this.nationality,
        profilePicture: profilePicture ?? this.profilePicture,
        profilePictureType: profilePictureType ?? this.profilePictureType,
        level: level ?? this.level,
        grade: grade ?? this.grade,
        education: education ?? this.education,
        classRooms: classRooms ?? this.classRooms,
        virtualClassCode: virtualClassCode ?? this.virtualClassCode,
        profilePictureFile: profilePictureFile ?? this.profilePictureFile
    );
  }

  State.fromJson(Map<String, dynamic> json) {
    if (json['navigationItems'] != null) {
      navigationItems = new List<NavigationItems>();
      json['navigationItems'].forEach((v) {
        navigationItems.add(new NavigationItems.fromJson(v));
      });
    }
    role = json['role'];
    nationality = json['nationality'];
    profilePicture = json['profilePicture'];
    profilePictureType = json['profilePictureType'];
    level = json['level'];
    grade = json['grade'];
    education = json['education'];
    virtualClassCode = json['virtualClassCode'];
    if (json['classRooms'] != null) {
      classRooms = new List<String>();
      json['classRooms'].forEach((v) {
        classRooms.add(v);
      });
    }
    if(json['profilePictureFile'] != null) {
      profilePictureFile = ProfilePictureFile.fromJson(json['profilePictureFile']);
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.navigationItems != null) {
      data['navigationItems'] =
          this.navigationItems.map((v) => v.toJson()).toList();
    }
    data['role'] = this.role;
    data['nationality'] = this.nationality;
    data['profilePicture'] = this.profilePicture;
    data['profilePictureType'] = this.profilePictureType;
    data['level'] = this.level;
    data['grade'] = this.grade;
    data['education'] = this.education;
    data['virtualClassCode'] = this.virtualClassCode;
    if (this.classRooms != null) {
      data['classRooms'] = this.classRooms.map((v) => v).toList();
    }
    if(this.profilePictureFile != null) {
      data['profilePictureFile'] = this.profilePictureFile.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'State{navigationItems: ${navigationItems.toString()}, role: $role, $profilePictureFile}';
  }
}
enum NavigationItemStatus { Active, Complete, Disabled }

class NavigationItems {
  String id;
  int priority;
  NavigationItemStatus status;

  NavigationItems({this.id, this.priority, this.status});

  NavigationItems copyWith({
    String id,
    int priority,
    NavigationItemStatus status,
  }) {
    return new NavigationItems(
      id: id ?? this.id,
      priority: priority ?? this.priority,
      status: status ?? this.status,
    );
  }

  NavigationItems.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    priority = json['priority'];
    status = NavigationItemStatus.values[json['status']];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['priority'] = this.priority;
    data['status'] = this.status.index;
    return data;
  }

  @override
  String toString() {
    return 'NavigationItems{id: $id, priority: $priority, status: $status}';
  }
}
