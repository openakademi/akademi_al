import 'dart:async';

import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/src/home/models/models.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:package_info/package_info.dart';

part 'home_event.dart';

part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({this.enrollmentRepository, this.offline})
      : super(HomeState(
            currentNavigationItem: offline
                ? NavigationItemKey.DOWNLOADED
                : NavigationItemKey.HOME));

  final EnrollmentRepository enrollmentRepository;
  final bool offline;

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is NavigationItemChanged) {
      yield _mapNavigationItemChangedToState(event, state);
    } else if (event is DrawerOpenedFirstTime) {
      yield* _mapDrawerOpenedFirstTime(event, state);
    } else if (event is VirtualClassPageChanged) {
      yield _mapVirtualClassPageChangedToState(event, state);
    } else if (event is ViewAllVirtualClasses) {
      yield _mapViewAllVirtualClassroomsToState(event, state);
    } else if (event is VirtualClassPageChangedOpenedLesson) {
      yield _mapVirtualClassPageChangedOpenedLessonToState(event, state);
    }
  }

  HomeState _mapNavigationItemChangedToState(
      NavigationItemChanged event, HomeState state) {
    final newState = state.copyWith(
        currentNavigationItem: event.navigationItem,
        selectedVirtualClassroomId: event.selectedVirtualClassroomId,
        virtualClassroomPageIndex: 0,
        selectedEnrollment: event.enrollmentEntity,
        lessonToOpen: "");

    return newState;
  }

  Stream<HomeState> _mapDrawerOpenedFirstTime(
      DrawerOpenedFirstTime event, HomeState state) async* {
    yield state.copyWith(
      loading: true,
    );
    final allEnrollments = await this.enrollmentRepository.getAllEnrollments();
    yield state.copyWith(
        virtualClassEnrollments: allEnrollments
            .where((element) => !element.classroom.isAsync)
            .toList(),
        loading: false,
        allEnrollments: allEnrollments);
  }

  HomeState _mapVirtualClassPageChangedToState(
      VirtualClassPageChanged event, HomeState state) {
    return state.copyWith(
        virtualClassroomPageIndex: event.index, lessonToOpen: "");
  }

  HomeState _mapViewAllVirtualClassroomsToState(
      ViewAllVirtualClasses event, HomeState state) {
    return state.copyWith(
        allVirtualClasses:
            state.allVirtualClasses != null ? !state.allVirtualClasses : true);
  }

  HomeState _mapVirtualClassPageChangedOpenedLessonToState(
      VirtualClassPageChangedOpenedLesson event, HomeState state) {
    return state.copyWith(
        currentNavigationItem: event.navigationItem,
        selectedVirtualClassroomId: event.selectedVirtualClassroomId,
        lessonToOpen: event.lessonId);
  }
}
