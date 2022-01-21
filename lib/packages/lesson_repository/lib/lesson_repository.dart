import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/src/lesson_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/src/lesson_hive_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';

class LessonRepository {
  static LessonRepository _instance;

  final LessonApiProvider _apiProvider;
  final LessonHiveRepository _repository;

  LessonRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new LessonApiProvider(authenticationRepository),
        _repository = new LessonHiveRepository() {
    _instance = this;
  }

  factory LessonRepository(
          {AuthenticationRepository authenticationRepository}) =>
      _instance ??
      LessonRepository._privateConstructor(authenticationRepository);

  Future<Lessons> getLessonById(String id) async {
    final lesson = await _apiProvider.getLessonById(id);
    return lesson;
  }

  Future<void> saveLocalLesson(Lessons lesson) async {
    await _repository.saveLocalLesson(lesson);
  }

  Future<Lessons> getLocallySavedLessonById(String id) async {
    final lesson = await _repository.getLocallySavedLessonById(id);
    return lesson;
  }

  Future<List<Lessons>> getAllLocallySavedLessons(String userId) async {
    final lessons = await _repository.getAllLocallySavedLessons(userId);
    // Bejme kontrollin e userId per shkak se ne versionin e par qe eshte hedhur online
    // nuk e ka fushen userId ne databasen lokale
    lessons.forEach((e) {
      if (e.userId == null) {
        return e.userId = userId;
      }
    });
    return lessons;
  }

  Future<void> deleteSavedLessonById(String id) async {
    await _repository.deleteSavedLessonById(id);
  }

  Future<List<Lessons>> getCalendarLessonsByDateSegmentAndClassroomId(
      String startDate, String endDate) async {
    final lessons = await _apiProvider
        .getCalendarLessonsByDateSegmentAndClassroomId(startDate, endDate);
    return lessons;
  }
}
