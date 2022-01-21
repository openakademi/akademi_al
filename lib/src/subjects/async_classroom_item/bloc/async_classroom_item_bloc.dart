import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/progress_lesson_enrollments.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_lessons.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/tags_async.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_entity.dart';
import 'package:akademi_al_mobile_app/packages/organization_repository/organization_repository.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/subject_plan_tree_repository/lib/subject_plan_tree_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'async_classroom_item_event.dart';

part 'async_classroom_item_state.dart';

class AsyncClassroomItemBloc
    extends Bloc<AsyncClassroomItemEvent, AsyncClassroomItemState> {
  AsyncClassroomItemBloc(
      {this.uploaderRepository,
      this.userRepository,
      this.classroomRepository,
      this.subjectPlanTreeRepository,
      this.enrollmentRepository,
      this.lessonRepository,
      this.authenticationRepository,
      this.progressLessonEnrollmentRepository,
      this.quizUserResponseRepository,
      this.organizationRepository,})
      : super(AsyncClassroomItemState());

  final UserRepository userRepository;
  final ClassroomRepository classroomRepository;
  final UploaderRepository uploaderRepository;
  final SubjectPlanTreeRepository subjectPlanTreeRepository;
  final EnrollmentRepository enrollmentRepository;
  final LessonRepository lessonRepository;
  final AuthenticationRepository authenticationRepository;
  final ProgressLessonEnrollmentRepository progressLessonEnrollmentRepository;
  final QuizUserResponseRepository quizUserResponseRepository;
  final OrganizationRepository organizationRepository;

  @override
  Stream<AsyncClassroomItemState> mapEventToState(
    AsyncClassroomItemEvent event,
  ) async* {
    if (event is LoadClassroom) {
      yield* _mapLoadClassroomToState(event, state);
    } else if (event is EnrollToClassroom) {
      yield* _mapEnrollToClassroomToState(event, state);
    } else if (event is ContinueClassroom) {
      yield* _mapContinueClassroomToState(event, state);
    } else if (event is LessonSelected) {
      yield* _mapLessonSelectedToState(event, state);
    } else if (event is EndLesson) {
      yield* _mapEndLessonToState(event, state);
    } else if (event is ClassroomContentTabChanged) {
      yield* _mapClassroomContentTabChangeToState(event, state);
    } else if(event is CloseOpenedClassroom){
      yield* _mapCloseOpenedClassroomToState(event, state);
    }
  }

  Stream<AsyncClassroomItemState> _mapLoadClassroomToState(
      LoadClassroom event, AsyncClassroomItemState state) async* {
    yield state.copyWith(loading: true);

    final ClassroomEntity classroomEntity =
        await classroomRepository.getClassroomById(event.classroomId);
    final UserEntity user = await userRepository.getUserEntity();
    final userEnrolled = user != null &&
        user.classrooms != null &&
        user.classrooms.firstWhere(
                (element) => element?.id == event?.classroomId,
                orElse: () => null) !=
            null;
    if (classroomEntity.file != null) {
      // final imageUrl = await uploaderRepository.getS3UrlForAction("${classroomEntity.file.filePath}/${classroomEntity.file.name}",  S3ActionType.DOWNLOAD);
    }
    List<TagsAsync> tags;
    if (classroomEntity.subjectPlan != null) {
      tags =
          await subjectPlanTreeRepository.getTagsAsyncOnly(classroomEntity.id);
    }
    final selectedOrganization =
    await organizationRepository.getSelectedOrganization();
    // Get all grouped lessons
    List<SubjectLessons> groupedLessons = [];
    if (classroomEntity.subjectPlan != null && tags != null) {
      groupedLessons = await subjectPlanTreeRepository
          .getSubjectPlanTreeByClassroomId(classroomEntity.id, tags[0].id, selectedOrganization);
    }

    // Get ungrouped lessons, here we use an old api
    SubjectPlanTree subjectPlanTreeNotGrouped;
    List<Lessons> notGroupedLessons = [];
    List<Lessons> allLessonsInArray = [];
    Map<String, List<Lessons>> lessonsGroupedByWeek = {};
    if (classroomEntity.subjectPlan != null) {
      subjectPlanTreeNotGrouped = await subjectPlanTreeRepository
          .getSubjectPlanTreeBySubjectPlanId(classroomEntity.subjectPlan.id);
      notGroupedLessons =
          _getLessonsWithoutGroup(groupedLessons, subjectPlanTreeNotGrouped);
      lessonsGroupedByWeek =
          _groupLessonsByWeek(groupedLessons, notGroupedLessons);
      allLessonsInArray =
          _getAllLessonsInOneArray(groupedLessons, notGroupedLessons);
    }

    // List<Lessons> lessons = _retrieveLessonsFroMTree(subjectPlanTree);
    // Map<String, List<Lessons>> groupedByWeekNotSorted = _groupByWeek(lessons);
    // final Map<String, List<Lessons>> groupedByWeek = {};
    // groupedByWeekNotSorted?.forEach((key, value) {
    //   var nonQuizzes =
    //       value.where((element) => element.lessonType != "QUIZ").toList();
    //   var quizzes =
    //       value.where((element) => element.lessonType == "QUIZ").toList();
    //   nonQuizzes.sort((a, b) {
    //     final aEndDate =
    //         a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
    //     final bEndDate =
    //         b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
    //     return aEndDate.compareTo(bEndDate);
    //   });
    //   quizzes.sort((a, b) {
    //     final aEndDate =
    //         a.endDate != null ? DateTime.tryParse(a.endDate) : DateTime.now();
    //     final bEndDate =
    //         b.endDate != null ? DateTime.tryParse(b.endDate) : DateTime.now();
    //     return aEndDate.compareTo(bEndDate);
    //   });
    //   groupedByWeek[key] = [...nonQuizzes, ...quizzes];
    // });

    bool transformToChapters = classroomEntity.gradeSubject != null &&
        classroomEntity.gradeSubject.grade != null &&
        classroomEntity.gradeSubject.grade.level == "PRESCHOOL" &&
        classroomEntity.isAsync;
    final classroomEnrolled = userEnrolled
        ? user.classrooms.firstWhere(
            (element) => element?.id == event?.classroomId,
            orElse: () => null)
        : null;
    EnrollmentEntity enrollmentEntity;
    if (classroomEnrolled?.enrollment != null) {
      enrollmentEntity = await enrollmentRepository
          .getEnrollmentById(classroomEnrolled.enrollment.id);
    }

    if (classroomEntity.file != null) {
      final url = await uploaderRepository.getS3UrlForAction(
          "${classroomEntity.file.filePath}/${classroomEntity.file.name}",
          S3ActionType.DOWNLOAD);
      classroomEntity.fileUrl = url;
    }

    Lessons selectedLesson;
    var quizResponses;
    if (event.lessonId != null) {
      selectedLesson = await lessonRepository.getLessonById(event.lessonId);

      if (selectedLesson.lessonType == "QUIZ") {
        try {
          quizResponses = await quizUserResponseRepository
              .getQuizAnswersForUserIdLessonId(selectedLesson.id);
        } catch (e) {
          print("$e");
        }
      }
    }

    // Sort lessons
    // if (groupedLessons != null) {
    //   groupedLessons.forEach((element) {
    //     element.classroomTags[0].lessonClassroomTag.sort((a, b) {
    //       return a.priority.compareTo(b.priority);
    //     });
    //   });
    // }

    yield state.copyWith(
        classroomEntity: classroomEntity,
        userEntity: user,
        userEnrolled: userEnrolled,
        loading: false,
        subjectPlanTree: groupedLessons,
        allLessonsInArray: allLessonsInArray,
        transformToChapters: transformToChapters,
        enrollmentEntity: enrollmentEntity,
        isPreview: event.lessonId == null,
        nextUnwatchedVideo: event.lessonId,
        quizAnswers: quizResponses,
        selectedLesson: selectedLesson,
        tags: tags,
        notGroupedLessons: notGroupedLessons,
        lessonsGroupedByWeek: lessonsGroupedByWeek,
        filteredLessonsGrouped: lessonsGroupedByWeek,
        lessonsFinished:
            enrollmentEntity != null ? enrollmentEntity.lessons : List(),
        submitting: false);
  }

  Stream<AsyncClassroomItemState> _mapEnrollToClassroomToState(
      EnrollToClassroom event, AsyncClassroomItemState state) async* {
    yield state.copyWith(submitting: true);

    final enrollment =
        await enrollmentRepository.createEnrollment(state.classroomEntity.id);
    final nextUnwatchedVideoId =
        _getNextUnwatchedVideo(state, state.lessonsFinished);
    final selectedLesson =
        await lessonRepository.getLessonById(nextUnwatchedVideoId);

    var quizResponses;
    if (selectedLesson.lessonType == "QUIZ") {
      try {
        quizResponses = await quizUserResponseRepository
            .getQuizAnswersForUserIdLessonId(selectedLesson.id);
      } catch (e) {
        print("$e");
      }
    }

    yield state.copyWith(
        enrollmentEntity: enrollment,
        userEnrolled: true,
        isPreview: false,
        nextUnwatchedVideo: nextUnwatchedVideoId,
        selectedLesson: selectedLesson,
        quizAnswers: quizResponses,
        submitting: false);
  }

  Stream<AsyncClassroomItemState> _mapContinueClassroomToState(
      ContinueClassroom event, AsyncClassroomItemState state) async* {
    yield state.copyWith(submitting: true);

    final nextUnwatchedVideoId =
        _getNextUnwatchedVideo(state, state.lessonsFinished);

    var selectedLesson;
    var quizResponses;
    if (nextUnwatchedVideoId != null) {
      selectedLesson =
          await lessonRepository.getLessonById(nextUnwatchedVideoId);
      if (selectedLesson.lessonType == "QUIZ") {
        try {
          quizResponses = await quizUserResponseRepository
              .getQuizAnswersForUserIdLessonId(selectedLesson.id);
        } catch (e) {
          print("$e");
        }
      }
    }

    yield state.copyWith(
        isPreview: false,
        nextUnwatchedVideo: nextUnwatchedVideoId,
        selectedLesson: selectedLesson,
        quizAnswers: quizResponses,
        submitting: false);
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

  String _getNextUnwatchedVideo(
      AsyncClassroomItemState state, List<Lessons> lessonsFinished) {
    if (lessonsFinished == null ||
        (lessonsFinished != null && lessonsFinished.length == 0)) {
      return state.allLessonsInArray?.first?.id;
    }

    final lessons = state.allLessonsInArray;

    final lessonFound = lessons.indexWhere((element) {
      bool result = lessonsFinished.any((element1) => element1.id == element.id);
      if (result) {
        return false;
      }
      return true;
    });
    final nextLesson = lessonFound > -1 && lessonFound == lessons.length - 1 ? 0 : lessonFound;
    return (lessons != null && lessons.length > 0
                ? lessons[nextLesson].id
                : null) !=
            null
        ? lessons[nextLesson].id
        : lessons.first.id;
  }


  Stream<AsyncClassroomItemState> _mapLessonSelectedToState(
      LessonSelected event, AsyncClassroomItemState state) async* {
    //yield state.copyWith(changingItem: true);
    final selectedLesson = await lessonRepository.getLessonById(event.lessonId);

    var quizResponses;
    if (selectedLesson.lessonType == "QUIZ") {
      try {
        quizResponses = await quizUserResponseRepository
            .getQuizAnswersForUserIdLessonId(selectedLesson.id);
      } catch (e) {
        print("$e");
      }
    }

    yield state.copyWith(
        selectedLesson: selectedLesson,
        nextUnwatchedVideo: event.lessonId,
        quizAnswers: quizResponses,
        changingItem: false
    );
  }

  Stream<AsyncClassroomItemState> _mapEndLessonToState(
      EndLesson event, AsyncClassroomItemState state) async* {
    yield state.copyWith(submitting: true);
    final userId = await authenticationRepository.getCurrentUserId();
    var enrollmentId;
    if (state.enrollmentEntity != null) {
      enrollmentId = state.enrollmentEntity?.id;
    }
    final progressLessonEnrollmentsDto = ProgressLessonEnrollmentsDto(
        id: Uuid().v4().toString(),
        lessonId: state.selectedLesson.id,
        enrollmentId: enrollmentId,
        updatedBy: userId,
        createdBy: userId);

    if (enrollmentId != null) {
      await progressLessonEnrollmentRepository
          .createProgressLessonEnrollment(progressLessonEnrollmentsDto);
    }
    final UserEntity user = await userRepository.getUserEntity();
    final userEnrolled = user != null &&
        user.classrooms != null &&
        user.classrooms.firstWhere(
                (element) => element?.id == state.classroomEntity.id,
                orElse: () => null) !=
            null;
    EnrollmentEntity enrollmentEntity;
    final classroomEnrolled = userEnrolled
        ? user.classrooms.firstWhere(
            (element) => element?.id == state.classroomEntity.id,
            orElse: () => null)
        : null;
    if (classroomEnrolled?.enrollment != null) {
      enrollmentEntity = await enrollmentRepository
          .getEnrollmentById(classroomEnrolled.enrollment.id);
    }

    final nextLessonId = _getNextUnwatchedVideo(
        state, enrollmentEntity != null ? enrollmentEntity.lessons : []);

    final selectedLesson = await lessonRepository.getLessonById(nextLessonId);
    var quizResponses;
    if (selectedLesson.lessonType == "QUIZ") {
      try {
        quizResponses = await quizUserResponseRepository
            .getQuizAnswersForUserIdLessonId(selectedLesson.id);
      } catch (e) {
        print("$e");
      }
    }
    yield state.copyWith(
        nextUnwatchedVideo: nextLessonId,
        selectedLesson: selectedLesson,
        lessonsFinished:
            enrollmentEntity != null ? enrollmentEntity.lessons : [],
        quizAnswers: quizResponses,
        submitting: false);
  }

  Stream<AsyncClassroomItemState> _mapClassroomContentTabChangeToState(
      ClassroomContentTabChanged event, AsyncClassroomItemState state) async* {
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

    yield newState.copyWith(
      filteredLessonsGrouped: groupedLessonsByWeek,
      lessonsGroupedByWeek: groupedLessonsByWeek,
      loading: false,
      allLessonsInArray: allLessonsInArray,
      notGroupedLessons: notGroupedLessons,
    );
  }

  Stream<AsyncClassroomItemState> _mapCloseOpenedClassroomToState(
      CloseOpenedClassroom event, AsyncClassroomItemState state) async* {
    yield state.copyWith(isPreview: true, selectedLesson: null,);
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
}
