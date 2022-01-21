part of 'virtual_classroom_content_bloc.dart';

abstract class VirtualClassroomContentEvent extends Equatable {
  const VirtualClassroomContentEvent();
}

class LoadSubjectPlanTree extends VirtualClassroomContentEvent {
  final ClassroomEntity classroomEntity;
  final EnrollmentEntity enrollmentEntity;
  final List<SubjectLessons> groupedLessons;
  final List<Lessons> notGroupedLessons;
  final List<TagsNotAsync> tags;
  final Map<String, List<Lessons>> lessonsGroupedByWeek;

  LoadSubjectPlanTree(
      {this.classroomEntity,
      this.enrollmentEntity,
      this.groupedLessons,
      this.notGroupedLessons,
      this.tags,
      this.lessonsGroupedByWeek});

  @override
  List<Object> get props =>
      [classroomEntity, enrollmentEntity, groupedLessons, lessonsGroupedByWeek];
}

class AddFilter extends VirtualClassroomContentEvent {
  final List<String> filters;

  AddFilter(this.filters);

  @override
  List<Object> get props => [filters];
}

class ReloadSubjectPlanTree extends VirtualClassroomContentEvent {
  @override
  List<Object> get props => [];
}

class LessonChanged extends VirtualClassroomContentEvent {
  final String lessonId;

  LessonChanged(this.lessonId);

  @override
  List<Object> get props => [lessonId];
}

class NextLesson extends VirtualClassroomContentEvent {
  @override
  List<Object> get props => [];
}

class ClassroomContentTabChanged extends VirtualClassroomContentEvent {
  final int index;
  final String selectedTagId;

  ClassroomContentTabChanged(this.index, this.selectedTagId);

  @override
  List<Object> get props => [index];
}
