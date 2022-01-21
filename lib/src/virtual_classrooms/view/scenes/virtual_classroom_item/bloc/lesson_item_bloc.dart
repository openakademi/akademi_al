import 'dart:async';

import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/lesson_repository/lib/lesson_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/file_entity.dart' as FileEntity;
import 'package:akademi_al_mobile_app/packages/models/async_subjects/progress_lesson_enrollments.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/quiz_answers_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/subject_plan_tree.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/classroom/create_assignment_user_commit.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/progress_lesson_enrollments_repository/lib/progress_lesson_enrollments_repository.dart';
import 'package:akademi_al_mobile_app/packages/quiz_user_response_repository/lib/quiz_user_response_repository.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_commits/user_commits_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'lesson_item_event.dart';

part 'lesson_item_state.dart';

class LessonItemBloc extends Bloc<LessonItemEvent, LessonItemState> {
  LessonItemBloc(
      {this.lessonRepository,
      this.quizUserResponseRepository,
      this.uploaderRepository,
      this.progressLessonEnrollmentRepository,
      this.authenticationRepository,
      this.userCommitsRepository,
      this.userRepository,})
      : super(LessonItemState());
  final LessonRepository lessonRepository;
  final QuizUserResponseRepository quizUserResponseRepository;
  final UploaderRepository uploaderRepository;
  final ProgressLessonEnrollmentRepository progressLessonEnrollmentRepository;
  final AuthenticationRepository authenticationRepository;
  final UserCommitsRepository userCommitsRepository;
  final UserRepository userRepository;

  @override
  Stream<LessonItemState> mapEventToState(
    LessonItemEvent event,
  ) async* {
    if (event is LoadLesson) {
      yield* _mapLoadLessonToState(event, state);
    } else if (event is EndLesson) {
      yield* _mapEndLessonToState(event, state);
    } else if (event is NewAssignmentUserCommit) {
      yield _mapNewAssignmentUserCommitToState(event, state);
    } else if (event is SaveVideoLessonLocally) {
      yield* _mapSaveVideoLessonLocallyToState(event, state);
    }
  }

  Stream<LessonItemState> _mapLoadLessonToState(
      LoadLesson event, LessonItemState state) async* {
    yield state.copyWith(loading: true);
    final userId = (await userRepository.getUserEntity()).id;
    final selectedLesson = await lessonRepository.getLessonById(event.lessonId);
    final localLesson = await lessonRepository.getLocallySavedLessonById(event.lessonId);
    if(localLesson != null) {
      selectedLesson.localVideoUrls = localLesson.localVideoUrls != null ? localLesson.localVideoUrls : [];
    }
    selectedLesson.userId = userId;

    var quizResponses;
    if (selectedLesson.lessonType == "QUIZ") {
      try {
        quizResponses = await quizUserResponseRepository
            .getQuizAnswersForUserIdLessonId(selectedLesson.id);
      } catch (e) {
        print("$e");
      }
    }
    AssignmentUserCommit assignmentUserCommit;
    if (selectedLesson.lessonType == "ASSIGNMENT") {
      try {
        assignmentUserCommit = await userCommitsRepository
            .getAssignmentUserCommitByUserIdLessonId(selectedLesson.id);
      } catch (e) {
        print("$e");
      }
    }
    final finishedLesson = event.enrollmentEntity.lessons.firstWhere(
        (element) => element.id == selectedLesson.id,
        orElse: () => null);
    yield state.copyWith(
        lessonEntity: selectedLesson,
        answers: quizResponses,
        enrollmentEntity: event.enrollmentEntity,
        lessonDone: finishedLesson != null,
        assignmentUserCommit: assignmentUserCommit,
        classroomEntity: event.classroomEntity,
        loading: false);
  }

  Stream<LessonItemState> _mapEndLessonToState(
      EndLesson event, LessonItemState state) async* {
    yield state.copyWith(submitting: true);
    final userId = await authenticationRepository.getCurrentUserId();
    var enrollmentId;

    if (state.enrollmentEntity != null) {
      enrollmentId = state.enrollmentEntity?.id;
    }

    final progressLessonEnrollmentsDto = ProgressLessonEnrollmentsDto(
        id: Uuid().v4().toString(),
        lessonId: state.lessonEntity.id,
        enrollmentId: enrollmentId,
        updatedBy: userId,
        createdBy: userId);

    if (enrollmentId != null) {
      await progressLessonEnrollmentRepository
          .createProgressLessonEnrollment(progressLessonEnrollmentsDto);
    }

    var quizResponses;
    if (state.lessonEntity.lessonType == "QUIZ") {
      try {
        quizResponses = await quizUserResponseRepository
            .getQuizAnswersForUserIdLessonId(state.lessonEntity.id);
      } catch (e) {
        print("$e");
      }
    }

    var savedAssignmentUserCommit;
    if (state.lessonEntity.lessonType == "ASSIGNMENT") {
      final assignmentUserCommit = state.assignmentUserCommit;
      List<AssignmentUserCommitFile> newFileList = [];

      if (assignmentUserCommit != null &&
          assignmentUserCommit.assignmentUserCommitFiles != null) {
        newFileList = assignmentUserCommit.assignmentUserCommitFiles
            .map((e) => AssignmentUserCommitFile(
                id: Uuid().v4().toString(),
                file: FileEntity.File(
                    id: Uuid().v4().toString(),
                    createdBy: userId,
                    updatedBy: userId,
                    name: e.file.name,
                    filePath: e.file.filePath,
                    contentType: e.file.contentType,
                    size: e.file.size)))
            .toList();
      }

      try {
        final newAssignmentUserCommit = AssignmentUserCommit(
            id: Uuid().v4().toString(),
            userId: userId,
            description: "",
            isCommitted: true,
            isEvaluated: false,
            lessonId: state.lessonEntity.id,
            assignmentUserCommitFiles: newFileList);

        savedAssignmentUserCommit = await userCommitsRepository
            .createAssignmentUserCommit(newAssignmentUserCommit);
      } catch (e) {
        print("$e");
      }
    }
    yield state.copyWith(
        submitting: false,
        answers: quizResponses,
        lessonDone: true,
        assignmentUserCommit: savedAssignmentUserCommit);
  }

  LessonItemState _mapNewAssignmentUserCommitToState(
      NewAssignmentUserCommit event, LessonItemState state) {
    return state.copyWith(assignmentUserCommit: event.assignmentUserCommit);
  }

  Stream<LessonItemState> _mapSaveVideoLessonLocallyToState(SaveVideoLessonLocally event, LessonItemState state) async*{
    yield state.copyWith(loading: true);
    final lesson = state.lessonEntity;
   // final userId = (await userRepository.getUserEntity()).id;
    lesson.localVideoUrl = event.localUrl;
    lesson.localVideoUrls.add(state.lessonEntity.userId);
    lesson.classroomName = state.classroomEntity.name;
    // lesson.userId = userId;
    await lessonRepository.saveLocalLesson(lesson);
    yield state.copyWith(loading: false, lessonEntity: lesson);
  }
}
