class GetGroupsEntity {
  String id;
  String? name;
  String? description;
  String? createdBy;
  List<String> members;
  bool isPublic;
  DateTime createdAt;
  String? creatorName;
  String? imageUrl;
  int onlineCount;
  String? imagePath;
  DateTime? lastMessageTime;
  int unreadCount;
  String? lastMessageText;
  bool isGroup;
  String? otherUserId;

  GetGroupsEntity({
    required this.id,
    this.name,
    this.description,
    this.createdBy,
    required this.members,
    required this.isPublic,
    required this.createdAt,
    this.creatorName,
    this.imageUrl,
    required this.onlineCount,
    this.imagePath,
    this.lastMessageTime,
    this.unreadCount = 0,
    this.lastMessageText,
    this.isGroup = true,
    this.otherUserId,
  });

  GetGroupsEntity copyWith({
    String? id,
    String? name,
    String? description,
    String? createdBy,
    List<String>? members,
    bool? isPublic,
    DateTime? createdAt,
    String? creatorName,
    String? imageUrl,
    int? onlineCount,
    String? imagePath,
    DateTime? lastMessageTime,
    int? unreadCount,
    String? lastMessageText,
    bool? isGroup,
    String? otherUserId,
  }) {
    return GetGroupsEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdBy: createdBy ?? this.createdBy,
      members: members ?? this.members,
      isPublic: isPublic ?? this.isPublic,
      createdAt: createdAt ?? this.createdAt,
      creatorName: creatorName ?? this.creatorName,
      imageUrl: imageUrl ?? this.imageUrl,
      onlineCount: onlineCount ?? this.onlineCount,
      imagePath: imagePath ?? this.imagePath,
      lastMessageTime: lastMessageTime ?? this.lastMessageTime,
      unreadCount: unreadCount ?? this.unreadCount,
      lastMessageText: lastMessageText ?? this.lastMessageText,
      isGroup: isGroup ?? this.isGroup,
      otherUserId: otherUserId ?? this.otherUserId,
    );
  }
}
