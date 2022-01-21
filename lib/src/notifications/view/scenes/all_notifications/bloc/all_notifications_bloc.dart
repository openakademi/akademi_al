import 'dart:async';

import 'package:akademi_al_mobile_app/packages/models/user/notification.dart';
import 'package:akademi_al_mobile_app/packages/notifications_repository/lib/notifications_api_provider.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'all_notifications_event.dart';

part 'all_notifications_state.dart';

class AllNotificationsBloc
    extends Bloc<AllNotificationsEvent, AllNotificationsState> {
  AllNotificationsBloc(this.notificationsApiProvider)
      : super(AllNotificationsState());

  final NotificationsApiProvider notificationsApiProvider;

  @override
  Stream<AllNotificationsState> mapEventToState(
    AllNotificationsEvent event,
  ) async* {
    if (event is LoadAllNotificationsEvent) {
      yield* _mapLoadAllNotificationsEvent(state, event);
    }
  }

  Stream<AllNotificationsState> _mapLoadAllNotificationsEvent(
      AllNotificationsState state, LoadAllNotificationsEvent event) async* {
    yield state.copyWith(
      loading: true
    );

    final allNotifications = await notificationsApiProvider.getAllForUser();
    yield state.copyWith(
      loading: false,
      notifications: allNotifications
    );

    await notificationsApiProvider.markAllAsRead();
  }
}
