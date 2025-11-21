enum MessageType { text, image }

class ChatMessage {
  final String id;
  final String conversationId;
  final String senderId;
  final String senderName;
  final String? senderImage;
  final String content;
  final MessageType type;
  final String? attachmentUrl;
  final bool isRead;
  final DateTime? readAt;
  final DateTime sentAt;
  final bool isEdited;
  final DateTime? editedAt;

  ChatMessage({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.senderName,
    this.senderImage,
    required this.content,
    required this.type,
    this.attachmentUrl,
    required this.isRead,
    this.readAt,
    required this.sentAt,
    required this.isEdited,
    this.editedAt,
  });

  factory ChatMessage.fromJson(Map<String, dynamic> json) {
    return ChatMessage(
      id: json['id'],
      conversationId: json['conversationId'],
      senderId: json['senderId'],
      senderName: json['senderName'],
      senderImage: json['senderImage'],
      content: json['content'],
      type: json['type'] == 0 ? MessageType.text : MessageType.image,
      attachmentUrl: json['attachmentUrl'],
      isRead: json['isRead'] ?? false,
      readAt: json['readAt'] != null ? DateTime.parse(json['readAt']) : null,
      sentAt: DateTime.parse(json['sentAt']),
      isEdited: json['isEdited'] ?? false,
      editedAt: json['editedAt'] != null
          ? DateTime.parse(json['editedAt'])
          : null,
    );
  }

  bool get isMine {
    // You'll need to check against current user ID
    return false; // Implement this properly
  }
}
