import 'package:get_it/get_it.dart';
import '../../../features/notifications/domain/notifications_repository_impl.dart';
import '../../../features/notifications/domain/repository.dart';
import '../../../features/notifications/presentation/cubit/notifications_cubit.dart';
import '../get_it.dart';

void setupNotificationsModule() {
  // Repository
  di.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepositoryImpl(apiService: di()),
  );

  // Cubit
  di.registerLazySingleton(() => NotificationsCubit(repository: di()));
}
