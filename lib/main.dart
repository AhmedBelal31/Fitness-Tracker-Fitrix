import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fitrix/core/common_ui/widgets/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/di/get_it.dart';
import 'core/helpers/app_prefs.dart';
import 'core/helpers/bloc_observer.dart';
import 'core/helpers/notification_service.dart';
import 'core/networking/token_manager.dart';
import 'core/routing/app_router.dart';
import 'core/services/hive_service.dart';
import 'core/services/sound_service.dart';
import 'firebase_options.dart';
import 'fitrix_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // debugPaintSizeEnabled = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  Bloc.observer = MyBlocObserver();
  setupServiceLocator();
  // To fix texts being hidden bug in flutter_screenutil in release mode.
  await ScreenUtil.ensureScreenSize();
  await Prefs.init();

  final firebaseNotificationsService = di<NotificationService>();
  await firebaseNotificationsService.initNotifications().timeout(
    const Duration(seconds: 3),
    onTimeout: () {
      AppLogger.d("❌ Firebase notifications initialization timed out.");
      return null;
    },
  );
  final token = await di<FirebaseTokenService>().handleToken();
  if (token != null) {
    AppLogger.d("🔥 FCM Token on app start: $token");
  }
  await TokenManager.instance.init();

  await HiveService().init();
  await SoundService.instance.init();
  runApp(
    DevicePreview(
      // enabled: kDebugMode,
      enabled: false,
      builder: (context) {
        return FitrixApp(appRouter: AppRouter());
      },
    ),
  );
}
