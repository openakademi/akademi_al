part of 'lesson_item_bloc.dart';

class LessonItemEvent extends Equatable {
  const LessonItemEvent();

  @override
  List<Object> get props => [];
}

class LoadLesson extends LessonItemEvent {
  final String lessonId;
  final EnrollmentEntity enrollmentEntity;
  final ClassroomEntity classroomEntity;

  LoadLesson(this.lessonId, this.enrollmentEntity, this.classroomEntity);

  @override
  List<Object> get props => [lessonId, enrollmentEntity, classroomEntity];
}

class EndLesson extends LessonItemEvent{

  @override
  List<Object> get props => [];
}

class NewAssignmentUserCommit extends LessonItemEvent {
  final AssignmentUserCommit assignmentUserCommit;

  NewAssignmentUserCommit(this.assignmentUserCommit);

  @override
  List<Object> get props => [assignmentUserCommit];
}

class SaveVideoLessonLocally extends LessonItemEvent {
  final String localUrl;

  SaveVideoLessonLocally(this.localUrl);

  @override
  List<Object> get props => [localUrl];
}