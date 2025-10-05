import 'package:fitrix/core/networking/dio_helper.dart';
import 'package:fitrix/features/profile/domain/profile_repository_impl.dart';
import 'package:fitrix/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import '../../../features/profile/domain/profile_repository.dart';
import '../get_it.dart';

void setupProfileModule() {
  di.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(di<ApiService>()),
  );
  di.registerFactory<CompleteProfileCubit>(
    () => CompleteProfileCubit(di<ProfileRepository>()),
  );
}
