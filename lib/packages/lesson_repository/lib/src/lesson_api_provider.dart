

import 'dart:convert';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';

const relative_url = "/lesson";

class LessonApiProvider extends ApiServiceData {
  LessonApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<Lessons> getLessonById(String id) async {
    final response = await this.getRequest("$relative_url/$id");
    final lesson = Lessons.fromJson(response);
    return lesson;
  }

  Future<List<Lessons>> getCalendarLessonsByDateSegmentAndClassroomId(String startDate, String endDate) async {
    List<dynamic> lessons = await this.getRequest("$relative_url/endDate/${Uri.encodeFull(startDate)}/${Uri.encodeFull(endDate)}/classroom/ALL");
    return lessons.map((e) => Lessons.fromJson(e)).toList();
  }
}