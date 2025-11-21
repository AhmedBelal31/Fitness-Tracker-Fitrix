import '../../../features/trainer_requests/domain/repository/trainer_requests_repository.dart';
import '../../../features/trainer_requests/domain/repository/trainer_requests_repository_impl.dart';
import '../../../features/trainer_requests/presentation/cubit/trainer_requests_cubit.dart';
import '../get_it.dart';

void setupTrainerRequestsModule() {
  di.registerLazySingleton<TrainerRequestsRepository>(
    () => TrainerRequestsRepositoryImpl(di()),
  );

  di.registerFactory(() => TrainerRequestsCubit(di()));
}
