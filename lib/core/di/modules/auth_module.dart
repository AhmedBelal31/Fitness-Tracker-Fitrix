import 'package:fitrix/core/networking/dio_helper.dart';
import '../../../features/auth/domain/repositories/auth_repository.dart';
import '../../../features/auth/domain/repositories/auth_repository_impl.dart';
import '../../../features/auth/presentation/cubits/login/login_cubit.dart';
import '../../../features/auth/presentation/cubits/register/register_cubit.dart';
import '../get_it.dart';

void setupAuthModule() {
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(di<ApiService>()),
  );
  di.registerFactory<RegisterCubit>(() => RegisterCubit(di<AuthRepository>()));

  di.registerFactory<LoginCubit>(() => LoginCubit(di<AuthRepository>()));
}
