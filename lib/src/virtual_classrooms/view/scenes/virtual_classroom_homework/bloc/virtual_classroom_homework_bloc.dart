import 'dart:async';

import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'virtual_classroom_homework_event.dart';

part 'virtual_classroom_homework_state.dart';

class VirtualClassroomHomeworkBloc
    extends Bloc<VirtualClassroomHomeworkEvent, VirtualClassroomHomeworkState> {
  VirtualClassroomHomeworkBloc(
      {this.subjectPlanTreeRepository, this.userCommitsRepository})
      : super(VirtualClassroomHomeworkState());
  final SubjectPlanTreeRepository subjectPlanTreeRepository;
  final UserCommitsRepository userCommitsRepository;

  @override
  Stream<VirtualClassroomHomeworkState> mapEventToState(
    VirtualClassroomHomeworkEvent event,
  ) async* {
    if (event is LoadAssignments) {
      yield* _mapLoadAssignmentsToState(event, state);
    } else if (event is ChangedFilters) {
      yield _mapChangedFiltersToState(event, state);
    }
  }

  Stream<VirtualClassroomHomeworkState> _mapLoadAssignmentsToState(
      LoadAssignments event, VirtualClassroomHomeworkState state) async* {
    yield state.copyWith(loading: true);

    SubjectPlanTree subjectPlanTree;
    subjectPlanTree = await subjectPlanTreeRepository.getSubjectPlanTreeBySubjectPlanId(event.subjectPlanId);

    List<Lessons> allLessons = _retrieveLessonsFroMTree(subjectPlanTree);
    List<Lessons> assignments = allLessons
        .where((element) => element.lessonType == "ASSIGNMENT")
        .toList();
    List<AssignmentUserCommit> userCommits =
        await userCommitsRepository.getUserCommits();
    assignments.sort((a, b) {
      final aEndDate =
          a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
      final bEndDate =
          b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
      return aEndDate.compareTo(bEndDate);
    });

    yield state.copyWith(
        assignments: assignments,
        loading: false,
        userCommits: userCommits,
        filteredAssignments: assignments);
  }

  _retrieveLessonsFroMTree(SubjectPlanTree subjectPlanTree) {
    if (subjectPlanTree == null) return null;
    final List<SubjectPlanTree> nodes = List<SubjectPlanTree>();
    final List<Lessons> lessons = List<Lessons>();
    nodes.add(subjectPlanTree);
    while (nodes.isNotEmpty) {
      final node = nodes.removeLast();
      if (node.children != null && node.children.isNotEmpty) {
        nodes.addAll(node.children);
      }
      lessons.addAll(node.lessons);
    }
    return lessons;
  }


  VirtualClassroomHomeworkState _mapChangedFiltersToState(
      ChangedFilters event, VirtualClassroomHomeworkState state) {
    final List<Lessons> allAssignments = state.assignments;
    if (event.filters != null && event.filters.isNotEmpty) {
      List<Lessons> filteredAssignments = [];
      event.filters.forEach((filter) {
        if (filter == "EVALUATED") {
          final evaluatedAssignments = allAssignments.where((lesson) {
            final userCommit = state.userCommits.firstWhere(
                (element) => element.lessonId == lesson.id,
                orElse: () => null);
            print("userCommit $userCommit");
            return userCommit != null &&
                userCommit.isCommitted &&
                userCommit.isEvaluated;
          }).toList();
          filteredAssignments.addAll(evaluatedAssignments);
        } else if (filter == "NOT_EVALUATED") {
          final notEvaluatedAssignments = allAssignments.where((lesson) {
            final userCommit = state.userCommits.firstWhere(
                (element) => element.lessonId == lesson.id,
                orElse: () => null);
            return userCommit != null &&
                userCommit.isCommitted &&
                !userCommit.isEvaluated;
          }).toList();
          filteredAssignments.addAll(notEvaluatedAssignments);
        } else if (filter == "NOT_COMMITED") {
          final notCommittedAssignments = allAssignments.where((lesson) {
            final userCommit = state.userCommits.firstWhere(
                (element) => element.lessonId == lesson.id,
                orElse: () => null);
            return userCommit == null;
          }).toList();
          filteredAssignments.addAll(notCommittedAssignments);
        }
      });
      return state.copyWith(
          filteredAssignments: filteredAssignments, filters: event.filters);
    } else {
      return state
          .copyWith(filteredAssignments: state.assignments, filters: []);
    }
  }
}
