import 'package:fitrix/core/networking/dio_helper.dart';
import 'package:fitrix/features/workout/domain/repositories/workout_repository.dart';
import '../../../features/workout/domain/repositories/workout_repository_impl.dart';
import '../../../features/workout/presentation/cubit/workouts_cubit.dart';
import '../get_it.dart';

void setupWorkoutModule() {
  // Repositories
  di.registerLazySingleton<WorkoutRepository>(
    () => WorkoutRepositoryImpl(apiService: di<ApiService>()),
  );
  di.registerLazySingleton<WorkoutsCubit>(
    () => WorkoutsCubit(repository: di<WorkoutRepository>()),
  );
}
