part of 'home_bloc.dart';

class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class NavigationItemChanged extends HomeEvent {
  final NavigationItemKey navigationItem;
  final String selectedVirtualClassroomId;
  final EnrollmentEntity enrollmentEntity;

  NavigationItemChanged(this.navigationItem, this.selectedVirtualClassroomId, this.enrollmentEntity);

  @override
  List<Object> get props => [navigationItem, selectedVirtualClassroomId, enrollmentEntity];
}

class DrawerOpenedFirstTime extends HomeEvent {
  @override
  List<Object> get props => [];
}

class VirtualClassPageChanged extends HomeEvent {
  final int index;

  VirtualClassPageChanged(this.index);
  
  @override
  List<Object> get props => [index];
}

class VirtualClassPageChangedOpenedLesson extends HomeEvent {
  final NavigationItemKey navigationItem;

  final String selectedVirtualClassroomId;
  final String lessonId;

  VirtualClassPageChangedOpenedLesson({this.navigationItem, this.lessonId, this.selectedVirtualClassroomId});

  @override
  List<Object> get props => [navigationItem, lessonId, selectedVirtualClassroomId];
}

class ViewAllVirtualClasses extends HomeEvent {
  @override
  List<Object> get props => [];
}