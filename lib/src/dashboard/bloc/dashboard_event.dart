part of 'dashboard_bloc.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();
}

class LoadDashboard extends DashboardEvent {
  final List<EnrollmentEntity> allEnrollments;

  LoadDashboard(this.allEnrollments);

  @override
  List<Object> get props => [allEnrollments];
}
