part of 'lesson_item_bloc.dart';

class LessonItemState extends Equatable {
  const LessonItemState(
      {this.lessonEntity,
      this.loading,
      this.submitting,
      this.answers,
      this.enrollmentEntity,
      this.lessonDone,
      this.assignmentUserCommit,
      this.classroomEntity});

  final Lessons lessonEntity;
  final QuizAnswers answers;
  final bool loading;
  final bool submitting;
  final EnrollmentEntity enrollmentEntity;
  final bool lessonDone;
  final AssignmentUserCommit assignmentUserCommit;
  final ClassroomEntity classroomEntity;

  LessonItemState copyWith(
      {Lessons lessonEntity,
      bool loading,
      bool submitting,
      QuizAnswers answers,
      EnrollmentEntity enrollmentEntity,
      bool lessonDone,
      AssignmentUserCommit assignmentUserCommit,
      ClassroomEntity classroomEntity}) {
    return new LessonItemState(
      lessonEntity: lessonEntity ?? this.lessonEntity,
      submitting: submitting ?? this.submitting,
      loading: loading ?? this.loading,
      answers: answers ?? this.answers,
      enrollmentEntity: enrollmentEntity ?? this.enrollmentEntity,
      lessonDone: lessonDone ?? this.lessonDone,
      assignmentUserCommit: assignmentUserCommit ?? this.assignmentUserCommit,
      classroomEntity: classroomEntity ?? this.classroomEntity,
    );
  }

  @override
  List<Object> get props => [
        lessonEntity,
        loading,
        submitting,
        answers,
        enrollmentEntity,
        lessonDone,
        assignmentUserCommit,
        classroomEntity
      ];
}
