part of 'virtual_classroom_bloc.dart';

abstract class VirtualClassroomEvent extends Equatable {
  const VirtualClassroomEvent();
}

class VirtualClassroomOpened extends VirtualClassroomEvent {
  final String selectedVirtualClassroomId;
  final EnrollmentEntity enrollmentEntity;
  final String lessonToOpen;

  VirtualClassroomOpened( this.selectedVirtualClassroomId, this.enrollmentEntity, this.lessonToOpen);

  @override
  List<Object> get props => [selectedVirtualClassroomId, enrollmentEntity, lessonToOpen];
}


class VirtualClassroomPageChanged extends VirtualClassroomEvent {
  final int index;

  VirtualClassroomPageChanged(this.index);

  @override
  List<Object> get props => [index];
}

class VirtualClassPageChangedOpenedLesson extends VirtualClassroomEvent {
  final int index;
  final String lessonId;

  VirtualClassPageChangedOpenedLesson(this.index, this.lessonId);

  @override
  List<Object> get props => [index, lessonId];
}

class LessonChangedEvent extends VirtualClassroomEvent {
  final String lessonId;

  LessonChangedEvent(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}


class NextLessonEvent extends VirtualClassroomEvent {

  @override
  List<Object> get props => [];
}


class ReloadSubjectPlanTreeEvent extends VirtualClassroomEvent {
  @override
  List<Object> get props => [];
}
