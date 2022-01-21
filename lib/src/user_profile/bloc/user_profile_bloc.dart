import 'dart:async';

import 'package:akademi_al_mobile_app/packages/analytics_course_progress/lib/analytics_course_progress_api_provider.dart';
import 'package:akademi_al_mobile_app/packages/authentication_repository/lib/authentication_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/async_subjects/async_courses_progress.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user.dart';
import 'package:akademi_al_mobile_app/packages/models/user/user_avatar_entity.dart';
import 'package:akademi_al_mobile_app/packages/uploader_repository/lib/uploader_repository.dart';
import 'package:akademi_al_mobile_app/packages/user_settings_repository/lib/user_settings_api_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'user_profile_event.dart';

part 'user_profile_state.dart';

class UserProfileBloc extends Bloc<UserProfileEvent, UserProfileState> {
  UserProfileBloc({this.authenticationRepository,
    this.userSettingsApiProvider,
    this.analyticsCourseProgressApiProvider,
    this.uploaderRepository})
      : super(UserProfileState());

  final AuthenticationRepository authenticationRepository;
  final UserSettingsApiProvider userSettingsApiProvider;
  final AnalyticsCourseProgressApiProvider analyticsCourseProgressApiProvider;
  final UploaderRepository uploaderRepository;

  @override
  Stream<UserProfileState> mapEventToState(UserProfileEvent event,) async* {
    if (event is LoadUserProfile) {
      yield* _mapLoadUserProfileToState(event, state);
    }
  }

  Stream<UserProfileState> _mapLoadUserProfileToState(LoadUserProfile event,
      UserProfileState state) async* {
    yield state.copyWith(loading: true);

    final userId = await authenticationRepository.getCurrentUserId();
    final user = await authenticationRepository.getCurrentUser();

    final UserAvatarEntity userAvatarEntityReponse =
    await userSettingsApiProvider.getAvatar(userId);

    if (userAvatarEntityReponse != null &&
        userAvatarEntityReponse.profilePictureType != "static") {
      UploaderRepository uploaderRepository =
      new UploaderRepository(authenticationRepository);
      var s3FilePath = await uploaderRepository.getS3UrlForAction(
          "${userAvatarEntityReponse.profilePictureFile
              .filePath}/${userAvatarEntityReponse.profilePictureFile.name}",
          S3ActionType.DOWNLOAD);
      userAvatarEntityReponse.fileUrl = s3FilePath;
    }
    final newState = state.copyWith(
      loading: false,
      userAvatarEntity: userAvatarEntityReponse,
      userEntity: user,
    );
    yield newState;

    List<AsyncCoursesProgress> asyncCoursesProgress =
    await analyticsCourseProgressApiProvider.getAsyncCoursesProgress();

    if (asyncCoursesProgress.length > 0) {
      var allCompetedCourses = 0;

      List<AsyncCoursesProgress> asyncCoursesProgressWithScores =
      asyncCoursesProgress.map((element) {
        allCompetedCourses =
            allCompetedCourses + element.videos + element.quizes;

        if (element.lessons > 0) {
          final score = element.finishedItems / element.lessons;
          element.score = score;
        }
        return element;
      }).toList();

      asyncCoursesProgressWithScores.sort((a, b) {
        return a.score >= b.score ? -1 : 1;
      });

      final maxScore = asyncCoursesProgressWithScores[0].score;
      List<AsyncCoursesProgress> coursesWithConvertedScore =
      asyncCoursesProgressWithScores
          .map((e) {
        var calculatedScore = 0.0;
        if (maxScore > 0) {
          calculatedScore =
          e.score == maxScore ? 5.0 : (5.0 * e.score) / maxScore;
        }
        e.calculatedScore = calculatedScore;
        return e;
      })
          .where((e) => e.calculatedScore > 0)
          .toList();

      coursesWithConvertedScore.sort((a, b) {
        return a.calculatedScore >= b.calculatedScore ? -1 : 1;
      });
      yield newState.copyWith(
        loading: false,
        asyncCoursesProgress: coursesWithConvertedScore,
        allCompletedCourses: allCompetedCourses,
      );
    }
  }
}
