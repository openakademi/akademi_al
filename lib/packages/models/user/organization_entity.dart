class OrganizationEntity {
  String id;
  String name;
  String code;
  bool defaultOrganization;
  List<UserRoles> userRoles;

  OrganizationEntity(
      {this.id,
      this.name,
      this.code,
      this.defaultOrganization,
      this.userRoles});

  OrganizationEntity.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
    defaultOrganization = json['default'];
    if (json['UserRoles'] != null) {
      userRoles = new List<UserRoles>();
      json['UserRoles'].forEach((v) {
        userRoles.add(new UserRoles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    data['default'] = this.defaultOrganization;
    if (this.userRoles != null) {
      data['UserRoles'] = this.userRoles.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRoles {
  String id;
  String userId;
  String roleId;
  String createdAt;
  String updatedAt;
  String deletedAt;
  UserRoleOrganization userRoleOrganization;
  Role role;

  UserRoles(
      {this.id,
      this.userId,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt,
      this.userRoleOrganization,
      this.role});

  UserRoles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    roleId = json['RoleId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    userRoleOrganization = json['UserRoleOrganization'] != null
        ? new UserRoleOrganization.fromJson(json['UserRoleOrganization'])
        : null;
    role = json['Role'] != null ? new Role.fromJson(json['Role']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['RoleId'] = this.roleId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.userRoleOrganization != null) {
      data['UserRoleOrganization'] = this.userRoleOrganization.toJson();
    }
    if (this.role != null) {
      data['Role'] = this.role.toJson();
    }
    return data;
  }
}

class UserRoleOrganization {
  String id;
  String userRoleId;
  String organizationId;
  String createdAt;
  String updatedAt;
  String deletedAt;

  UserRoleOrganization(
      {this.id,
      this.userRoleId,
      this.organizationId,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  UserRoleOrganization.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userRoleId = json['UserRoleId'];
    organizationId = json['OrganizationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserRoleId'] = this.userRoleId;
    data['OrganizationId'] = this.organizationId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}

class Role {
  String id;
  String code;
  String description;
  int priority;
  String parentId;
  bool defaultRole;
  String createdAt;
  String updatedAt;
  String deletedAt;

  Role(
      {this.id,
      this.code,
      this.description,
      this.priority,
      this.parentId,
      this.defaultRole,
      this.createdAt,
      this.updatedAt,
      this.deletedAt});

  Role.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    description = json['description'];
    priority = json['priority'];
    parentId = json['parentId'];
    defaultRole = json['default'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['description'] = this.description;
    data['priority'] = this.priority;
    data['parentId'] = this.parentId;
    data['default'] = this.defaultRole;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    return data;
  }
}
