part of 'user_profile_bloc.dart';

class UserProfileState extends Equatable {
  const UserProfileState({this.userAvatarEntity, this.userEntity, this.loading, this.asyncCoursesProgress, this.allCompletedCourses});

  final UserAvatarEntity userAvatarEntity;
  final User userEntity;
  final bool loading;
  final List<AsyncCoursesProgress> asyncCoursesProgress;
  final int allCompletedCourses;

  UserProfileState copyWith({
    UserAvatarEntity userAvatarEntity,
    User userEntity,
    bool loading,
    List<AsyncCoursesProgress> asyncCoursesProgress,
    int allCompletedCourses
  }) {
    return new UserProfileState(
      userAvatarEntity: userAvatarEntity ?? this.userAvatarEntity,
      userEntity: userEntity ?? this.userEntity,
      loading: loading ?? this.loading,
      asyncCoursesProgress: asyncCoursesProgress ?? this.asyncCoursesProgress,
      allCompletedCourses: allCompletedCourses ?? this.allCompletedCourses,
    );
  }

  @override
  List<Object> get props => [userAvatarEntity, userEntity, loading, asyncCoursesProgress, allCompletedCourses];
}
