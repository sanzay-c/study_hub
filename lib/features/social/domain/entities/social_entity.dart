class SocialEntity {
  final String userId;

  final String username;

  final String? avatarPath;

  final String followers;
  final String following;
  final bool isFollowing;
  final DateTime? followedAt;

  SocialEntity({
    required this.userId,
    required this.username,
    required this.avatarPath,
    required this.followers,
    required this.following,
    required this.isFollowing,
    required this.followedAt,
  });

  SocialEntity copyWith({
    String? userId,
    String? username,
    String? avatarPath,
    String? followers,
    String? following,
    bool? isFollowing,
    DateTime? followedAt,
  }) {
    return SocialEntity(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      avatarPath: avatarPath ?? this.avatarPath,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      isFollowing: isFollowing ?? this.isFollowing,
      followedAt: followedAt ?? this.followedAt,
    );
  }
}
