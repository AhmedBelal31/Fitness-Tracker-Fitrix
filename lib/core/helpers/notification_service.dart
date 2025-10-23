import 'dart:developer';
import 'dart:io';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_prefs.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isEnabled = prefs.getBool('notifications_enabled') ?? true;

    if (!isEnabled) return;

    NotificationSettings settings = await _firebaseMessaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      log('✅ User granted notification permission');

      final apnsToken = await _firebaseMessaging.getAPNSToken();
      if (Platform.isIOS) {
        if (apnsToken != null) {
          await FirebaseMessaging.instance
              .subscribeToTopic('all')
              .timeout(
                const Duration(seconds: 3),
                onTimeout: () {
                  log("⚠️ Timeout while subscribing to topic 'all'");
                },
              );
          log("✅ Subscribed to topic 'all'");
        } else {
          log("❌ APNs token not ready yet, will retry onTokenRefresh");

          _firebaseMessaging.onTokenRefresh.listen((fcmToken) async {
            final refreshedApnsToken = await _firebaseMessaging.getAPNSToken();
            if (refreshedApnsToken != null) {
              await FirebaseMessaging.instance
                  .subscribeToTopic('all')
                  .timeout(
                    const Duration(seconds: 3),
                    onTimeout: () {
                      log("⚠️ Timeout while subscribing to topic 'all'");
                    },
                  );
              ;
              log("✅ Subscribed to topic 'all' after token refresh");
            }
          });
        }
      } else {
        await FirebaseMessaging.instance.subscribeToTopic('all');
      }
    } else {
      log('❌ User denied notification permissions');
    }

    if (settings.authorizationStatus != AuthorizationStatus.authorized) {
      return;
    }

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings('@mipmap/ic_launcher'),
          iOS: DarwinInitializationSettings(),
        );
    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _showNotification(notification);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      RemoteNotification? notification = message.notification;
      if (notification != null) {
        _showNotification(notification);
      }
    });
  }

  Future<void> _showNotification(RemoteNotification notification) async {
    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: AndroidNotificationDetails(
        'Achievers Channel',
        'Achievers Notifications',
        channelDescription: 'This channel is used for notifications_widgets',
        importance: Importance.max,
        priority: Priority.high,
      ),
    );
    print("Notification: ${notification.title} ${notification.body}");
    await _flutterLocalNotificationsPlugin.show(
      0,
      notification.title,
      notification.body,
      platformChannelSpecifics,
    );
  }

  Future<void> enableNotifications() async {
    await Prefs.setData(key: 'notifications_enabled', value: true);
    await _firebaseMessaging.subscribeToTopic("all");
    log("✅ Notifications enabled");
  }

  Future<void> disableNotifications() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notifications_enabled', false);
    await _firebaseMessaging.unsubscribeFromTopic("all");
    log("✅ Notifications disabled");
  }

  Future<void> checkAndRequestExactAlarmPermission() async {
    if (await Permission.scheduleExactAlarm.isDenied) {
      await Permission.scheduleExactAlarm.request();
    }
  }

  Future<void> _initializeTimeZone() async {
    tz.initializeTimeZones();
    final String localTimeZone = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(localTimeZone));
  }

  ///Enable Daily Notification
  Future<void> scheduleDailyNotification(
    RemoteNotification notification, {
    int? hour,
    int? minutes,
  }) async {
    await checkAndRequestExactAlarmPermission();
    await _initializeTimeZone();

    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'daily_channel_id',
          'Daily Notifications',
          channelDescription: 'Daily Reminder Notifications',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidDetails,
    );

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    final tz.TZDateTime scheduledTime = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour ?? 18,
      minutes ?? 0,
      0,
    );

    await _flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      notification.title,
      notification.body,
      scheduledTime,
      platformChannelSpecifics,
      //android specific
      androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    await Prefs.setData(key: 'daily_notification_enabled', value: true);
    log("✅ Daily Notification Scheduled");
  }

  Future<void> cancelDailyNotification() async {
    await Prefs.setData(key: 'daily_notification_enabled', value: false);
    await _flutterLocalNotificationsPlugin.cancel(1);
    log(" ❌ Daily Notification Canceled");
  }

  Future<void> showGoalReachedNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'goal_channel_id',
          'Goal Notifications',
          channelDescription: 'Notifications for when user reaches a goal',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformDetails,
    );
  }

  Future<void> showDailyCompletionNotification(
    String title,
    String body,
  ) async {
    const AndroidNotificationDetails
    androidDetails = AndroidNotificationDetails(
      'daily_completion_channel_id',
      'Daily Completion Notifications',
      channelDescription: 'Notifications for completing all daily challenges',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      // يمكنك إضافة صوت مخصص: sound: RawResourceAndroidNotificationSound('celebration'),
    );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );

    await _flutterLocalNotificationsPlugin.show(
      999,
      title,
      body,
      platformDetails,
    );
  }

  Future<void> showMoodCheckNotification(String title, String body) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'mood_channel_id',
          'Mood Check Notifications',
          channelDescription:
              'Notifications to remind user to check their mood',
          importance: Importance.max,
          priority: Priority.high,
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: DarwinNotificationDetails(),
    );

    await _flutterLocalNotificationsPlugin.show(
      1, // unique ID for mood check notification
      title,
      body,
      platformDetails,
    );
  }
}

class FirebaseTokenService {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> handleToken() async {
    try {
      String? token = await _firebaseMessaging.getToken();
      if (token != null) {
        debugPrint("✅ Token retrieved: $token");
        return token;
      } else {
        debugPrint("⚠️ Failed to retrieve token.");
      }
    } catch (e) {
      debugPrint("❌ Error retrieving token: $e");
    }
    return null;
  }

  Future<bool> isNotificationsEnabled() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('notifications_enabled') ?? true;
  }
}
