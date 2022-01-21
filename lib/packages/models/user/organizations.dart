import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'organizations.g.dart';

@HiveType(typeId: 9)
class Organization extends Equatable{
  @HiveField(0)
  String id;
  @HiveField(1)
  String userRoleId;
  @HiveField(2)
  String organizationId;
  @HiveField(3)
  String parentOrganizationId;
  @HiveField(4)
  String name;
  @HiveField(5)
  String code;
  Organization({this.userRoleId, this.organizationId, this.parentOrganizationId, this.name, this.code, this.id});

  Organization.fromJson(Map<String, dynamic> json) {
    userRoleId = json['UserRoleId'];
    organizationId = json['OrganizationId'];
    parentOrganizationId = json['ParentOrganizationId'];
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserRoleId'] = this.userRoleId;
    data['OrganizationId'] = this.organizationId;
    data['ParentOrganizationId'] = this.parentOrganizationId;
    data['id'] = this.id;
    data['name'] = this.name;
    data['code'] = this.code;
    return data;
  }

  @override
  List<Object> get props => [userRoleId, organizationId, parentOrganizationId];
}