import '../../../features/home/domain/home_repository.dart';
import '../../../features/home/domain/home_repository_impl.dart';
import '../../../features/home/presentation/cubit/home_cubit.dart';
import '../../networking/dio_helper.dart';
import '../get_it.dart';

void setupHomeModule() {
  // Register HomeRepository
  di.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(di<ApiService>()),
  );

  // Register HomeCubit
  di.registerFactory<HomeCubit>(() => HomeCubit(di<HomeRepository>()));
}
