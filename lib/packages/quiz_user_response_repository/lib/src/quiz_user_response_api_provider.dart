
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/src/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/http_client/lib/http_client.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';

const path = "/quiz-user-responses";

class QuizUserResponseApiProvider extends ApiServiceData {
  QuizUserResponseApiProvider(AuthenticationRepository authenticationRepository) : super(authenticationRepository);


  Future<QuizAnswers> createUserQuizResponse(QuizAnswers answers) async {
    final quizAnswerResponse = await this.post("$path", answers.toJson());
    final quizAnswers = QuizAnswers.fromJson(quizAnswerResponse);
    return quizAnswers;
  }

  Future<QuizAnswers> getUserQuizResponse(String quizId) async {
    final userId = await authenticationRepository.getCurrentUserId();
    final quizAnswerResponse = await this.getRequest("$path/$userId/$quizId");
    final quizAnswers = QuizAnswers.fromJson(quizAnswerResponse);
    return quizAnswers;
  }
}