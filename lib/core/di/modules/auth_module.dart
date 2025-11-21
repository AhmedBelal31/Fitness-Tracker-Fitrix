import 'package:fitrix/core/networking/dio_helper.dart';
import 'package:fitrix/features/auth/domain/repositories/profile_repository/profile_repository.dart';
import '../../../features/auth/domain/repositories/auth_repositories/auth_repository.dart';
import '../../../features/auth/domain/repositories/auth_repositories/auth_repository_impl.dart';
import '../../../features/auth/presentation/cubits/auth_check/auth_check_cubit.dart';
import '../../../features/auth/presentation/cubits/forget_password/forgot_password_cubit.dart';
import '../../../features/auth/presentation/cubits/login/login_cubit.dart';
import '../../../features/auth/presentation/cubits/register/register_cubit.dart';
import '../../../features/profile/presentation/cubits/change_password_cubit/change_password_cubit.dart';
import '../get_it.dart';

void setupAuthModule() {
  di.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(di<ApiService>()),
  );
  di.registerFactory<RegisterCubit>(() => RegisterCubit(di<AuthRepository>()));
  di.registerFactory<LoginCubit>(() => LoginCubit(di<AuthRepository>()));
  di.registerFactory<AuthCheckCubit>(() => AuthCheckCubit());
  di.registerFactory<ForgotPasswordCubit>(
    () => ForgotPasswordCubit(di<AuthRepository>()),
  );

  di.registerLazySingleton<ChangePasswordCubit>(
    () => ChangePasswordCubit(di<ProfileRepository>()),
  );
}
