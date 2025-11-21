import '../../../features/user_requests/domain/repo/user_requests_repository.dart';
import '../../../features/user_requests/domain/repo/user_requests_repository_impl.dart';
import '../../../features/user_requests/presentation/cubit/user_requests_cubit.dart';
import '../get_it.dart';

/// Setup User Requests Module Dependencies
void setupUserRequestsModule() {
  // Repository
  di.registerLazySingleton<UserRequestsRepository>(
    () => UserRequestsRepositoryImpl(di()),
  );

  // Cubit
  di.registerFactory<UserRequestsCubit>(() => UserRequestsCubit(di()));
}
