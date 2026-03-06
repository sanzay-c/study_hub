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
  });
}
