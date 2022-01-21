part of 'classrooms_bloc.dart';

class ClassroomsState extends Equatable {
  const ClassroomsState({this.enrollments, this.loading});

  final List<EnrollmentEntity> enrollments;
  final bool loading;

  ClassroomsState copyWith({
    List<EnrollmentEntity> enrollments,
    bool loading
  }) {

    return new ClassroomsState(
      enrollments: enrollments ?? this.enrollments,
      loading: loading ?? this.loading,
    );
  }

  @override
  List<Object> get props => [enrollments, loading];
}
