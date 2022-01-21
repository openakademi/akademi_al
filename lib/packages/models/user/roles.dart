import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'roles.g.dart';

@HiveType(typeId: 10)
class Roles extends Equatable {
  @HiveField(1)
  String id;
  @HiveField(2)
  String code;
  @HiveField(3)
  String userRoleId;

  Roles({this.id, this.code, this.userRoleId});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    code = json['code'];
    userRoleId = json['UserRoleId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['code'] = this.code;
    data['UserRoleId'] = this.userRoleId;
    return data;
  }

  @override
  List<Object> get props => [id, code, userRoleId];
}
