
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_async.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';

import 'src/subject_plan_tree_api_provider.dart';

class SubjectPlanTreeRepository {

  static SubjectPlanTreeRepository _instance;


  SubjectPlanTreeRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new SubjectPlanTreeApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory SubjectPlanTreeRepository(
      {AuthenticationRepository authenticationRepository}) =>
      _instance ??
          SubjectPlanTreeRepository._privateConstructor(authenticationRepository);

  final SubjectPlanTreeApiProvider _apiProvider;

  Future<List<TagsNotAsync>> getTagsNotAsyncOnly() async {
    final tags = await _apiProvider.getTagsNotAsyncOnly();
    return tags;
  }

  Future<List<TagsAsync>> getTagsAsyncOnly(String classroomId) async {
    final tags = await _apiProvider.getTagsAsyncOnly(classroomId);
    return tags;
  }

  Future<List<SubjectLessons>> getSubjectPlanTreeByClassroomId([String classroomId, String tagId, String organization]) async {
    final subjectPlanTree = await _apiProvider.getSubjectPlanTreeByClassroomId(classroomId, tagId, organization);
    return subjectPlanTree;
  }

  Future<SubjectPlanTree> getSubjectPlanTreeBySubjectPlanId(String subjectId) async {
    final subjectPlanTree = await _apiProvider.getSubjectPlanTreeBySubjectPlanId(subjectId);
    return subjectPlanTree;
  }

}