
import 'dart:convert';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:uuid/uuid.dart';
import 'dart:developer';

const relative_url = "/enrollments";

class EnrollmentApiProvider extends ApiServiceData {
  EnrollmentApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<List<EnrollmentEntity>> getAllEnrollments([DateTime lastUpdateDate]) async {
    final String url ="$relative_url";
    final organizaitonId = await authenticationRepository.getToken();
    List<dynamic> response = await getRequest(url);
    final enrollments = response.map((e) => EnrollmentEntity.fromJson(e)).toList();
    return enrollments;
  }

  Future<List<EnrollmentEntity>> getAllEnrollmentsByClassroomId(String classroomId) async {
    final String url ="$relative_url/classroom/$classroomId";
    List<dynamic> response = await getRequest(url);
    final enrollments = response.map((e) => EnrollmentEntity.fromJson(e)).toList();
    return enrollments;
  }


  Future<List<EnrollmentEntity>> getSyncEnrollments(DateTime lastUpdateDate) async {
    final String url ="$relative_url/sync/${lastUpdateDate.toString()}";
    List<dynamic> response = await getRequest(url);
    final enrollments = response.map((e) => EnrollmentEntity.fromJson(e)).toList();
    return enrollments;
  }


  Future<EnrollmentEntity> getEnrollmentById(String enrollmentId) async {
    final response = await getRequest("$relative_url/$enrollmentId");

    final enrollment = EnrollmentEntity.fromJson(response);
    return enrollment;
  }

  Future<EnrollmentEntity> createEnrollment(String classroomId) async {
    final userId = await authenticationRepository.getCurrentUserId();
    final response = await this.post("$relative_url", {
      "id": Uuid().v4().toString(),
      "ClassroomId": classroomId,
      "UserId": userId,
      "status": "ACTIVE",
      "enrolledAt": DateTime.now().toString()
    });
    return EnrollmentEntity.fromJson(response);
  }

  Future<void> deleteEnrollment(String enrollmentId) async {
    await deleteRequest("$relative_url/$enrollmentId");
  }
}
