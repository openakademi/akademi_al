part of 'virtual_classroom_homework_bloc.dart';

class VirtualClassroomHomeworkEvent extends Equatable {
  const VirtualClassroomHomeworkEvent();

  @override
  List<Object> get props => [];
}

class LoadAssignments extends VirtualClassroomHomeworkEvent {

  final List<SubjectLessons> subjectPlanTree;
  final String classroomId;
  final List<TagsNotAsync> tags;
  final String selectedTagId;
  final String subjectPlanId;

  LoadAssignments({this.subjectPlanTree, this.classroomId, this.selectedTagId, this.tags, this.subjectPlanId});

  @override
  List<Object> get props => [subjectPlanTree, classroomId, subjectPlanId];
}
class ChangedFilters extends VirtualClassroomHomeworkEvent {

  final List<String> filters;

  ChangedFilters({this.filters});

  @override
  List<Object> get props => [filters];
}