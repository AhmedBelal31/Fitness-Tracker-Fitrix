part of 'chat_cubit.dart';

abstract class ChatState {}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ConversationsLoaded extends ChatState {
  final List<ChatConversation> conversations;

  ConversationsLoaded(this.conversations);
}

class MessagesLoaded extends ChatState {
  final List<ChatMessage> messages;
  final ChatConversation conversation;

  MessagesLoaded(this.messages, this.conversation);
}

class MessageSent extends ChatState {
  final ChatMessage message;

  MessageSent(this.message);
}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message);
}

class UnreadCountLoaded extends ChatState {
  final int count;

  UnreadCountLoaded(this.count);
}
