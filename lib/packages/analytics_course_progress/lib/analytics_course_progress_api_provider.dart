import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_courses_progress.dart';
import 'package:http/http.dart';

const relative_url = "/analytics/courses";

class AnalyticsCourseProgressApiProvider extends ApiServiceData {
  AnalyticsCourseProgressApiProvider(
      AuthenticationRepository authenticationRepository)
      : super(authenticationRepository);

  Future<List<AsyncCoursesProgress>> getAsyncCoursesProgress() async{
    List<dynamic> response = await getRequest("$relative_url/async-courses-progress");
    return response.map((e) => AsyncCoursesProgress.fromJson(e)).toList();
  }
}