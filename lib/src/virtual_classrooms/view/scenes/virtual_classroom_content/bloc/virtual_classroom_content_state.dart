part of 'virtual_classroom_content_bloc.dart';

class VirtualClassroomContentState extends Equatable {
  const VirtualClassroomContentState(
      {this.lessonsGroupedByWeek,
      this.chapters,
      this.nextUnwatchedVideo,
      this.selectedLesson,
      this.transformToChapters,
      this.lessonsFinished,
      this.enrollmentEntity,
      this.classroomEntity,
      this.groupedLessons,
      this.notGroupedLessons,
      this.allLessonsInArray,
      this.tags,
      this.loading,
      this.filters,
      this.filteredLessonsGrouped,
      this.filteredWeeks,
      this.currentlyOpenedLesson,
      this.classroomContentTabIndex = 0,
      this.selectedTagId});

  final ClassroomEntity classroomEntity;
  final List<SubjectLessons> groupedLessons;
  final List<Lessons> notGroupedLessons;
  final List<Lessons> allLessonsInArray;
  final List<TagsNotAsync> tags;
  final bool loading;
  final Map<String, List<Lessons>> lessonsGroupedByWeek;
  final Map<String, List<Lessons>> filteredLessonsGrouped;
  final List<SubjectPlanTree> chapters;
  final String nextUnwatchedVideo;
  final Lessons selectedLesson;
  final bool transformToChapters;
  final List<Lessons> lessonsFinished;
  final EnrollmentEntity enrollmentEntity;
  final List<String> filters;
  final List<String> filteredWeeks;
  final String currentlyOpenedLesson;
  final int classroomContentTabIndex;
  final String selectedTagId;

  VirtualClassroomContentState copyWith(
      {ClassroomEntity classroomEntity,
      List<SubjectLessons> groupedLessons,
      List<Lessons> notGroupedLessons,
      List<Lessons> allLessonsInArray,
      List<TagsNotAsync> tags,
      bool loading,
      Map<String, List<Lessons>> lessonsGroupedByWeek,
      Map<String, List<Lessons>> filteredLessonsGrouped,
      List<SubjectPlanTree> chapters,
      String nextUnwatchedVideo,
      Lessons selectedLesson,
      bool transformToChapters,
      List<Lessons> lessonsFinished,
      EnrollmentEntity enrollmentEntity,
      List<String> filters,
      List<String> filteredWeeks,
      String currentlyOpenedLesson,
      int classroomContentTabIndex,
      String selectedTagId}) {
    return new VirtualClassroomContentState(
      classroomEntity: classroomEntity ?? this.classroomEntity,
      groupedLessons: groupedLessons ?? this.groupedLessons,
      notGroupedLessons: notGroupedLessons ?? this.notGroupedLessons,
      allLessonsInArray: allLessonsInArray ?? this.allLessonsInArray,
      tags: tags ?? this.tags,
      loading: loading ?? this.loading,
      lessonsGroupedByWeek: lessonsGroupedByWeek ?? this.lessonsGroupedByWeek,
      filteredLessonsGrouped: filteredLessonsGrouped ?? this.filteredLessonsGrouped,
      chapters: chapters ?? this.chapters,
      nextUnwatchedVideo: nextUnwatchedVideo ?? this.nextUnwatchedVideo,
      selectedLesson: selectedLesson ?? this.selectedLesson,
      transformToChapters: transformToChapters ?? this.transformToChapters,
      lessonsFinished: lessonsFinished ?? this.lessonsFinished,
      enrollmentEntity: enrollmentEntity ?? this.enrollmentEntity,
      filters: filters ?? this.filters,
      currentlyOpenedLesson:
          currentlyOpenedLesson ?? this.currentlyOpenedLesson,
      filteredWeeks: filteredWeeks,
      classroomContentTabIndex: classroomContentTabIndex ?? this.classroomContentTabIndex,
      selectedTagId: selectedTagId ?? this.selectedTagId
    );
  }

  @override
  List<Object> get props => [
        classroomEntity,
        groupedLessons,
        notGroupedLessons,
        allLessonsInArray,
        tags,
        loading,
        lessonsGroupedByWeek,
        chapters,
        nextUnwatchedVideo,
        selectedLesson,
        transformToChapters,
        lessonsFinished,
        enrollmentEntity,
        filters,
        filteredLessonsGrouped,
        filteredWeeks,
        currentlyOpenedLesson,
        classroomContentTabIndex,
        selectedTagId
      ];
}
