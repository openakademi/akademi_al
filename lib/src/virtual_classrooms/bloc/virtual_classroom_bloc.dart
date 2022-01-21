import 'dart:async';

import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_not_async.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';

part 'virtual_classroom_event.dart';

part 'virtual_classroom_state.dart';

class VirtualClassroomBloc
    extends Bloc<VirtualClassroomEvent, VirtualClassroomState> {
  VirtualClassroomBloc({
    this.classroomRepository,
    this.userRepository,
    this.enrollmentRepository,
    this.subjectPlanTreeRepository,
    this.organizationRepository,
  }) : super(VirtualClassroomState());

  final ClassroomRepository classroomRepository;
  final UserRepository userRepository;
  final EnrollmentRepository enrollmentRepository;
  final SubjectPlanTreeRepository subjectPlanTreeRepository;
  final OrganizationRepository organizationRepository;

  @override
  Stream<VirtualClassroomState> mapEventToState(
    VirtualClassroomEvent event,
  ) async* {
    if (event is VirtualClassroomOpened) {
      yield* _mapVirtualClassroomOpenedToState(event, state);
    } else if (event is VirtualClassroomPageChanged) {
      yield _mapVirtualClassroomPageChangedToState(event, state);
    } else if (event is LessonChangedEvent) {
      yield _mapLessonChangedEventToState(event, state);
    } else if (event is NextLessonEvent) {
      yield _mapNextLessonEventToState(event, state);
    } else if (event is ReloadSubjectPlanTreeEvent) {
      yield* _mapReloadSubjectPlanTreeEventToState(event, state);
    }
  }

  Stream<VirtualClassroomState> _mapVirtualClassroomOpenedToState(
      VirtualClassroomOpened event, VirtualClassroomState state) async* {
    final newState = state.copyWith(
        loading: true,
        selectedVirtualClassroomId: event.selectedVirtualClassroomId,
        virtualClassroomPageIndex: 0,
        selectedEnrollment: event.enrollmentEntity);
    yield newState;

    final ClassroomEntity classroomEntity = await classroomRepository
        .getClassroomById(event.selectedVirtualClassroomId);
    final UserEntity user = await userRepository.getUserEntity();
    final userEnrolled = user != null &&
        user.classrooms != null &&
        user.classrooms.firstWhere(
                (element) => element?.id == event?.selectedVirtualClassroomId,
                orElse: () => null) !=
            null;
    final pupilsEnrollments = await enrollmentRepository
        .getAllEnrollmentsByClassroomId(event.selectedVirtualClassroomId);
    if (classroomEntity.file != null) {
      // final imageUrl = await uploaderRepository.getS3UrlForAction("${classroomEntity.file.filePath}/${classroomEntity.file.name}",  S3ActionType.DOWNLOAD);
    }

    final classroomEnrolled = userEnrolled
        ? user.classrooms.firstWhere(
            (element) => element?.id == event?.selectedVirtualClassroomId,
            orElse: () => null)
        : null;

    EnrollmentEntity enrollmentEntity;
    enrollmentEntity = await enrollmentRepository
        .getEnrollmentById(classroomEnrolled.enrollment.id);

    List<TagsNotAsync> tags;
    if (classroomEntity.subjectPlan != null) {
      tags = await subjectPlanTreeRepository.getTagsNotAsyncOnly();
    }

    final selectedOrganization =
    await organizationRepository.getSelectedOrganization();

    // Get all grouped lessons
    List<SubjectLessons> groupedLessons = [];
    if (classroomEntity.subjectPlan != null && tags != null) {
      //String selectedTagId = state.selectedTagId != null ? state.selectedTagId : tags[0].id;
      groupedLessons = await subjectPlanTreeRepository
          .getSubjectPlanTreeByClassroomId(classroomEntity.id, tags[0].id, selectedOrganization);
    }

    // Get ungrouped lessons, here we use an old api
    SubjectPlanTree subjectPlanTreeNotGrouped;
    List<Lessons> notGroupedLessons = [];
    List<Lessons> allLessonsInArray = [];
    Map<String, List<Lessons>> groupedLessonsByWeek = {};
    if (classroomEntity.subjectPlan != null) {
      subjectPlanTreeNotGrouped = await subjectPlanTreeRepository
          .getSubjectPlanTreeBySubjectPlanId(classroomEntity.subjectPlan.id);
      notGroupedLessons = _getLessonsWithoutGroup(groupedLessons, subjectPlanTreeNotGrouped);
      groupedLessonsByWeek= _groupLessonsByWeek(groupedLessons, notGroupedLessons);
      allLessonsInArray = _getAllLessonsInOneArray(groupedLessons, notGroupedLessons);
    }
    

    yield newState.copyWith(
        classroomEntity: classroomEntity,
        loading: false,
        pupils: pupilsEnrollments,
        virtualClassroomPageIndex: 0,
        tags: tags,
        lessonsGroupedByWeek: groupedLessonsByWeek,
        allLessonsInArray: allLessonsInArray,
        enrollmentEntity: enrollmentEntity,
        currentlyOpenedLesson: event.lessonToOpen);
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

    List<Lessons> assignments = _lessons
        .where((element) => element.lessonType == "ASSIGNMENT")
        .toList();

    assignments.sort((a, b) {
      final aEndDate =
      a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
      final bEndDate =
      b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
      return aEndDate.compareTo(bEndDate);
    });
    return assignments;
  }

  _getLessonsWithoutGroup(List<SubjectLessons> subjectPlanTree,
      SubjectPlanTree subjectPlanTreeNotGrouped) {
    List<String> groupedLessonsId = [];
    if(subjectPlanTree == null) return null;
    subjectPlanTree.forEach((element) {
      element.classroomTags[0].lessonClassroomTag.forEach((el) {
        groupedLessonsId.add(el.lesson.id);
      });
    });

    final notGroupedLessons = subjectPlanTreeNotGrouped.lessons
        .where((element) => !groupedLessonsId.contains(element.id))
        .toList();

    notGroupedLessons.sort((a,b) => b.createdAt.compareTo(a.createdAt));

    return notGroupedLessons;
  }

  Map<String, List<Lessons>> _groupLessonsByWeek(List<SubjectLessons> lessons, List<Lessons> notGroupedLessons) {
    if (lessons == null) return null;
    Map<String, List<Lessons>> map = {};

    if(notGroupedLessons != null && notGroupedLessons.length != 0){
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


  VirtualClassroomState _mapVirtualClassroomPageChangedToState(
      VirtualClassroomPageChanged event, VirtualClassroomState state) {
    if(event.index == 0){
      // We get all lessons each time we go to "Kreu"
      add(VirtualClassroomOpened(state.selectedVirtualClassroomId, state.enrollmentEntity, null));
    }
    return state.copyWith(virtualClassroomPageIndex: event.index);
  }


  VirtualClassroomState _mapLessonChangedEventToState(
      LessonChangedEvent event, VirtualClassroomState state) {
    return state.copyWith(currentlyOpenedLesson: event.lessonId);
  }


  VirtualClassroomState _mapNextLessonEventToState(
      NextLessonEvent event, VirtualClassroomState state) {
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

  Stream<VirtualClassroomState> _mapReloadSubjectPlanTreeEventToState(
      ReloadSubjectPlanTreeEvent event, VirtualClassroomState state) async* {
    yield state.copyWith(loading: true);
    final enrollmentEntity =
        await enrollmentRepository.getEnrollmentById(state.enrollmentEntity.id);
    yield state.copyWith(
      loading: false,
      enrollmentEntity: enrollmentEntity,
    );
  }

}
