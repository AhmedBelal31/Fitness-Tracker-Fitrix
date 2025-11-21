// lib/features/chat/data/repositories/chat_repository_impl.dart
import 'package:dartz/dartz.dart';
import 'dart:developer' as dev;
import 'package:dio/dio.dart';
import '../../../../core/networking/api_constants.dart';
import '../../../../core/networking/dio_helper.dart';
import '../../../../core/networking/error/failures.dart';
import '../../data/models/chat_conversation.dart';
import '../../data/models/chat_message.dart';
import '../../domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ApiService apiService;

  ChatRepositoryImpl({required this.apiService});

  @override
  Future<Either<Failure, List<ChatConversation>>> getConversations({
    int pageSize = 20,
    int pageNumber = 1,
  }) async {
    try {
      dev.log('📤 Getting conversations', name: 'ChatRepository');

      final response = await apiService.get(
        ApiEndpoints.chatConversations,
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );

      final conversations = (response.data as List)
          .map((json) => ChatConversation.fromJson(json))
          .toList();

      dev.log(
        '✅ Loaded ${conversations.length} conversations',
        name: 'ChatRepository',
      );

      return Right(conversations);
    } on DioException catch (e) {
      dev.log('❌ DioException: ${e.message}', name: 'ChatRepository');
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatRepository');
      return Left(ServerFailure('Failed to load conversations: $e'));
    }
  }

  // lib/features/chat/data/repositories/chat_repository_impl.dart
  // lib/features/chat/data/repositories/chat_repository_impl.dart

  // lib/features/chat/data/repositories/chat_repository_impl.dart

  // lib/features/chat/data/repositories/chat_repository_impl.dart

  @override
  Future<Either<Failure, ChatConversation>> getOrCreateConversation({
    required String otherUserId,
  }) async {
    try {
      dev.log(
        '📤 Getting/creating conversation with: $otherUserId',
        name: 'ChatRepository',
      );

      final response = await apiService.get(
        '${ApiEndpoints.chatConversations}/$otherUserId',
      );

      final conversation = ChatConversation.fromJson(response.data);

      dev.log(
        '✅ Got/created conversation: ${conversation.id}',
        name: 'ChatRepository',
      );

      return Right(conversation);
    } on DioException catch (e) {
      dev.log('❌ DioException: ${e.message}', name: 'ChatRepository');
      dev.log('❌ Status: ${e.response?.statusCode}', name: 'ChatRepository');
      dev.log('❌ Response: ${e.response?.data}', name: 'ChatRepository');

      // Check for specific error
      if (e.response?.statusCode == 404) {
        final errorData = e.response?.data;
        if (errorData is Map &&
            errorData['errors']?['Profile_NotFound'] != null) {
          return Left(
            ServerFailure(
              'This user has not completed their profile setup yet. Please ask them to complete their profile first.',
            ),
          );
        }
      }

      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatRepository');
      return Left(ServerFailure('Failed to get/create conversation: $e'));
    }
  }

  // REMOVE or comment out the getOrCreateConversation method
  // It's not supported by the API

  @override
  Future<Either<Failure, ChatMessage>> sendMessage({
    required String conversationId,
    required String content,
  }) async {
    try {
      dev.log('📤 Sending message to: $conversationId', name: 'ChatRepository');

      final formData = FormData.fromMap({'Content': content, 'Type': 'Text'});

      // If conversationId looks like a userId (not a conversation yet),
      // try to create conversation by sending message
      final response = await apiService.postRequest(
        '${ApiEndpoints.chatConversations}/$conversationId/messages',
        data: formData,
      );

      final message = ChatMessage.fromJson(response.data);

      dev.log('✅ Message sent: ${message.id}', name: 'ChatRepository');

      return Right(message);
    } on DioException catch (e) {
      dev.log('❌ DioException: ${e.message}', name: 'ChatRepository');
      dev.log('❌ Status: ${e.response?.statusCode}', name: 'ChatRepository');
      dev.log('❌ Response: ${e.response?.data}', name: 'ChatRepository');

      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatRepository');
      return Left(ServerFailure('Failed to send message: $e'));
    }
  }

  @override
  Future<Either<Failure, List<ChatMessage>>> getMessages({
    required String conversationId,
    int pageSize = 50,
    int pageNumber = 1,
  }) async {
    try {
      dev.log(
        '📤 Getting messages for conversation: $conversationId',
        name: 'ChatRepository',
      );

      final response = await apiService.get(
        '${ApiEndpoints.chatConversations}/$conversationId/messages',
        queryParameters: {'pageSize': pageSize, 'pageNumber': pageNumber},
      );

      // Check if response.data is a list
      if (response.data is! List) {
        dev.log(
          '❌ Expected list but got: ${response.data.runtimeType}',
          name: 'ChatRepository',
        );
        return Left(ServerFailure('Invalid response format'));
      }

      final messages = (response.data as List)
          .map((json) => ChatMessage.fromJson(json))
          .toList();

      dev.log('✅ Loaded ${messages.length} messages', name: 'ChatRepository');

      return Right(messages);
    } on DioException catch (e) {
      dev.log('❌ DioException: ${e.message}', name: 'ChatRepository');
      dev.log('❌ Status: ${e.response?.statusCode}', name: 'ChatRepository');
      dev.log('❌ Response: ${e.response?.data}', name: 'ChatRepository');

      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatRepository');
      return Left(ServerFailure('Failed to load messages: $e'));
    }
  }

  // lib/features/chat/data/repositories/chat_repository_impl.dart

  @override
  Future<Either<Failure, int>> getUnreadCount({String? conversationId}) async {
    try {
      dev.log('📤 Getting unread count', name: 'ChatRepository');

      final response = await apiService.get(
        ApiEndpoints.chatUnreadCount,
        queryParameters: conversationId != null
            ? {'conversationId': conversationId}
            : null,
      );

      final count = response.data as int;

      dev.log('✅ Unread count: $count', name: 'ChatRepository');

      return Right(count);
    } on DioException catch (e) {
      dev.log('❌ DioException: ${e.message}', name: 'ChatRepository');
      return Left(ServerFailure.fromDioException(e));
    } catch (e) {
      dev.log('❌ Error: $e', name: 'ChatRepository');
      return Left(ServerFailure('Failed to get unread count: $e'));
    }
  }
}
