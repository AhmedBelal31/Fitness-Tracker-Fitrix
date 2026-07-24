import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../features/progress/domain/progress_repository.dart';
import '../../../features/progress/domain/progress_repository_impl.dart';
import '../../../features/progress/presentation/cubit/progress_cubit.dart';
import '../get_it.dart';

void setupProgressModule() {
  // Repository
  di.registerLazySingleton<ProgressRepository>(
    () => ProgressRepositoryImpl(apiService: di<ApiService>()),
  );

  // Cubit
  di.registerFactory<ProgressCubit>(
    () => ProgressCubit(repository: di<ProgressRepository>()),
  );
}
