import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

import 'organizations.dart';
import 'roles.dart';
import 'user.dart';

part 'authorization_token.g.dart';

@HiveType(typeId: 7)
class AuthorizationToken extends Equatable {
  @HiveField(1)
  String accessToken;
  @HiveField(2)
  String accessTokenExpiresAt;
  @HiveField(3)
  String refreshToken;
  @HiveField(4)
  String refreshTokenExpiresAt;
  @HiveField(9)
  User user;
  @HiveField(5)
  String userId;
  @HiveField(6)
  List<Roles> roles;
  @HiveField(7)
  List<Organization> organizations;
  @HiveField(8)
  List<String> scopes;

  AuthorizationToken.fromJson(Map<String, dynamic> json) {
    accessToken = json['accessToken'];
    accessTokenExpiresAt = json['accessTokenExpiresAt'];
    refreshToken = json['refreshToken'];
    refreshTokenExpiresAt = json['refreshTokenExpiresAt'];
    user = json['User'] != null ? new User.fromJson(json['User']) : null;
    userId = json['UserId'];
    if (json['Roles'] != null) {
      roles = new List<Roles>();
      json['Roles'].forEach((v) {
        roles.add(new Roles.fromJson(v));
      });
    }
    if (json['Organizations'] != null) {
      organizations = new List<Organization>();
      json['Organizations'].forEach((v) {
        organizations.add(new Organization.fromJson(v));
      });
    }
    scopes = json['scopes'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['accessToken'] = this.accessToken;
    data['accessTokenExpiresAt'] = this.accessTokenExpiresAt;
    data['refreshToken'] = this.refreshToken;
    data['refreshTokenExpiresAt'] = this.refreshTokenExpiresAt;
    if (this.user != null) {
      data['User'] = this.user.toJson();
    }
    data['UserId'] = this.userId;
    if (this.roles != null) {
      data['Roles'] = this.roles.map((v) => v.toJson()).toList();
    }
    if (this.organizations != null) {
      data['Organizations'] =
          this.organizations.map((v) => v.toJson()).toList();
    }
    data['scopes'] = this.scopes;
    return data;
  }

  @override
  List<Object> get props => [
        accessToken,
        accessToken,
        accessTokenExpiresAt,
        refreshToken,
        refreshTokenExpiresAt,
        user,
        userId,
        roles,
        organizations,
        scopes,
      ];

  AuthorizationToken();

  @override
  String toString() {
    return 'AuthorizationToken{accessToken: $accessToken, accessTokenExpiresAt: $accessTokenExpiresAt, refreshToken: $refreshToken, refreshTokenExpiresAt: $refreshTokenExpiresAt, user: ${user.toString()}, userId: $userId, roles: $roles, organizations: $organizations, scopes: $scopes}';
  }
}
