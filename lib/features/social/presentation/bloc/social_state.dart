part of 'social_bloc.dart';

enum SocialStatus { initial, loading, success, error }

class SocialState extends Equatable {
  final SocialStatus status;
  final List<SocialEntity> followers;
  final List<SocialEntity> following;
  final List<SocialEntity> discoverUsers;
  final String? errorMessage;
  final String? actionUserId;
  final String searchQuery;

  const SocialState({
    this.status = SocialStatus.initial,
    this.followers = const [],
    this.following = const [],
    this.discoverUsers = const [],
    this.errorMessage,
    this.actionUserId,
    this.searchQuery = '',
  });

  /// Use [clearActionUserId] = true to explicitly reset [actionUserId] to null.
  SocialState copyWith({
    SocialStatus? status,
    List<SocialEntity>? followers,
    List<SocialEntity>? following,
    List<SocialEntity>? discoverUsers,
    String? errorMessage,
    String? actionUserId,
    bool clearActionUserId = false,
    String? searchQuery,
  }) {
    return SocialState(
      status: status ?? this.status,
      followers: followers ?? this.followers,
      following: following ?? this.following,
      discoverUsers: discoverUsers ?? this.discoverUsers,
      errorMessage: errorMessage ?? this.errorMessage,
      actionUserId: clearActionUserId ? null : (actionUserId ?? this.actionUserId),
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }

  @override
  List<Object?> get props => [
        status,
        followers,
        following,
        discoverUsers,
        errorMessage,
        actionUserId,
        searchQuery,
      ];
}