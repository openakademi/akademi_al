class UserEntity {
  String id;
  String email;
  String username;
  String firstName;
  String lastName;
  String dateOfBirth;
  String status;
  String parentEmail;
  String nationality;
  List<Classroom> classrooms;
  List<Role> roles;

  UserEntity(
      {this.id,
        this.email,
        this.username,
        this.firstName,
        this.lastName,
        this.dateOfBirth,
        this.status,
        this.parentEmail,
        this.nationality,
        this.classrooms,
        this.roles});

  UserEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    username = json['username'];
    firstName = json['firstName'];
    lastName = json['lastName'];
    dateOfBirth = json['dateOfBirth'];
    status = json['status'];
    parentEmail = json['parentEmail'];
    nationality = json['nationality'];
    if (json['Classrooms'] != null) {
      classrooms = new List<Classroom>();
      json['Classrooms'].forEach((v) {
        classrooms.add(new Classroom.fromJson(v));
      });
    }
    if (json['Roles'] != null) {
      roles = new List<Role>();
      json['Roles'].forEach((v) {
        roles.add(new Role.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['username'] = this.username;
    data['firstName'] = this.firstName;
    data['lastName'] = this.lastName;
    data['dateOfBirth'] = this.dateOfBirth;
    data['status'] = this.status;
    data['parentEmail'] = this.parentEmail;
    data['nationality'] = this.nationality;
    if (this.classrooms != null) {
      data['Classrooms'] = this.classrooms.map((v) => v.toJson()).toList();
    }
    if (this.roles != null) {
      data['Roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Classroom {
  String id;
  bool isAsync;
  String name;
  String description;
  Enrollment enrollment;

  Classroom(
      {this.id, this.isAsync, this.name, this.description, this.enrollment});

  Classroom.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    isAsync = json['isAsync'];
    name = json['name'];
    description = json['description'];
    enrollment = json['Enrollment'] != null
        ? new Enrollment.fromJson(json['Enrollment'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['isAsync'] = this.isAsync;
    data['name'] = this.name;
    data['description'] = this.description;
    if (this.enrollment != null) {
      data['Enrollment'] = this.enrollment.toJson();
    }
    return data;
  }
}

class Enrollment {
  String id;
  String userId;
  String classroomId;
  String status;
  String enrolledAt;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Enrollment(
      {this.id,
        this.userId,
        this.classroomId,
        this.status,
        this.enrolledAt,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  Enrollment.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    classroomId = json['ClassroomId'];
    status = json['status'];
    enrolledAt = json['enrolledAt'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['ClassroomId'] = this.classroomId;
    data['status'] = this.status;
    data['enrolledAt'] = this.enrolledAt;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class Role {
  String code;
  UserRole userRole;

  Role({this.code, this.userRole});

  Role.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userRole = json['UserRole'] != null
        ? new UserRole.fromJson(json['UserRole'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.userRole != null) {
      data['UserRole'] = this.userRole.toJson();
    }
    return data;
  }
}

class UserRole {
  String id;
  String userId;
  String roleId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  UserRole(
      {this.id,
        this.userId,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt});

  UserRole.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    roleId = json['RoleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['RoleId'] = this.roleId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
