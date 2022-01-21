part of 'all_notifications_bloc.dart';


class AllNotificationsState extends Equatable {
  const AllNotificationsState({this.loading, this.notifications});

  final bool loading;
  final List<Notification> notifications;

  AllNotificationsState copyWith({
    bool loading,
    List<Notification> notifications,
  }) {
    return new AllNotificationsState(
      loading: loading ?? this.loading,
      notifications: notifications ?? this.notifications,
    );
  }

  @override
  List<Object> get props => [loading, notifications];
}

