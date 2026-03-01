class NotesEntity {
  String id;
  String groupId;
  String uploadedBy;
  String? title;
  String? description;
  String filePath;
  String fileType;
  int fileSize;
  DateTime? createdAt;
  String uploaderUsername;
  dynamic uploaderAvatar;
  String groupName;

  NotesEntity({
    required this.id,
    required this.groupId,
    required this.uploadedBy,
    this.title,
    this.description,
    required this.filePath,
    required this.fileType,
    required this.fileSize,
    this.createdAt,
    required this.uploaderUsername,
    required this.uploaderAvatar,
    required this.groupName,
  });
}
