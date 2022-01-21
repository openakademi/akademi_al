part of 'virtual_classroom_home_bloc.dart';

class VirtualClassroomHomeState extends Equatable {
  const VirtualClassroomHomeState(
      {this.loading,
      this.feedItems,
      this.enrollmentEntity,
      this.classroomEntity,
      this.comment,
      this.userId,
      this.updateFeedItem,
      this.pageIndex = 0,
      this.hasMoreItems = false});

  final bool loading;
  final List<FeedItem> feedItems;
  final EnrollmentEntity enrollmentEntity;
  final ClassroomEntity classroomEntity;
  final String comment;
  final String userId;
  final FeedItem updateFeedItem;
  final int pageIndex;
  final bool hasMoreItems;

  VirtualClassroomHomeState copyWith(
      {ClassroomEntity classroomEntity,
      bool loading,
      List<FeedItem> feedItems,
      String comment,
      EnrollmentEntity enrollmentEntity,
      FeedItem updateFeedItem,
      String userId,
      int pageIndex,
        bool hasMoreItems}) {
    return new VirtualClassroomHomeState(
        loading: loading ?? this.loading,
        feedItems: feedItems ?? this.feedItems,
        enrollmentEntity: enrollmentEntity ?? this.enrollmentEntity,
        classroomEntity: classroomEntity ?? this.classroomEntity,
        comment: comment ?? this.comment,
        userId: userId ?? this.userId,
        updateFeedItem: updateFeedItem,
        pageIndex: pageIndex ?? this.pageIndex,
        hasMoreItems: hasMoreItems ?? this.hasMoreItems);
  }

  @override
  List<Object> get props => [
        loading,
        feedItems,
        enrollmentEntity,
        classroomEntity,
        comment,
        userId,
        updateFeedItem,
        pageIndex,
        hasMoreItems
      ];
}
