import 'package:equatable/equatable.dart';
import 'package:logger/logger.dart';
import '../../data/models/notification_model.dart';

abstract class NotificationsState extends Equatable {
  const NotificationsState();

  @override
  List<Object?> get props => [];
}

class NotificationsInitial extends NotificationsState {}

class NotificationsLoading extends NotificationsState {}

class NotificationsLoaded extends NotificationsState {
  final List<NotificationModel> notifications;
  final int unreadCount;
  final bool hasMore;

  const NotificationsLoaded({
    required this.notifications,
    required this.unreadCount,
    this.hasMore = true,
  });

  NotificationsLoaded copyWith({
    List<NotificationModel>? notifications,
    int? unreadCount,
    bool? hasMore,
  }) {
    return NotificationsLoaded(
      notifications: notifications ?? this.notifications,
      unreadCount: unreadCount ?? this.unreadCount,
      hasMore: hasMore ?? this.hasMore,
    );
  }

  @override
  List<Object?> get props => [notifications, unreadCount, hasMore];
}

class NotificationsError extends NotificationsState {
  final String message;

  const NotificationsError(this.message);

  @override
  List<Object?> get props => [message];
}

class NotificationActionLoading extends NotificationsState {
  final String notificationId;

  const NotificationActionLoading(this.notificationId);

  @override
  List<Object?> get props => [notificationId];
}
