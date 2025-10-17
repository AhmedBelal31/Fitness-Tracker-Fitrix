import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../features/auth/domain/repositories/profile_repository/profile_repository.dart';
import '../../../features/auth/domain/repositories/profile_repository/profile_repository_impl.dart';
import '../../../features/auth/presentation/cubits/profile_cubit/complete_profile_cubit.dart';
import '../../../features/profile/presentation/cubits/update_profile_cubit/update_profile_cubit.dart';
import '../get_it.dart';

void setupProfileModule() {
  di.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(di<ApiService>()),
  );
  di.registerFactory<CompleteProfileCubit>(
    () => CompleteProfileCubit(di<ProfileRepository>()),
  );

  di.registerFactory(() => UpdateProfileCubit(di()));
}
