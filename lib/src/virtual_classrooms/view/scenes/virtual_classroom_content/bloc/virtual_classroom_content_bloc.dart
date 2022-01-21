import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'virtual_classroom_content_event.dart';

part 'virtual_classroom_content_state.dart';

class VirtualClassroomContentBloc
    extends Bloc<VirtualClassroomContentEvent, VirtualClassroomContentState> {
  VirtualClassroomContentBloc(
      {this.subjectPlanTreeRepository, this.enrollmentRepository, this.organizationRepository})
      : super(VirtualClassroomContentState());
  final SubjectPlanTreeRepository subjectPlanTreeRepository;
  final EnrollmentRepository enrollmentRepository;
  final OrganizationRepository organizationRepository;

  @override
  Stream<VirtualClassroomContentState> mapEventToState(
    VirtualClassroomContentEvent event,
  ) async* {
    if (event is LoadSubjectPlanTree) {
      yield* _mapLoadSubjectPlanTreeToState(event, state);
    } else if (event is AddFilter) {
      yield _mapAddFilterToState(event, state);
    } else if (event is ReloadSubjectPlanTree) {
      yield* _mapReloadSubjectPlanTreeToState(event, state);
    } else if (event is LessonChanged) {
      yield _mapLessonChangedToState(event, state);
    } else if (event is NextLesson) {
      yield _mapNextLessonToState(event, state);
    } else if (event is ClassroomContentTabChanged) {
      yield* _mapClassroomContentTabChangeToState(event, state);
    }
  }

  Stream<VirtualClassroomContentState> _mapLoadSubjectPlanTreeToState(
      LoadSubjectPlanTree event, VirtualClassroomContentState state) async* {
    yield state.copyWith(loading: true);

    final enrollmentEntity = await enrollmentRepository.getEnrollmentById(event.enrollmentEntity.id);

    final selectedOrganization =
    await organizationRepository.getSelectedOrganization();
    // Get all grouped lessons
    List<SubjectLessons> groupedLessons = [];
    if (event.classroomEntity.subjectPlan != null && event.tags != null) {
      String selectedTagId = state.selectedTagId != null ? state.selectedTagId : event.tags[0].id;
      groupedLessons = await subjectPlanTreeRepository
          .getSubjectPlanTreeByClassroomId(event.classroomEntity.id, selectedTagId, selectedOrganization);
    }

    List<String> weeks = _getWeeks(groupedLessons);
    // Get ungrouped lessons, here we use an old api
    SubjectPlanTree subjectPlanTreeNotGrouped;
    List<Lessons> allLessonsInArray = [];
    List<Lessons> notGroupedLessons = [];
    Map<String, List<Lessons>> lessonsGroupedByWeek = {};
    if (event.classroomEntity.subjectPlan != null) {
      subjectPlanTreeNotGrouped = await subjectPlanTreeRepository
          .getSubjectPlanTreeBySubjectPlanId(event.classroomEntity.subjectPlan.id);
      notGroupedLessons = _getLessonsWithoutGroup(groupedLessons, subjectPlanTreeNotGrouped);
      lessonsGroupedByWeek= _groupLessonsByWeek(groupedLessons, notGroupedLessons);
      allLessonsInArray = _getAllLessonsInOneArray(groupedLessons, notGroupedLessons);
    }

      yield state.copyWith(
        classroomEntity: event.classroomEntity,
        loading: false,
        groupedLessons: groupedLessons,
        notGroupedLessons: notGroupedLessons,
        tags: event.tags,
        lessonsGroupedByWeek: lessonsGroupedByWeek,
        filteredLessonsGrouped: lessonsGroupedByWeek,
        allLessonsInArray: allLessonsInArray,
        enrollmentEntity: enrollmentEntity,
        lessonsFinished:
            enrollmentEntity != null ? enrollmentEntity.lessons : List(),
        filters: weeks,
      );
  }

  _getLessonsWithoutGroup(List<SubjectLessons> subjectPlanTree,
      SubjectPlanTree subjectPlanTreeNotGrouped) {
    List<String> groupedLessonsId = [];
    if (subjectPlanTree == null) return null;
    subjectPlanTree.forEach((element) {
      element.classroomTags[0].lessonClassroomTag.forEach((el) {
        groupedLessonsId.add(el.lesson.id);
      });
    });

    final notGroupedLessons = subjectPlanTreeNotGrouped.lessons
        .where((element) => !groupedLessonsId.contains(element.id))
        .toList();

    notGroupedLessons.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return notGroupedLessons;
  }

  List<Lessons> _getAllLessonsInOneArray(
      List<SubjectLessons> lessons, List<Lessons> notGroupedLessons) {
    if (lessons == null) return null;
    List<Lessons> _lessons = [];
    List<Map<String, List<Lessons>>> map = [];
    _lessons.addAll(notGroupedLessons);
    lessons.forEach((element) {
      String weekName = element.name;
      List<Lessons> _temporaryList = [];
      Map<String, List<Lessons>> mapItem;

      element.classroomTags[0].lessonClassroomTag.forEach((el) {
        _lessons.add(el.lesson);
        _temporaryList.add(el.lesson);
      });
      mapItem = groupBy<Lessons, String>(_temporaryList, (obj) => weekName);
      map.add(mapItem);
    });
    lessons.sort((a, b) {
      return a.priority.compareTo(b.priority);
    });
    return _lessons;
  }

  Map<String, List<Lessons>> _groupLessonsByWeek(
      List<SubjectLessons> lessons, List<Lessons> notGroupedLessons) {
    if (lessons == null) return null;
    Map<String, List<Lessons>> map = {};

    if (notGroupedLessons != null && notGroupedLessons.length != 0) {
      map.putIfAbsent("Të pa grupuara", () => notGroupedLessons);
    }

    lessons.forEach((element) {
      String weekName = element.name;
      List<Lessons> _temporaryList = [];
      // Sort lessons
      element.classroomTags[0].lessonClassroomTag.sort((a, b) {
        return a.priority.compareTo(b.priority);
      });
      element.classroomTags[0].lessonClassroomTag.forEach((el) {
        _temporaryList.add(el.lesson);
      });
      map.putIfAbsent(weekName, () => _temporaryList);
    });
    return map;
  }

  Stream<VirtualClassroomContentState> _mapReloadSubjectPlanTreeToState(
      VirtualClassroomContentEvent event,
      VirtualClassroomContentState state) async* {
    yield state.copyWith(loading: true);
    final enrollmentEntity =
        await enrollmentRepository.getEnrollmentById(state.enrollmentEntity.id);
    yield state.copyWith(
      loading: false,
      enrollmentEntity: enrollmentEntity,
      lessonsFinished:
          enrollmentEntity != null ? enrollmentEntity.lessons : List(),
    );
  }

  List<String> _getWeeks(List<SubjectLessons> lessons) {
    if (lessons == null) return null;

    final notNullWeek =
        lessons.where((element) => element.name != null).toList();
    notNullWeek
        .sort((a, b) => a.priority.toString().compareTo(b.priority.toString()));
    List<String> _weeks = [];
    notNullWeek.forEach((element) {
      _weeks.add(element.name);
    });
    return _weeks;
  }

  VirtualClassroomContentState _mapAddFilterToState(
      AddFilter event, VirtualClassroomContentState state) {
    if (event.filters != null && event.filters.length > 0) {
      final Map<String, List<Lessons>> filtered = {};
      state.lessonsGroupedByWeek.forEach((key, value) {
        if (event.filters.firstWhere((el) => key == el, orElse: () => null) !=
            null) {
          filtered.putIfAbsent(key, () => value);
        }
      });
      return state.copyWith(
          filteredLessonsGrouped: filtered,
          filteredWeeks: event.filters.map((e) => e).toList());
    } else {
      return state.copyWith(
          filteredLessonsGrouped: state.lessonsGroupedByWeek,
          filteredWeeks: null);
    }
  }

  VirtualClassroomContentState _mapLessonChangedToState(
      LessonChanged event, VirtualClassroomContentState state) {
    return state.copyWith(currentlyOpenedLesson: event.lessonId);
  }

  VirtualClassroomContentState _mapNextLessonToState(
      NextLesson event, VirtualClassroomContentState state) {
    final currentLessonIndex = state.allLessonsInArray
        .indexWhere((element) => element.id == state.currentlyOpenedLesson);
    final nextLessonIndex = currentLessonIndex + 1;
    var nextLesson;
    try {
      nextLesson = state.allLessonsInArray[nextLessonIndex];
    } catch (e) {
      print("$e");
    }
    return state.copyWith(
        currentlyOpenedLesson: nextLesson != null ? nextLesson.id : null);
  }

  Stream<VirtualClassroomContentState> _mapClassroomContentTabChangeToState(
      ClassroomContentTabChanged event,
      VirtualClassroomContentState state) async* {
    yield state.copyWith(loading: true);
    final newState = state.copyWith(
        classroomContentTabIndex: event.index,
        selectedTagId: event.selectedTagId);
    yield newState;

    final selectedOrganization =
    await organizationRepository.getSelectedOrganization();
    // Here we get all grouped lessons
    List<SubjectLessons> groupedLessons =
        await subjectPlanTreeRepository.getSubjectPlanTreeByClassroomId(
            state.classroomEntity.id, state.tags[event.index].id, selectedOrganization);

    // Here we get all lessons from old api. We use this api te get lessons that not belong opened tab
    SubjectPlanTree subjectPlanTreeNotGrouped;
    List<Lessons> notGroupedLessons = [];
    List<Lessons> allLessonsInArray = [];
    Map<String, List<Lessons>> groupedLessonsByWeek = {};
    if (state.classroomEntity.subjectPlan != null) {
      subjectPlanTreeNotGrouped =
          await subjectPlanTreeRepository.getSubjectPlanTreeBySubjectPlanId(
              state.classroomEntity.subjectPlan.id);

      // Get ungrouped lessons.
      notGroupedLessons =
          _getLessonsWithoutGroup(groupedLessons, subjectPlanTreeNotGrouped);

      groupedLessonsByWeek =
          _groupLessonsByWeek(groupedLessons, notGroupedLessons);

      allLessonsInArray =
          _getAllLessonsInOneArray(groupedLessons, notGroupedLessons);
    }

    List<String> weeks = _getWeeks(groupedLessons);

    yield newState.copyWith(
        filteredLessonsGrouped: groupedLessonsByWeek,
        lessonsGroupedByWeek: groupedLessonsByWeek,
        loading: false,
        allLessonsInArray: allLessonsInArray,
        notGroupedLessons: notGroupedLessons,
        filters: weeks);
  }

}
