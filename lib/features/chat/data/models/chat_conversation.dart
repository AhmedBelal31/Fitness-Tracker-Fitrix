class ChatConversation {
  final String id;
  final String otherUserId;
  final String otherUserName;
  final String? otherUserImage;
  final String? lastMessage;
  final DateTime? lastMessageAt;
  final int unreadCount;
  final bool isOnline;
  final DateTime createdAt;

  ChatConversation({
    required this.id,
    required this.otherUserId,
    required this.otherUserName,
    this.otherUserImage,
    this.lastMessage,
    this.lastMessageAt,
    required this.unreadCount,
    required this.isOnline,
    required this.createdAt,
  });

  factory ChatConversation.fromJson(Map<String, dynamic> json) {
    return ChatConversation(
      id: json['id'],
      otherUserId: json['otherUserId'],
      otherUserName: json['otherUserName'],
      otherUserImage: json['otherUserImage'],
      lastMessage: json['lastMessage'],
      lastMessageAt: json['lastMessageAt'] != null
          ? DateTime.parse(json['lastMessageAt'])
          : null,
      unreadCount: json['unreadCount'] ?? 0,
      isOnline: json['isOnline'] ?? false,
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
}
