import 'dart:async';

import 'package:akademi_al_mobile_app/packages/async_subject_repository/lib/async_subject_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_subject.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dashboard_event.dart';

part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc(
      {this.enrollmentRepository,
      this.asyncSubjectRepository,
      this.classroomRepository,
      this.userCommitsRepository})
      : super(DashboardState());
  final EnrollmentRepository enrollmentRepository;
  final AsyncSubjectRepository asyncSubjectRepository;
  final ClassroomRepository classroomRepository;
  final UserCommitsRepository userCommitsRepository;

  @override
  Stream<DashboardState> mapEventToState(
    DashboardEvent event,
  ) async* {
    if (event is LoadDashboard) {
      yield* _mapLoadDashboardToState(event, state);
    }
  }

  Stream<DashboardState> _mapLoadDashboardToState(
      LoadDashboard event, DashboardState state) async* {
    final allEnrollments = await this.enrollmentRepository.getAllEnrollments();
    yield state.copyWith(
      allEnrollments: allEnrollments,
    );
    final asyncSubjects = await asyncSubjectRepository.getWithAsync();
    final filteredAsyncSubject = asyncSubjects
        .where((element) =>
            element.gradeSubjects
                .expand((element) => element.classrooms)
                .toList()
                .length >
            0)
        .toList();
    filteredAsyncSubject.sort((a, b) => a.name.compareTo(b.name));
    yield state.copyWith(asyncSubjects: filteredAsyncSubject);

    final assignments = await classroomRepository
        .getAssignmentsByStartDate(DateTime.now().toString());
    List<AssignmentUserCommit> userCommits =
        await userCommitsRepository.getUserCommits();

    // Marrim te gjitha detyrat qe nuk jane dorzuar nga secili kurs
    List<Lessons> _assignments = [];
    assignments.forEach((element) {
      final allLessons = element.subjectPlan.subjectPlanTree.lessons;
      if (allLessons != null) {
        allLessons.sort((a, b) {
          final aEndDate =
              a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
          final bEndDate =
              b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
          return aEndDate.compareTo(bEndDate);
        });

        if (allLessons != null && allLessons.length > 0) {
          allLessons.where((element) {
            int index = userCommits.indexWhere((e) => e.lessonId == element.id);
            if (index == -1) {
              _assignments.add(element);
              return true;
            }
            return false;
          }).toList();
        }
      }
    });

    yield state.copyWith(classrooms: assignments, userCommits: userCommits, assignments: _assignments );
  }
}
