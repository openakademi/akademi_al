part of 'quiz_bloc.dart';

class QuizEvent extends Equatable {
  const QuizEvent();

  @override
  List<Object> get props => [];
}

class LoadQuiz extends QuizEvent {
  final Lessons lesson;
  final String enrollmentId;

  LoadQuiz(this.lesson, this.enrollmentId);

  @override
  List<Object> get props => [lesson,enrollmentId];
}

class ClickedAnswer extends QuizEvent {
  final String answerId;
  final String questionId;

  ClickedAnswer(this.answerId, this.questionId);

  @override
  List<Object> get props => [answerId, questionId];
}

class CheckAnswers extends QuizEvent {

  @override
  List<Object> get props => [];
}


class RedoQuiz extends QuizEvent {

  @override
  List<Object> get props => [];
}
