part of 'dashboard_bloc.dart';

class DashboardState extends Equatable {

  final List<EnrollmentEntity> allEnrollments;
  final List<AsyncSubject> asyncSubjects;
  final List<ClassroomEntity> classrooms;
  final List<AssignmentUserCommit> userCommits;
  final List<Lessons> assignments;

  const DashboardState({this.allEnrollments, this.asyncSubjects, this.classrooms, this.userCommits, this.assignments});

  DashboardState copyWith({
    List<EnrollmentEntity> allEnrollments,
    List<AsyncSubject> asyncSubjects,
    List<ClassroomEntity> classrooms,
    List<AssignmentUserCommit> userCommits,
    List<Lessons> assignments
  }) {
    return new DashboardState(
      allEnrollments: allEnrollments ?? this.allEnrollments,
      asyncSubjects: asyncSubjects ?? this.asyncSubjects,
      classrooms: classrooms ?? this.classrooms,
      userCommits: userCommits ?? this.userCommits,
      assignments: assignments ?? this.assignments
    );
  }

  @override
  List<Object> get props => [allEnrollments, asyncSubjects, classrooms, userCommits, assignments];
}
