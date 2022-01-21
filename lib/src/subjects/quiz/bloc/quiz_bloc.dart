import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/progress_lesson_enrollments.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/src/subjects/quiz/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'quiz_event.dart';

part 'quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  QuizBloc(
      {this.lessonRepository,
      this.uploaderRepository,
      this.quizUserResponseRepository,
      this.authenticationRepository,
      this.progressLessonEnrollmentRepository})
      : super(QuizState());

  final LessonRepository lessonRepository;
  final UploaderRepository uploaderRepository;
  final QuizUserResponseRepository quizUserResponseRepository;
  final AuthenticationRepository authenticationRepository;
  final ProgressLessonEnrollmentRepository progressLessonEnrollmentRepository;

  @override
  Stream<QuizState> mapEventToState(
    QuizEvent event,
  ) async* {
    if (event is LoadQuiz) {
      yield* _mapLoadQuizToState(event, state);
    } else if (event is ClickedAnswer) {
      yield _mapClickedAnswerToState(event, state);
    } else if (event is CheckAnswers) {
      yield* _mapCheckAnswersToState(event, state);
    } else if (event is RedoQuiz) {
      yield _mapRedoQuizToState(event, state);
    }
  }

  Stream<QuizState> _mapLoadQuizToState(
      LoadQuiz event, QuizState state) async* {
    yield state.copyWith(submitting: true, loading: true);
    final lesson = event.lesson;
    final questions = await Future.wait(lesson.lessonMetaInfo.map((e) async {
      if (e.fileList != null && e.fileList.isNotEmpty) {
        final fileUrls = await Future.wait(e.fileList.map((e1) async {
          final url = await uploaderRepository.getS3UrlForAction(
              "${e1.filePath}/${e1.name}", S3ActionType.DOWNLOAD);
          return url;
        }));
        e.fileUrls = fileUrls;
      }
      if (e.answers != null && e.answers.isNotEmpty) {
        final newAnswers = await Future.wait(e.answers.map((e1) async {
          if (e1.answerFile != null) {
            final url = await uploaderRepository.getS3UrlForAction(
                "${e1.answerFile.filePath}/${e1.answerFile.name}",
                S3ActionType.DOWNLOAD);
            e1.fileUrl = url;
          }
          return e1;
        }));
        e.answers = newAnswers;
      }
      return e;
    }));

    lesson.lessonMetaInfo = questions;

    final quizAnswers = QuizAnswers();

    yield state.copyWith(
        lessons: lesson,
        answers: quizAnswers,
        enrollmentId: event.enrollmentId,
        submitting: false,
        loading: false);
  }

  QuizState _mapClickedAnswerToState(ClickedAnswer event, QuizState state) {
    final answers = state.answers;
    if (answers.answerMetaInfo == null) {
      answers.answerMetaInfo = [];
    }

    var answerMetaObject = answers.answerMetaInfo?.firstWhere(
        (element) => element?.questionId == event.questionId,
        orElse: () => null);
    if (answerMetaObject == null) {
      answerMetaObject =
          AnswerMetaInfo(questionId: event.questionId, answers: []);
      answerMetaObject.answers.add(Answer(answerId: event.answerId));
    } else {
      final question = state.lessons.lessonMetaInfo
          .firstWhere((element) => element.id == event.questionId);
      if (answerMetaObject.answers != null &&
          answerMetaObject.answers.firstWhere(
                  (element) => element.answerId == event.answerId,
                  orElse: () => null) !=
              null) {
        final newAnswers = question.questionType == "singleChoice"
            ? <Answer>[]
            : List<Answer>.from(answerMetaObject.answers);
        newAnswers.removeWhere((element) => element.answerId == event.answerId);
        answerMetaObject.answers = newAnswers;
      } else {
        final newAnswers = question.questionType == "singleChoice"
            ? <Answer>[]
            : List<Answer>.from(answerMetaObject.answers);
        newAnswers.add(Answer(answerId: event.answerId));
        answerMetaObject.answers = newAnswers;
      }
    }
    final newAnswerMetaInfo = answers.answerMetaInfo;
    newAnswerMetaInfo
        .removeWhere((element) => element?.questionId == event.questionId);
    newAnswerMetaInfo.add(answerMetaObject);
    return state.copyWith(
        answers: answers.copyWith(answerMetaInfo: newAnswerMetaInfo));
  }

  Stream<QuizState> _mapCheckAnswersToState(
      CheckAnswers event, QuizState state) async* {
    yield state.copyWith(submitting: true);
    final answers = state.answers;
    final lesson = state.lessons;
    Function eq = const DeepCollectionEquality.unordered().equals;
    List<QuizErrors> errors = [];

    answers.answerMetaInfo.forEach((element) {
      var answers = element.answers.map((e) => e.answerId).toList();
      var question = lesson.lessonMetaInfo.firstWhere(
          (element1) => element1.id == element.questionId,
          orElse: () => null);
      final correctAnswer =
          question.answers.where((element) => element.correct).toList();
      if (question.questionType == "singleChoice") {
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
        if (!eq(correctAnswer.map((e) => e.id).toList(), answers)) {
          final quizError = QuizErrors(
              questionId: element.questionId,
              errorMsg: correctAnswer.map((e) => e.title).join(" "));
          errors.add(quizError);
        }
      }
    });

    final userId = await authenticationRepository.getCurrentUserId();
    final answersToSave = answers.copyWith(
        id: Uuid().v4().toString(), lessonId: state.lessons.id, userId: userId);
    try {
      await quizUserResponseRepository
          .createQuizAnswersForUserIdLessonId(answersToSave);
    } catch (e) {
      print("${e.toString()}");
    }
    yield state.copyWith(errors: errors, finishedQuiz: true, submitting: false);
  }

  QuizState _mapRedoQuizToState(RedoQuiz event, QuizState state) {
    final answers = state.answers;
    final emptyAnswers = answers.copyWith(answerMetaInfo: []);
    final newErrors = <QuizErrors>[];
    return state.copyWith(
        answers: emptyAnswers, finishedQuiz: false, errors: newErrors);
  }
}
