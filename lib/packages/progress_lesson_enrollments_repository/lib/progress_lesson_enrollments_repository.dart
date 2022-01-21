import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/progress_lesson_enrollments.dart';

import 'src/progress_lesson_enrollments_api_provider.dart';

class ProgressLessonEnrollmentRepository {
  static ProgressLessonEnrollmentRepository _instance;

  ProgressLessonEnrollmentRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider =
            new ProgressLessonEnrollmentsApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory ProgressLessonEnrollmentRepository(
          {AuthenticationRepository authenticationRepository}) =>
      _instance ??
      ProgressLessonEnrollmentRepository._privateConstructor(
          authenticationRepository);

  final ProgressLessonEnrollmentsApiProvider _apiProvider;

  Future<dynamic> createProgressLessonEnrollment(
      ProgressLessonEnrollmentsDto progressLessonEnrollmentsDto) async {
    await _apiProvider
        .createProgressLessonEnrollment(progressLessonEnrollmentsDto);
  }
}
