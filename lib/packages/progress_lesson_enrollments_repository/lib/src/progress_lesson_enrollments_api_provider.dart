
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/progress_lesson_enrollments.dart';

const path = "/progress-lesson-enrollments";

class ProgressLessonEnrollmentsApiProvider extends ApiServiceData {
  ProgressLessonEnrollmentsApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);

  Future<dynamic> createProgressLessonEnrollment(ProgressLessonEnrollmentsDto progressLessonEnrollmentDto) async {
    final progressLessonEnrollment = await this.post("$path", progressLessonEnrollmentDto.toJson());
    return progressLessonEnrollment;
  }
}