abstract class NotificationsState {}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final bool isEnabled;

  NotificationsLoaded({required this.isEnabled});
}

class NotificationsError extends NotificationsState {
  final String message;

  NotificationsError(this.message);
}
