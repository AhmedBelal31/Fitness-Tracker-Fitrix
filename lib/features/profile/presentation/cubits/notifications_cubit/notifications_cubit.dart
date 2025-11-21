import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../../core/helpers/app_prefs.dart';
import '../../../../../core/helpers/notification_service.dart';
import 'notifications_state.dart';

// class NotificationsCubit extends Cubit<NotificationsState> {
//   final NotificationService _notificationService;
//
//   NotificationsCubit(this._notificationService)
//     : super(NotificationsInitial()) {
//     loadNotificationSettings();
//   }
//
//   Future<void> loadNotificationSettings() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//
//     try {
//       final isEnabled = await prefs.getBool('notifications_enabled') ?? true;
//       emit(NotificationsLoaded(isEnabled: isEnabled));
//     } catch (e) {
//       emit(NotificationsError('Failed to load notification settings'));
//     }
//   }
//
//   Future<void> toggleNotifications(bool value) async {
//     try {
//       if (value) {
//         await _notificationService.enableNotifications();
//       } else {
//         await _notificationService.disableNotifications();
//       }
//
//       emit(NotificationsLoaded(isEnabled: value));
//     } catch (e) {
//       emit(NotificationsError('Failed to toggle notifications'));
//       // Reload previous state
//       loadNotificationSettings();
//     }
//   }
// }

class NotificationsCubit extends Cubit<NotificationsState> {
  final NotificationService _notificationService;

  NotificationsCubit(this._notificationService)
    : super(NotificationsInitial()) {
    loadNotificationSettings();
  }

  Future<void> loadNotificationSettings() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final isEnabled = await prefs.getBool('notifications_enabled') ?? true;
      emit(NotificationsLoaded(isEnabled: isEnabled));
    } catch (e) {
      emit(NotificationsError('Failed to load notification settings'));
    }
  }

  // Return Future<bool> for LoadSwitch
  Future<bool> toggleNotifications(bool currentValue) async {
    try {
      final newValue = !currentValue;

      if (newValue) {
        await _notificationService.enableNotifications();
      } else {
        await _notificationService.disableNotifications();
      }

      emit(NotificationsLoaded(isEnabled: newValue));
      return newValue; // Return new value for LoadSwitch
    } catch (e) {
      emit(NotificationsError('Failed to toggle notifications'));
      // Return current value on error (no change)
      return currentValue;
    }
  }
}
