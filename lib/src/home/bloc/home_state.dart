part of 'home_bloc.dart';

class HomeState extends Equatable {
  final NavigationItemKey currentNavigationItem;
  final List<EnrollmentEntity> virtualClassEnrollments;
  final List<EnrollmentEntity> allEnrollments;
  final String selectedVirtualClassroomId;
  final EnrollmentEntity selectedEnrollment;
  final int virtualClassroomPageIndex;
  final bool loading;
  final bool allVirtualClasses;
  final bool noNavigation;
  final String lessonToOpen;
  final PackageInfo info;

  const HomeState(
      {this.currentNavigationItem = NavigationItemKey.HOME,
      this.virtualClassEnrollments,
      this.allEnrollments,
      this.selectedVirtualClassroomId,
      this.loading,
      this.virtualClassroomPageIndex,
      this.selectedEnrollment,
      this.allVirtualClasses,
      this.noNavigation,
      this.lessonToOpen,
      this.info});

  HomeState copyWith(
      {NavigationItemKey currentNavigationItem,
      List<EnrollmentEntity> virtualClassEnrollments,
      List<EnrollmentEntity> allEnrollments,
      String selectedVirtualClassroomId,
      bool loading,
      int virtualClassroomPageIndex,
      EnrollmentEntity selectedEnrollment,
      bool allVirtualClasses,
      String lessonToOpen,
      PackageInfo info}) {
    return new HomeState(
        currentNavigationItem:
            currentNavigationItem ?? this.currentNavigationItem,
        virtualClassEnrollments:
            virtualClassEnrollments ?? this.virtualClassEnrollments,
        allEnrollments: allEnrollments ?? this.allEnrollments,
        selectedVirtualClassroomId:
            selectedVirtualClassroomId ?? this.selectedVirtualClassroomId,
        loading: loading ?? this.loading,
        selectedEnrollment: selectedEnrollment ?? this.selectedEnrollment,
        allVirtualClasses: allVirtualClasses ?? this.allVirtualClasses,
        lessonToOpen: lessonToOpen ?? this.lessonToOpen,
        info: info ?? this.info,
        virtualClassroomPageIndex:
            virtualClassroomPageIndex ?? this.virtualClassroomPageIndex);
  }

  @override
  List<Object> get props => [
        currentNavigationItem,
        virtualClassEnrollments,
        selectedVirtualClassroomId,
        loading,
        virtualClassroomPageIndex,
        selectedEnrollment,
        allVirtualClasses,
        lessonToOpen,
        allEnrollments,
        info
      ];
}
