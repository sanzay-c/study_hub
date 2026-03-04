part of 'social_bloc.dart';

abstract class SocialEvent extends Equatable {
  const SocialEvent();

  @override
  List<Object?> get props => [];
}

class GetSocialFollowersEvent extends SocialEvent {
  final String? search;
  const GetSocialFollowersEvent({this.search});

  @override
  List<Object?> get props => [search];
}

class GetSocialFollowingEvent extends SocialEvent {
  final String? search;
  const GetSocialFollowingEvent({this.search});

  @override
  List<Object?> get props => [search];
}

class GetSocialDiscoverEvent extends SocialEvent {
  final String? search;
  const GetSocialDiscoverEvent({this.search});

  @override
  List<Object?> get props => [search];
}

class SearchSocialEvent extends SocialEvent {
  final String query;
  const SearchSocialEvent(this.query);

  @override
  List<Object?> get props => [query];
}

class FollowUserEvent extends SocialEvent {
  final String userId;
  const FollowUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class UnfollowUserEvent extends SocialEvent {
  final String userId;
  const UnfollowUserEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}
