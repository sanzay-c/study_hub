import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/domain/usecase/follow_user_usecase.dart';
import 'package:study_hub/features/social/domain/usecase/social_discover_usecase.dart';
import 'package:study_hub/features/social/domain/usecase/social_followers_usecase.dart';
import 'package:study_hub/features/social/domain/usecase/social_following_usecase.dart';
import 'package:study_hub/features/social/domain/usecase/unfollow_user_usecase.dart';

part 'social_event.dart';
part 'social_state.dart';

@injectable
class SocialBloc extends Bloc<SocialEvent, SocialState> {
  final SocialFollowersUsecase getFollowersUsecase;
  final SocialFollowingUsecase getFollowingUsecase;
  final SocialDiscoverUsecase getDiscoverUsecase;
  final FollowUserUsecase followUserUsecase;
  final UnfollowUserUsecase unfollowUserUsecase;

  SocialBloc({
    required this.getFollowersUsecase,
    required this.getFollowingUsecase,
    required this.getDiscoverUsecase,
    required this.followUserUsecase,
    required this.unfollowUserUsecase,
  }) : super(const SocialState()) {
    on<GetSocialFollowersEvent>(_onGetFollowers);
    on<GetSocialFollowingEvent>(_onGetFollowing);
    on<GetSocialDiscoverEvent>(_onGetDiscover);
    on<SearchSocialEvent>(_onSearch);
    on<FollowUserEvent>(_onFollowUser);
    on<UnfollowUserEvent>(_onUnfollowUser);
  }

  /// Returns a Set of all userIds that we currently follow,
  /// derived from the following list (source of truth).
  Set<String> get _followedUserIds =>
      state.following.map((u) => u.userId).toSet();

  Future<void> _onGetFollowers(
    GetSocialFollowersEvent event,
    Emitter<SocialState> emit,
  ) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final searchTerm = event.search ?? state.searchQuery;
      final followers = await getFollowersUsecase(
        search: searchTerm.isEmpty ? null : searchTerm,
      );

      // ✅ Merge backend response with local follow state so that
      // following someone from Discover/Following tab is reflected here too.
      final followedIds = _followedUserIds;

      // Also collect any locally-known followed users from discoverUsers list
      final discoverFollowedIds = state.discoverUsers
          .where((u) => u.isFollowing)
          .map((u) => u.userId)
          .toSet();

      final mergedFollowers = followers.map((user) {
        final isFollowedLocally =
            followedIds.contains(user.userId) ||
            discoverFollowedIds.contains(user.userId);

        if (isFollowedLocally) {
          return user.copyWith(isFollowing: true);
        }
        return user;
      }).toList();

      emit(state.copyWith(
        status: SocialStatus.success,
        followers: mergedFollowers,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SocialStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetFollowing(
    GetSocialFollowingEvent event,
    Emitter<SocialState> emit,
  ) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final searchTerm = event.search ?? state.searchQuery;
      final following = await getFollowingUsecase(
        search: searchTerm.isEmpty ? null : searchTerm,
      );

      // Following list is the source of truth — no merge needed.
      // But update followers & discover lists to stay in sync.
      final followingIds = following.map((u) => u.userId).toSet();

      final updatedFollowers = state.followers.map((user) {
        return user.copyWith(isFollowing: followingIds.contains(user.userId));
      }).toList();

      final updatedDiscover = state.discoverUsers.map((user) {
        return user.copyWith(isFollowing: followingIds.contains(user.userId));
      }).toList();

      emit(state.copyWith(
        status: SocialStatus.success,
        following: following,
        followers: updatedFollowers,
        discoverUsers: updatedDiscover,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SocialStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onGetDiscover(
    GetSocialDiscoverEvent event,
    Emitter<SocialState> emit,
  ) async {
    emit(state.copyWith(status: SocialStatus.loading));
    try {
      final searchTerm = event.search ?? state.searchQuery;
      final discover = await getDiscoverUsecase(
        search: searchTerm.isEmpty ? null : searchTerm,
      );

      // ✅ Merge with local follow state so Discover tab stays in sync too.
      final followedIds = _followedUserIds;

      final mergedDiscover = discover.map((user) {
        if (followedIds.contains(user.userId)) {
          return user.copyWith(isFollowing: true);
        }
        return user;
      }).toList();

      emit(state.copyWith(
        status: SocialStatus.success,
        discoverUsers: mergedDiscover,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SocialStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  /// Triggered when user types in the search bar.
  /// Refreshes all three tabs simultaneously with the new query.
  Future<void> _onSearch(
    SearchSocialEvent event,
    Emitter<SocialState> emit,
  ) async {
    final query = event.query.trim();
    emit(state.copyWith(searchQuery: query, status: SocialStatus.loading));
    try {
      final search = query.isEmpty ? null : query;
      final results = await Future.wait([
        getFollowingUsecase(search: search),
        getFollowersUsecase(search: search),
        getDiscoverUsecase(search: search),
      ]);

      final following = results[0];
      final followingIds = following.map((u) => u.userId).toSet();

      // ✅ Merge all lists against the fresh following list (source of truth)
      final mergedFollowers = results[1].map((user) {
        return user.copyWith(isFollowing: followingIds.contains(user.userId));
      }).toList();

      final mergedDiscover = results[2].map((user) {
        return user.copyWith(isFollowing: followingIds.contains(user.userId));
      }).toList();

      emit(state.copyWith(
        status: SocialStatus.success,
        following: following,
        followers: mergedFollowers,
        discoverUsers: mergedDiscover,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: SocialStatus.error,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onFollowUser(
    FollowUserEvent event,
    Emitter<SocialState> emit,
  ) async {
    emit(state.copyWith(actionUserId: event.userId));
    try {
      await followUserUsecase(event.userId);

      // ✅ Update ALL three lists immediately for instant UI feedback
      final updatedFollowers = state.followers.map((user) {
        if (user.userId == event.userId) return user.copyWith(isFollowing: true);
        return user;
      }).toList();

      final updatedDiscover = state.discoverUsers.map((user) {
        if (user.userId == event.userId) return user.copyWith(isFollowing: true);
        return user;
      }).toList();

      // Also add to following list if not already there
      final alreadyInFollowing =
          state.following.any((u) => u.userId == event.userId);
      final updatedFollowing = alreadyInFollowing
          ? state.following
          : [
              ...state.following,
              // Find the user from any list to add to following
              ...state.followers
                  .where((u) => u.userId == event.userId)
                  .map((u) => u.copyWith(isFollowing: true)),
              ...state.discoverUsers
                  .where((u) => u.userId == event.userId && !alreadyInFollowing)
                  .map((u) => u.copyWith(isFollowing: true)),
            ];

      emit(state.copyWith(
        followers: updatedFollowers,
        discoverUsers: updatedDiscover,
        following: updatedFollowing,
        clearActionUserId: true,
      ));
    } catch (e) {
      // ✅ Revert optimistic update on failure
      final revertedFollowers = state.followers.map((user) {
        if (user.userId == event.userId) {
          return user.copyWith(isFollowing: false);
        }
        return user;
      }).toList();

      final revertedDiscover = state.discoverUsers.map((user) {
        if (user.userId == event.userId) {
          return user.copyWith(isFollowing: false);
        }
        return user;
      }).toList();

      emit(state.copyWith(
        followers: revertedFollowers,
        discoverUsers: revertedDiscover,
        clearActionUserId: true,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _onUnfollowUser(
    UnfollowUserEvent event,
    Emitter<SocialState> emit,
  ) async {
    emit(state.copyWith(actionUserId: event.userId));
    try {
      await unfollowUserUsecase(event.userId);

      // ✅ Update ALL three lists immediately
      final updatedFollowing =
          state.following.where((user) => user.userId != event.userId).toList();

      final updatedFollowers = state.followers.map((user) {
        if (user.userId == event.userId) {
          return user.copyWith(isFollowing: false);
        }
        return user;
      }).toList();

      final updatedDiscover = state.discoverUsers.map((user) {
        if (user.userId == event.userId) {
          return user.copyWith(isFollowing: false);
        }
        return user;
      }).toList();

      emit(state.copyWith(
        following: updatedFollowing,
        followers: updatedFollowers,
        discoverUsers: updatedDiscover,
        clearActionUserId: true,
      ));
    } catch (e) {
      // ✅ Revert optimistic update on failure
      final revertedFollowers = state.followers.map((user) {
        if (user.userId == event.userId) {
          return user.copyWith(isFollowing: true);
        }
        return user;
      }).toList();

      emit(state.copyWith(
        followers: revertedFollowers,
        clearActionUserId: true,
        errorMessage: e.toString(),
      ));
    }
  }
}