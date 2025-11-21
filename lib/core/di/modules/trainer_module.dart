import '../../../features/trainer/domain/repositories/trainer_repository.dart';
import '../../../features/trainer/domain/repositories/trainer_repository_impl.dart';
import '../../../features/trainer/presentation/cubits/trainee_details_cubit.dart';
import '../../../features/trainer/presentation/cubits/trainee_progress_cubit.dart';
import '../../../features/trainer/presentation/cubits/trainees_cubit.dart';
import '../../../features/trainer/presentation/cubits/trainer_dashboard_cubit.dart';
import '../../../features/trainer/presentation/cubits/trainer_requests_cubit.dart';
import '../../networking/dio_helper.dart';
import '../get_it.dart';

void setupTrainerModule() {
  // Repository
  di.registerLazySingleton<TrainerRepository>(
    () => TrainerRepositoryImpl(di.get<ApiService>()),
  );

  // Cubits
  di.registerFactory<TraineesCubit>(() => TraineesCubit(di()));
  di.registerFactory<TrainerDashboardCubit>(() => TrainerDashboardCubit(di()));
  di.registerFactory<TrainerRequestsCubit>(() => TrainerRequestsCubit(di()));
  di.registerFactory<TraineeDetailsCubit>(() => TraineeDetailsCubit(di()));
  di.registerFactory<TraineeProgressCubit>(() => TraineeProgressCubit(di()));
}
