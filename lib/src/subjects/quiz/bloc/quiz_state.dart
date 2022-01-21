part of 'quiz_bloc.dart';

class QuizState extends Equatable {
  const QuizState({this.lessons, this.answers, this.errors, this.finishedQuiz, this.enrollmentId, this.submitting, this.loading});

  final Lessons lessons;
  final QuizAnswers answers;
  final List<QuizErrors> errors;
  final bool finishedQuiz;
  final String enrollmentId;
  final bool submitting;
  final bool loading;

  QuizState copyWith({
    Lessons lessons,
    QuizAnswers answers,
    List<QuizErrors> errors,
    bool finishedQuiz,
    String enrollmentId,
    bool submitting,
    bool loading
  }) {
    return new QuizState(
      lessons: lessons ?? this.lessons,
      answers: answers ?? this.answers,
      errors: errors ?? this.errors,
      finishedQuiz: finishedQuiz ?? this.finishedQuiz,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      submitting: submitting ?? this.submitting,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [lessons, answers, errors, finishedQuiz, enrollmentId, submitting, loading];
}
