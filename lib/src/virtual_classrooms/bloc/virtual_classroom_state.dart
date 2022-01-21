part of 'virtual_classroom_bloc.dart';

class VirtualClassroomState extends Equatable {
  const VirtualClassroomState({
    this.selectedVirtualClassroomId,
    this.selectedEnrollment,
    this.virtualClassroomPageIndex = 0,
    this.loading,
    this.lessonToOpen,
    this.classroomEntity,
    this.pupils,
    this.enrollmentEntity,
    this.subjectPlanTreeNotGrouped,
    this.tags,
    this.lessonsGroupedByWeek,
    this.filteredLessonsGrouped,
    this.allLessonsInArray,
    this.currentlyOpenedLesson,
    this.nextUnwatchedVideo,
    this.selectedLesson,
  });

  final String selectedVirtualClassroomId;
  final EnrollmentEntity selectedEnrollment;
  final int virtualClassroomPageIndex;
  final bool loading;
  final String lessonToOpen;
  final ClassroomEntity classroomEntity;
  final List<EnrollmentEntity> pupils;
  final EnrollmentEntity enrollmentEntity;
  final Map<String, List<Lessons>> filteredLessonsGrouped;
  final List<Lessons> allLessonsInArray;
  final SubjectPlanTree subjectPlanTreeNotGrouped;
  final List<TagsNotAsync> tags;
  final Map<String, List<Lessons>> lessonsGroupedByWeek;
  final String currentlyOpenedLesson;
  final String nextUnwatchedVideo;
  final Lessons selectedLesson;

  VirtualClassroomState copyWith({
    String selectedVirtualClassroomId,
    EnrollmentEntity selectedEnrollment,
    int virtualClassroomPageIndex,
    bool loading,
    String lessonToOpen,
    ClassroomEntity classroomEntity,
    List<EnrollmentEntity> pupils,
    EnrollmentEntity enrollmentEntity,
    SubjectPlanTree subjectPlanTreeNotGrouped,
    List<TagsNotAsync> tags,
    Map<String, List<Lessons>> lessonsGroupedByWeek,
    Map<String, List<Lessons>> filteredLessonsGrouped,
    List<Lessons> allLessonsInArray,
    String currentlyOpenedLesson,
    String nextUnwatchedVideo,
    Lessons selectedLesson,
  }) {
    return new VirtualClassroomState(
      selectedVirtualClassroomId:
          selectedVirtualClassroomId ?? this.selectedVirtualClassroomId,
      selectedEnrollment: selectedEnrollment ?? this.selectedEnrollment,
      virtualClassroomPageIndex:
          virtualClassroomPageIndex ?? this.virtualClassroomPageIndex,
      loading: loading ?? this.loading,
      lessonToOpen: lessonToOpen ?? this.lessonToOpen,
      classroomEntity: classroomEntity ?? this.classroomEntity,
      pupils: pupils ?? this.pupils,
      enrollmentEntity: enrollmentEntity ?? this.enrollmentEntity,
      subjectPlanTreeNotGrouped: subjectPlanTreeNotGrouped ?? this.subjectPlanTreeNotGrouped,
      tags: tags ?? this.tags,
      lessonsGroupedByWeek: lessonsGroupedByWeek ?? this.lessonsGroupedByWeek,
      filteredLessonsGrouped: filteredLessonsGrouped ?? this.filteredLessonsGrouped,
      allLessonsInArray: allLessonsInArray ?? this.allLessonsInArray,
      currentlyOpenedLesson:
          currentlyOpenedLesson ?? this.currentlyOpenedLesson,
      nextUnwatchedVideo: nextUnwatchedVideo ?? this.nextUnwatchedVideo,
      selectedLesson: selectedLesson ?? this.selectedLesson,
    );
  }

  @override
  List<Object> get props => [
        selectedVirtualClassroomId,
        selectedEnrollment,
        virtualClassroomPageIndex,
        loading,
        lessonToOpen,
        classroomEntity,
        pupils,
        enrollmentEntity,
        subjectPlanTreeNotGrouped,
        tags,
        lessonsGroupedByWeek,
        filteredLessonsGrouped,
        allLessonsInArray,
        currentlyOpenedLesson,
        nextUnwatchedVideo,
        selectedLesson
      ];
}
