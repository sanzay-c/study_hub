class ChatMessageEntity {
  final String id;
  final String senderId;
  final String? receiverId;
  final String? groupId;
  final String content;
  final DateTime timestamp;
  final bool isMe;
  final String? senderName;       // Display name of sender (optional)
  final String? senderAvatarUrl;  // Avatar URL of sender (optional)

  ChatMessageEntity({
    required this.id,
    required this.senderId,
    this.receiverId,
    this.groupId,
    required this.content,
    required this.timestamp,
    required this.isMe,
    this.senderName,
    this.senderAvatarUrl,
  });
}