
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/lib/user_commits_api_provider.dart';

class UserCommitsRepository {

  static UserCommitsRepository _instance;


  UserCommitsRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new UserCommitsApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory UserCommitsRepository(
      {AuthenticationRepository authenticationRepository}) =>
      _instance ??
          UserCommitsRepository._privateConstructor(authenticationRepository);

  final UserCommitsApiProvider _apiProvider;


  Future<List<AssignmentUserCommit>> getUserCommits() async {
    List<AssignmentUserCommit> response = await this._apiProvider.getUserCommits();
    return response;
  }
  Future<AssignmentUserCommit> getAssignmentUserCommitByUserIdLessonId(String lessonId) async {
    AssignmentUserCommit response = await this._apiProvider.getAssignmentUserCommitByUserIdLessonId(lessonId);
    return response;
  }

  Future<AssignmentUserCommit> createAssignmentUserCommit(AssignmentUserCommit newUserCommit) async {
    AssignmentUserCommit response = await this._apiProvider.createNewUserCommit(newUserCommit);
    return response;
  }
}