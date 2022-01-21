part of 'virtual_classroom_homework_bloc.dart';

class VirtualClassroomHomeworkState extends Equatable {
  const VirtualClassroomHomeworkState(
      {this.subjectPlanTree,
      this.loading,
      this.assignments,
      this.userCommits,
      this.filters = const [],
      this.filteredAssignments});

  final SubjectPlanTree subjectPlanTree;
  final bool loading;
  final List<Lessons> assignments;
  final List<Lessons> filteredAssignments;
  final List<AssignmentUserCommit> userCommits;
  final List<String> filters;

  VirtualClassroomHomeworkState copyWith({
    SubjectPlanTree subjectPlanTree,
    bool loading,
    List<Lessons> assignments,
    List<Lessons> filteredAssignments,
    List<AssignmentUserCommit> userCommits,
    List<String> filters,
  }) {
    return new VirtualClassroomHomeworkState(
      subjectPlanTree: subjectPlanTree ?? this.subjectPlanTree,
      loading: loading ?? this.loading,
      assignments: assignments ?? this.assignments,
      userCommits: userCommits ?? this.userCommits,
      filters: filters ?? this.filters,
      filteredAssignments: filteredAssignments ?? this.filteredAssignments,
    );
  }

  @override
  List<Object> get props =>
      [subjectPlanTree, loading, assignments, userCommits, filters, filteredAssignments];
}
