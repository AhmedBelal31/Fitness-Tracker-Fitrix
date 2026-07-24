import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/chat_conversation.dart';
import '../../data/models/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final ChatRepository repository;
  List<ChatMessage> _currentMessages = [];
  ChatConversation? _currentConversation;

  ChatCubit({required this.repository}) : super(ChatInitial());

  Future<void> loadConversations({
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    emit(ChatLoading());

    final result = await repository.getConversations(
      pageSize: pageSize,
      pageNumber: pageNumber,
    );

    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (conversations) => emit(ConversationsLoaded(conversations)),
    );
  }

  Future<void> getOrCreateConversation({required String otherUserId}) async {
    emit(ChatLoading());

    final result = await repository.getOrCreateConversation(
      otherUserId: otherUserId,
    );

    await result.fold(
      (failure) async => emit(ChatError(failure.errorMessage)),
      (conversation) async {
        _currentConversation = conversation;
        await loadMessages(conversationId: conversation.id);
      },
    );
  }

  Future<void> loadMessages({
    required String conversationId,
    int pageSize = 50,
    int pageNumber = 1,
  }) async {
    emit(ChatLoading());

    final result = await repository.getMessages(
      conversationId: conversationId,
      pageSize: pageSize,
      pageNumber: pageNumber,
    );

    result.fold((failure) => emit(ChatError(failure.errorMessage)), (messages) {
      // Also load the conversation details if we don't have it
      _loadConversationDetails(conversationId, messages);
    });
  }

  Future<void> _loadConversationDetails(
    String conversationId,
    List<ChatMessage> messages,
  ) async {
    // Create a basic conversation object if we don't have one
    // You might want to fetch full conversation details via API
    final conversation = ChatConversation(
      id: conversationId,
      otherUserId: '', // Will be filled from first message
      otherUserName: '', // Will be filled from first message
      unreadCount: 0,
      isOnline: false,
      createdAt: DateTime.now(),
    );

    _currentMessages = messages;
    _currentConversation = conversation;

    emit(MessagesLoaded(messages, conversation));
  }
  // lib/features/chat/presentation/cubits/chat_cubit.dart

  Future<void> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    if (content.trim().isEmpty) return;

    final result = await repository.sendMessage(
      conversationId: conversationId,
      content: content,
    );

    await result.fold(
      (failure) async => emit(ChatError(failure.errorMessage)),
      (message) async {
        _currentMessages.insert(0, message);

        // Update current conversation if it was created
        if (_currentConversation == null || _currentConversation!.id.isEmpty) {
          _currentConversation = ChatConversation(
            id: message.conversationId,
            otherUserId: conversationId,
            otherUserName: '',
            unreadCount: 0,
            isOnline: false,
            createdAt: DateTime.now(),
          );
        }

        emit(MessageSent(message));

        // Immediately emit updated messages list
        await Future.delayed(const Duration(milliseconds: 100));
        if (_currentConversation != null) {
          emit(MessagesLoaded(_currentMessages, _currentConversation!));
        }
      },
    );
  }

  Future<void> getUnreadCount({String? conversationId}) async {
    final result = await repository.getUnreadCount(
      conversationId: conversationId,
    );

    result.fold(
      (failure) => emit(ChatError(failure.errorMessage)),
      (count) => emit(UnreadCountLoaded(count)),
    );
  }

  void clearCurrentConversation() {
    _currentConversation = null;
    _currentMessages = [];
  }
}
