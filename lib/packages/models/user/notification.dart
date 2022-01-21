import 'organizations.dart';

class Notification {
  String id;
  String userId;
  String title;
  String message;
  String navigateUrl;
  String type;
  bool markedAsSeen;
  String organizationId;
  String createdAt;
  String updatedAt;
  String deletedAt;
  Organization organization;

  Notification(
      {this.id,
        this.userId,
        this.title,
        this.message,
        this.navigateUrl,
        this.type,
        this.markedAsSeen,
        this.organizationId,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.organization});

  Notification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['UserId'];
    title = json['title'];
    message = json['message'];
    navigateUrl = json['navigateUrl'];
    type = json['type'];
    markedAsSeen = json['markedAsSeen'];
    organizationId = json['OrganizationId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    deletedAt = json['deletedAt'];
    organization = json['Organization'] != null
        ? new Organization.fromJson(json['Organization'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['UserId'] = this.userId;
    data['title'] = this.title;
    data['message'] = this.message;
    data['navigateUrl'] = this.navigateUrl;
    data['type'] = this.type;
    data['markedAsSeen'] = this.markedAsSeen;
    data['OrganizationId'] = this.organizationId;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['deletedAt'] = this.deletedAt;
    if (this.organization != null) {
      data['Organization'] = this.organization.toJson();
    }
    return data;
  }
}
