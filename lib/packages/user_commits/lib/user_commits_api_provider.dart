import 'dart:convert';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';

const relative_url = "/assignment-user-commit";

class UserCommitsApiProvider extends ApiServiceData {
  UserCommitsApiProvider(AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<List<AssignmentUserCommit>> getUserCommits() async {
    List<dynamic> response = await this.getRequest("$relative_url/user");
    return response.map((e) => AssignmentUserCommit.fromJson(e)).toList();
  }

  Future<AssignmentUserCommit> getAssignmentUserCommitByUserIdLessonId(
      String lessonId) async {
    final userId = await authenticationRepository.getCurrentUserId();
    dynamic response = await this.getRequest("$relative_url/$userId/$lessonId");
    print("userAssignment ${jsonEncode(response.toString()).toString()}");
    return AssignmentUserCommit.fromJson(response);
  }

  Future<AssignmentUserCommit> createNewUserCommit(
      AssignmentUserCommit assignmentUserCommit) async {
    dynamic response =
        await this.post("$relative_url", assignmentUserCommit.toSaveJson());
    return AssignmentUserCommit.fromJson(response);
  }
}
