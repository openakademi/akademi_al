part of 'async_classroom_item_bloc.dart';

class AsyncClassroomItemState extends Equatable {
  const AsyncClassroomItemState(
      {this.classroomEntity,
      this.userEntity,
      this.userEnrolled,
      this.loading = true,
      this.subjectPlanTree,
      this.lessonsGroupedByWeek,
      this.allLessonsInArray,
      this.chapters,
      this.transformToChapters,
      this.lessonsFinished,
      this.isPreview = true,
      this.nextUnwatchedVideo,
      this.selectedLesson,
      this.enrollmentEntity,
      this.quizAnswers,
      this.submitting = false,
      this.changingItem,
      this.tags,
      this.classroomContentTabIndex = 0,
      this.notGroupedLessons,
      this.filteredLessonsGrouped,
      this.selectedTagId});

  final ClassroomEntity classroomEntity;
  final UserEntity userEntity;
  final bool userEnrolled;
  final bool loading;
  final List<SubjectLessons> subjectPlanTree;
  final Map<String, List<Lessons>> lessonsGroupedByWeek;
  final List<Lessons> allLessonsInArray;
  final List<SubjectPlanTree> chapters;
  final bool transformToChapters;
  final List<Lessons> lessonsFinished;
  final bool isPreview;
  final String nextUnwatchedVideo;
  final Lessons selectedLesson;
  final EnrollmentEntity enrollmentEntity;
  final QuizAnswers quizAnswers;
  final bool submitting;
  final bool changingItem;
  final List<TagsAsync> tags;
  final int classroomContentTabIndex;
  final List<Lessons> notGroupedLessons;
  final Map<String, List<Lessons>> filteredLessonsGrouped;
  final String selectedTagId;

  AsyncClassroomItemState copyWith(
      {ClassroomEntity classroomEntity,
      UserEntity userEntity,
      bool userEnrolled,
      bool loading,
      List<SubjectLessons> subjectPlanTree,
      Map<String, List<Lessons>> lessonsGroupedByWeek,
      List<Lessons> allLessonsInArray,
      List<SubjectPlanTree> chapters,
      List<Lessons> lessonsFinished,
      bool transformToChapters,
      bool isPreview,
      String nextUnwatchedVideo,
      EnrollmentEntity enrollmentEntity,
      Lessons selectedLesson,
      QuizAnswers quizAnswers,
      bool submitting,
      bool changingItem,
      List<TagsAsync> tags,
      int classroomContentTabIndex,
      List<Lessons> notGroupedLessons,
      Map<String, List<Lessons>> filteredLessonsGrouped,
      String selectedTagId}) {
    return new AsyncClassroomItemState(
      classroomEntity: classroomEntity ?? this.classroomEntity,
      userEntity: userEntity ?? this.userEntity,
      userEnrolled: userEnrolled ?? this.userEnrolled,
      loading: loading ?? this.loading,
      subjectPlanTree: subjectPlanTree ?? this.subjectPlanTree,
      lessonsGroupedByWeek: lessonsGroupedByWeek ?? this.lessonsGroupedByWeek,
      allLessonsInArray: allLessonsInArray ?? this.allLessonsInArray,
      chapters: chapters ?? this.chapters,
      transformToChapters: transformToChapters ?? this.transformToChapters,
      lessonsFinished: lessonsFinished ?? this.lessonsFinished,
      isPreview: isPreview ?? this.isPreview,
      nextUnwatchedVideo: nextUnwatchedVideo ?? this.nextUnwatchedVideo,
      selectedLesson: selectedLesson ?? this.selectedLesson,
      enrollmentEntity: enrollmentEntity ?? this.enrollmentEntity,
      quizAnswers: quizAnswers,
      submitting: submitting ?? this.submitting,
      changingItem: changingItem ?? this.changingItem,
      tags: tags ?? this.tags,
      classroomContentTabIndex: classroomContentTabIndex ?? this.classroomContentTabIndex,
      notGroupedLessons: notGroupedLessons ?? this.notGroupedLessons,
      filteredLessonsGrouped: filteredLessonsGrouped ?? this.filteredLessonsGrouped,
      selectedTagId: selectedTagId ?? this.selectedTagId
    );
  }

  @override
  List<Object> get props => [
        classroomEntity,
        userEntity,
        userEnrolled,
        loading,
        subjectPlanTree,
        lessonsGroupedByWeek,
        allLessonsInArray,
        chapters,
        transformToChapters,
        lessonsFinished,
        isPreview,
        nextUnwatchedVideo,
        selectedLesson,
        enrollmentEntity,
        quizAnswers,
        submitting,
        changingItem,
        tags,
        classroomContentTabIndex,
        notGroupedLessons,
        filteredLessonsGrouped,
        selectedTagId
      ];
}
