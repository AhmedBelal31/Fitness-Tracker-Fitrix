import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart';
import '../../domain/repository.dart';
import 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationsRepository _repository;

  int _currentPage = 1;
  final int _pageSize = 20;

  NotificationsCubit({required NotificationsRepository repository})
    : _repository = repository,
      super(NotificationsInitial());

  /// Load notifications
  Future<void> loadNotifications({bool refresh = false}) async {
    if (refresh) {
      _currentPage = 1;
      emit(NotificationsLoading());
    }

    final notificationsResult = await _repository.getNotifications(
      pageNumber: _currentPage,
      pageSize: _pageSize,
    );

    final unreadCountResult = await _repository.getUnreadCount();

    await notificationsResult.fold(
      (failure) async {
        emit(NotificationsError(failure.errorMessage));
      },
      (notifications) async {
        final unreadCount = unreadCountResult.fold(
          (failure) => 0,
          (count) => count,
        );

        if (state is NotificationsLoaded && !refresh) {
          final currentNotifications =
              (state as NotificationsLoaded).notifications;
          emit(
            NotificationsLoaded(
              notifications: [...currentNotifications, ...notifications],
              unreadCount: unreadCount,
              hasMore: notifications.length == _pageSize,
            ),
          );
        } else {
          emit(
            NotificationsLoaded(
              notifications: notifications,
              unreadCount: unreadCount,
              hasMore: notifications.length == _pageSize,
            ),
          );
        }
      },
    );
  }

  /// Get only unread count (lightweight API call for badge)
  Future<void> fetchUnreadCount() async {
    final result = await _repository.getUnreadCount();

    result.fold(
      (failure) =>
          debugPrint('Failed to get unread count: ${failure.errorMessage}'),
      (count) {
        if (state is NotificationsLoaded) {
          emit((state as NotificationsLoaded).copyWith(unreadCount: count));
        } else {
          // Create initial state with just the count
          emit(
            NotificationsLoaded(
              notifications: [],
              unreadCount: count,
              hasMore: true,
            ),
          );
        }
      },
    );
  }

  /// Load more notifications (pagination)
  Future<void> loadMore() async {
    if (state is NotificationsLoaded) {
      final currentState = state as NotificationsLoaded;
      if (!currentState.hasMore) return;

      _currentPage++;
      await loadNotifications();
    }
  }

  /// Refresh notifications
  Future<void> refresh() async {
    await loadNotifications(refresh: true);
  }

  /// Mark notification as read
  Future<void> markAsRead(String notificationId) async {
    if (state is! NotificationsLoaded) return;

    final currentState = state as NotificationsLoaded;

    // Optimistically update UI
    final updatedNotifications = currentState.notifications.map((notification) {
      if (notification.id == notificationId && !notification.isRead) {
        return notification.copyWith(isRead: true, readAtUtc: DateTime.now());
      }
      return notification;
    }).toList();

    final newUnreadCount = updatedNotifications.where((n) => !n.isRead).length;

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: newUnreadCount,
      ),
    );

    // Make API call
    final result = await _repository.markAsRead(notificationId);

    result.fold(
      (failure) {
        debugPrint('Failed to mark as read: ${failure.errorMessage}');
        // Revert on failure
        emit(currentState);
      },
      (_) {
        debugPrint('✅ Marked as read successfully');
      },
    );
  }

  /// Mark all notifications as read
  Future<void> markAllAsRead() async {
    if (state is! NotificationsLoaded) return;

    final currentState = state as NotificationsLoaded;

    // Optimistically update UI
    final updatedNotifications = currentState.notifications.map((notification) {
      return notification.copyWith(isRead: true, readAtUtc: DateTime.now());
    }).toList();

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: 0,
      ),
    );

    // Make API call
    final result = await _repository.markAllAsRead();

    result.fold(
      (failure) {
        debugPrint('Failed to mark all as read: ${failure.errorMessage}');
        // Revert on failure
        emit(currentState);
      },
      (_) {
        debugPrint('✅ Marked all as read successfully');
      },
    );
  }

  /// Delete notification
  Future<void> deleteNotification(String notificationId) async {
    if (state is! NotificationsLoaded) return;

    final currentState = state as NotificationsLoaded;

    // Optimistically update UI
    final updatedNotifications = currentState.notifications
        .where((notification) => notification.id != notificationId)
        .toList();

    final deletedNotification = currentState.notifications.firstWhere(
      (n) => n.id == notificationId,
    );

    final newUnreadCount = deletedNotification.isRead
        ? currentState.unreadCount
        : currentState.unreadCount - 1;

    emit(
      currentState.copyWith(
        notifications: updatedNotifications,
        unreadCount: newUnreadCount,
      ),
    );

    // Make API call
    final result = await _repository.deleteNotification(notificationId);

    result.fold(
      (failure) {
        debugPrint('Failed to delete notification: ${failure.errorMessage}');
        // Revert on failure
        emit(currentState);
      },
      (_) {
        debugPrint('✅ Deleted notification successfully');
      },
    );
  }

  /// Get unread count
  Future<void> updateUnreadCount() async {
    final result = await _repository.getUnreadCount();

    result.fold((failure) => debugPrint('Failed to get unread count'), (count) {
      if (state is NotificationsLoaded) {
        emit((state as NotificationsLoaded).copyWith(unreadCount: count));
      }
    });
  }
}
