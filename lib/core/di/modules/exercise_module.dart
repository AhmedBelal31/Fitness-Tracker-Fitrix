import '../../../features/exercises/domain/repositories/exercise_repository.dart';
import '../../../features/exercises/domain/repositories/exercise_repository_impl.dart';
import '../../../features/exercises/presentation/cubit/custom_exercises_cubit.dart';
import '../../../features/exercises/presentation/cubit/exercises_cubit.dart';
import '../../../features/exercises/presentation/cubit/sections_cubit.dart';
import '../get_it.dart';

void setupExerciseModule() {
  // Repositories
  di.registerLazySingleton<ExerciseRepository>(
    () => ExerciseRepositoryImpl(di()),
  );

  // Cubits
  di.registerFactory(() => SectionsCubit(di()));
  di.registerFactory(() => ExercisesCubit(di()));
  di.registerFactory(() => CustomExercisesCubit(di()));
}
