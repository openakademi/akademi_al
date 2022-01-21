
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_async.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';

const relative_url = "/tags";

class SubjectPlanTreeApiProvider extends ApiServiceData{
  SubjectPlanTreeApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<List<TagsNotAsync>> getTagsNotAsyncOnly() async{
    final response = await getRequest("$relative_url/lessons/tag/not-asyncOnly");
    final tags = List.from(response).map((addItem) => TagsNotAsync.fromJson(addItem)).toList();
    return tags;
  }

  Future<List<TagsAsync>> getTagsAsyncOnly(String classroomId) async{
    final response = await getRequest("$relative_url/lessons/tag/all/$classroomId?organization=e47c7a13-83e8-41a0-afcc-3a8fd0fbda65");
    final tags = List.from(response).map((addItem) => TagsAsync.fromJson(addItem)).toList();
    return tags;
  }

  Future<List<SubjectLessons>> getSubjectPlanTreeByClassroomId(String classroomId, String tagId, String organization) async{
    print(classroomId);
    final response = await getRequest("$relative_url/tag/$tagId/classroom/$classroomId/lessons?organization=$organization");
    final subjectPlanTree = List.from(response).map((addItem) => SubjectLessons.fromJson(addItem)).toList();
    return subjectPlanTree;
  }

  Future<SubjectPlanTree> getSubjectPlanTreeBySubjectPlanId(String subjectPlanId) async{
    print(subjectPlanId);
    final response = await getRequest("/subject-plan-tree/subjectPlan/$subjectPlanId");
    final subjectPlanTree = SubjectPlanTree.fromJson(response);
    return subjectPlanTree;
  }
}