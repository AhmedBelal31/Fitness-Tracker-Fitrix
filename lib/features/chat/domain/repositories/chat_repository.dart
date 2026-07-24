import 'package:dartz/dartz.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/chat_conversation.dart';
import '../../data/models/chat_message.dart';

abstract class ChatRepository {
  Future<Either<Failure, List<ChatConversation>>> getConversations({
    int pageSize = 20,
    int pageNumber = 1,
  });

  Future<Either<Failure, ChatConversation>> getOrCreateConversation({
    required String otherUserId,
  });

  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required String conversationId,
    int pageSize = 50,
    int pageNumber = 1,
  });

  Future<Either<Failure, ChatMessage>> sendMessage({
    required String conversationId,
    required String content,
  });

  Future<Either<Failure, int>> getUnreadCount({String? conversationId});
}
