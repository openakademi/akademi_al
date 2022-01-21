part of 'virtual_classroom_home_bloc.dart';

class VirtualClassroomHomeEvent extends Equatable {
  const VirtualClassroomHomeEvent();

  @override
  List<Object> get props => [];
}


class LoadVirtualClassroom extends VirtualClassroomHomeEvent {
  final ClassroomEntity classroomEntity;
  final EnrollmentEntity enrollmentId;
  final int pageIndex;

  LoadVirtualClassroom(this.classroomEntity, this.enrollmentId, this.pageIndex);

  @override
  List<Object> get props => [classroomEntity, enrollmentId, pageIndex];
}

class LoadNextItems extends VirtualClassroomHomeEvent {
  final ClassroomEntity classroomEntity;
  final int pageIndex;

  LoadNextItems(this.classroomEntity, this.pageIndex);

  @override
  List<Object> get props => [classroomEntity, pageIndex];
}

class AddFeedComment extends VirtualClassroomHomeEvent {
  final FeedItem message;

  AddFeedComment(this.message);

  @override
  List<Object> get props => [message];
}

class ChangedComment extends VirtualClassroomHomeEvent {
  final String message;

  ChangedComment(this.message);

  @override
  List<Object> get props => [message];
}

class Unregister extends VirtualClassroomHomeEvent {
  @override
  List<Object> get props => [];
}

class DeleteFeedItem extends VirtualClassroomHomeEvent {
  final String feedId;

  DeleteFeedItem(this.feedId);

  @override
  List<Object> get props => [feedId];
}

class EditComment extends VirtualClassroomHomeEvent {
  final FeedItem feedItem;

  EditComment(this.feedItem);

  @override
  List<Object> get props => [feedItem];
}

class SaveEditComment extends VirtualClassroomHomeEvent {
  @override
  List<Object> get props => [];
}
