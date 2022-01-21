part of 'async_classroom_item_bloc.dart';

abstract class AsyncClassroomItemEvent extends Equatable {
  const AsyncClassroomItemEvent();
}

class LoadClassroom extends AsyncClassroomItemEvent {
  final String classroomId;
  final String lessonId;

  LoadClassroom(this.classroomId, this.lessonId);

  @override
  List<Object> get props => [classroomId, lessonId];
}

class EnrollToClassroom extends AsyncClassroomItemEvent {
  @override
  List<Object> get props => [];
}

class ContinueClassroom extends AsyncClassroomItemEvent {
  @override
  List<Object> get props => [];
}

class LessonSelected extends AsyncClassroomItemEvent {
  final String lessonId;

  LessonSelected(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

class EndLesson extends AsyncClassroomItemEvent{
  final String lessonId;

  EndLesson(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

class CloseOpenedClassroom extends AsyncClassroomItemEvent{

  CloseOpenedClassroom();

  @override
  List<Object> get props => [];
}

class ClassroomContentTabChanged extends AsyncClassroomItemEvent {
  final int index;
  final String selectedTagId;

  ClassroomContentTabChanged(this.index, this.selectedTagId);

  @override
  List<Object> get props => [index];
}