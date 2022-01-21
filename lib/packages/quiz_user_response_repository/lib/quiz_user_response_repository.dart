
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/src/quiz_user_response_api_provider.dart';

class QuizUserResponseRepository {

  static QuizUserResponseRepository _instance;

  QuizUserResponseRepository._privateConstructor(
      AuthenticationRepository authenticationRepository)
      : _apiProvider = new QuizUserResponseApiProvider(authenticationRepository) {
    _instance = this;
  }

  factory QuizUserResponseRepository(
      {AuthenticationRepository authenticationRepository}) =>
      _instance ??
          QuizUserResponseRepository._privateConstructor(authenticationRepository);

  final QuizUserResponseApiProvider _apiProvider;
  
  Future<QuizAnswers> createQuizAnswersForUserIdLessonId(QuizAnswers answers) async {
    final quizAnswers = await _apiProvider.createUserQuizResponse(answers);
    return quizAnswers;
  }

  Future<QuizAnswers> getQuizAnswersForUserIdLessonId(String quizId) async {
    final quizAnswers = await _apiProvider.getUserQuizResponse(quizId);
    print("quiz answers $quizAnswers");
    return quizAnswers;
  }
}