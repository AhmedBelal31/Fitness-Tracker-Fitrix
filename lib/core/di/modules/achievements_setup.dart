import '../../../features/home/domain/achievements_repository.dart';
import '../../../features/home/domain/achievements_repository_impl.dart';
import '../../../features/home/presentation/cubit/achievements_cubit.dart';
import '../get_it.dart';

void setupAchievementsModule() {
  // Repository
  di.registerLazySingleton<AchievementsRepository>(
    () => AchievementsRepositoryImpl(di()),
  );

  // Cubit
  di.registerLazySingleton(() => AchievementsCubit(di()));
}
