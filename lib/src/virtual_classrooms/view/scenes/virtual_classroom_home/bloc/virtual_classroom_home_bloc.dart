import 'dart:async';

import 'package:akademi_al_mobile_app/packages/classroom_repository/lib/classroom_repository.dart';
import 'package:akademi_al_mobile_app/packages/enrollment_repository/enrollment_repository.dart';
import 'package:akademi_al_mobile_app/packages/feed_repository/feed_repository.dart';
import 'package:akademi_al_mobile_app/packages/models/enrollment/enrollment_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/classroom_entity.dart';
import 'package:akademi_al_mobile_app/packages/models/user/feed_item.dart';
import 'package:akademi_al_mobile_app/packages/user_repository/lib/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'virtual_classroom_home_event.dart';

part 'virtual_classroom_home_state.dart';

class VirtualClassroomHomeBloc
    extends Bloc<VirtualClassroomHomeEvent, VirtualClassroomHomeState> {
  VirtualClassroomHomeBloc(
      {this.classroomRepository,
      this.userRepository,
      this.enrollmentRepository,
      this.feedRepository})
      : super(VirtualClassroomHomeState());

  final ClassroomRepository classroomRepository;
  final UserRepository userRepository;
  final EnrollmentRepository enrollmentRepository;
  final FeedRepository feedRepository;

  @override
  Stream<VirtualClassroomHomeState> mapEventToState(
    VirtualClassroomHomeEvent event,
  ) async* {
    if (event is LoadVirtualClassroom) {
      yield* _mapLoadClassroomToState(event, state);
    } else if (event is LoadNextItems) {
      yield* _mapLoadNextItemsClassroomToState(event, state);
    } else if (event is AddFeedComment) {
      yield* _mapAddFeedCommentToState(event, state);
    } else if (event is ChangedComment) {
      yield _mapChangedCommentToState(event, state);
    } else if (event is Unregister) {
      yield* _mapUnregisterToState(event, state);
    } else if (event is DeleteFeedItem) {
      yield* _mapDeleteFeedItem(event, state);
    } else if (event is EditComment) {
      yield _mapEditCommentToState(event, state);
    } else if (event is SaveEditComment) {
      yield* _mapSaveEditComment(event, state);
    }
  }

  Stream<VirtualClassroomHomeState> _mapLoadClassroomToState(
      LoadVirtualClassroom event, VirtualClassroomHomeState state) async* {
    yield state.copyWith(
      loading: true,
    );
    final feedItems =
        await feedRepository.getAllFeedByClassroomId(event.classroomEntity.id, event.pageIndex);
    final userId = (await userRepository.getUserEntity()).id;

    yield state.copyWith(
        feedItems: feedItems,
        loading: false,
        classroomEntity: event.classroomEntity,
        enrollmentEntity: event.enrollmentId,
        userId: userId,
        hasMoreItems: feedItems.length < 10 ? false : true,
        comment: "");
  }

  Stream<VirtualClassroomHomeState> _mapLoadNextItemsClassroomToState(
      LoadNextItems event, VirtualClassroomHomeState state) async* {

    List<FeedItem> _list = List<FeedItem>.from(this.state.feedItems);
    final feedItems =
    await feedRepository.getAllFeedByClassroomId(event.classroomEntity.id, event.pageIndex);

    _list.addAll(feedItems);

    yield state.copyWith(
        feedItems: _list,
        hasMoreItems: feedItems.length < 10 ? false : true,
    );
  }

  Stream<VirtualClassroomHomeState> _mapAddFeedCommentToState(
      AddFeedComment event, VirtualClassroomHomeState state) async* {
    yield state.copyWith(loading: true);
    final FeedItem item = event.message;
    item.classroomId = state.classroomEntity.id;
    await feedRepository.saveFeed(item);
    final feedItems =
        await feedRepository.getAllFeedByClassroomId(state.classroomEntity.id, state.pageIndex);
    yield state.copyWith(loading: false, feedItems: feedItems, comment: "");
  }

  VirtualClassroomHomeState _mapChangedCommentToState(
      ChangedComment event, VirtualClassroomHomeState state) {
    print("here dude changing comment ${state.updateFeedItem}");

    return state.copyWith(
        comment: event.message,
        updateFeedItem: event.message.isEmpty ? null : state.updateFeedItem);
  }

  Stream<VirtualClassroomHomeState> _mapUnregisterToState(
      Unregister event, VirtualClassroomHomeState state) async* {
    yield state.copyWith(loading: true);

    await enrollmentRepository.deleteEnrollment(state.enrollmentEntity.id);

    yield state.copyWith(loading: false);
  }

  Stream<VirtualClassroomHomeState> _mapDeleteFeedItem(
      DeleteFeedItem event, VirtualClassroomHomeState state) async* {
    yield state.copyWith(loading: true);

    await feedRepository.deleteFeed(event.feedId);

    final feedItems =
        await feedRepository.getAllFeedByClassroomId(state.classroomEntity.id, state.pageIndex);

    yield state.copyWith(loading: false, feedItems: feedItems);
  }

  VirtualClassroomHomeState _mapEditCommentToState(
      EditComment event, VirtualClassroomHomeState state) {
    print("here mapEditCommentToState");
    return state.copyWith(updateFeedItem: event.feedItem);
  }

  Stream<VirtualClassroomHomeState> _mapSaveEditComment(SaveEditComment event, VirtualClassroomHomeState state) async* {
    yield state.copyWith(loading: true);
    final FeedItem item = state.updateFeedItem;
    item.message = state.comment;
    await feedRepository.updateFeed(item);
    final feedItems =
        await feedRepository.getAllFeedByClassroomId(state.classroomEntity.id, state.pageIndex);
    print("here dude ${state.updateFeedItem}");
    yield state.copyWith(loading: false, feedItems: feedItems, comment: "", updateFeedItem: null);
  }
}
