import '../../helpers/notification_service.dart';
import '../../networking/dio_helper.dart';
import '../../services/sound_service.dart';
import '../get_it.dart';

void setupCoreModule() {
  di.registerLazySingleton<ApiService>(() => ApiService());
  di.registerLazySingleton<NotificationService>(() => NotificationService());
  di.registerLazySingleton<SoundService>(() => SoundService.instance);
  di.registerLazySingleton<FirebaseTokenService>(() => FirebaseTokenService());
}
