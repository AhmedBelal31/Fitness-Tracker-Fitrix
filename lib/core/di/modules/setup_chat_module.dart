import '../../../features/chat/domain/repositories/chat_repository.dart';
import '../../../features/chat/domain/repositories/chat_repository_impl.dart';
import '../../../features/chat/presentation/cubits/chat_cubit.dart';
import '../get_it.dart';

void setupChatModule() {
  // Repository
  di.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(apiService: di()),
  );

  // Cubit
  di.registerFactory(() => ChatCubit(repository: di()));
}
