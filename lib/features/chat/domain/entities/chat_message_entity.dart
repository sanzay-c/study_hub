class ChatMessageEntity {
  final String id;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final DateTime timestamp;
  final bool isMe; // UI ma left/right side dekhauna

  ChatMessageEntity({
    required this.id,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    required this.timestamp,
    required this.isMe,
  });
}