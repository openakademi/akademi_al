import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/models/models.dart';
import 'package:akademi_al_mobile_app/src/virtual_classrooms/view/scenes/virtual_classroom_item/bloc/lesson_item_bloc.dart';
import 'package:collection/collection.dart';

class LessonItemUtils {
  isAfterDeadline(Lessons lesson) {
    final now = DateTime.now();
    if (lesson.endDate != null) {
      final endDate = DateTime.tryParse(lesson.endDate);
      return now.isAfter(endDate);
    } else {
      return false;
    }
  }

  getCurrentNumberOfAnswers(LessonItemState state) {
    if (state.answers != null && state.lessonEntity.lessonMetaInfo != null) {
      Function eq = const DeepCollectionEquality.unordered().equals;
      List<QuizErrors> errors = [];

      state.answers.answerMetaInfo?.forEach((element) {
        var answers = element.answers.map((e) => e.answerId).toList();
        var question = state.lessonEntity.lessonMetaInfo.firstWhere(
            (element1) => element1.id == element.questionId,
            orElse: () => null);
        if (question != null) {
          final correctAnswer =
              question?.answers?.where((element) => element.correct)?.toList();
          if (question?.questionType == "singleChoice") {
            final correctAnswerValue =
                correctAnswer.length == 1 ? correctAnswer[0] : null;
            final answerValue = answers.length == 1 ? answers[0] : null;
            if (correctAnswerValue.id != answerValue) {
              final quizError = QuizErrors(
                  questionId: element.questionId,
                  errorMsg: correctAnswerValue.title);
              errors.add(quizError);
            }
          } else {
            if (!eq(correctAnswer?.map((e) => e.id).toList(), answers)) {
              final quizError = QuizErrors(
                  questionId: element.questionId,
                  errorMsg: correctAnswer.map((e) => e.title).join(" "));
              errors.add(quizError);
            }
          }
        }
      });
      return state.lessonEntity.lessonMetaInfo.length -
          errors.length -
          (state.lessonEntity.lessonMetaInfo.length -
              state.answers.answerMetaInfo.length);
    }
  }
}
