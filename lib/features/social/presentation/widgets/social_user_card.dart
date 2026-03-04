import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';

enum SocialCardSource { discover, followers, following }

class SocialUserCard extends StatelessWidget {
  final SocialEntity userData;
  final SocialCardSource source;

  const SocialUserCard({
    super.key,
    required this.userData,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => getIt<NavigationService>().pushNamed(
        RouteName.userDetailsScreen,
        extra: userData,
      ),
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerColor,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.containerBorderColor,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            _UserAvatar(avatarPath: userData.avatarPath),
            8.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userData.username,
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                  4.verticalSpace,
                  TextWidget(
                    // text: userData.bio ?? 'No bio yet.',
                    text: 'No bio yet.',
                    fontSize: 14.sp,
                    maxLines: 1,
                    textOverflow: TextOverflow.ellipsis,
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
                  ),
                  16.verticalSpace,
                  Row(
                    children: [
                      _StatWidget(
                          count: userData.followers, label: 'followers'),
                      24.horizontalSpace,
                      _StatWidget(
                          count: userData.following, label: 'following'),
                    ],
                  ),
                ],
              ),
            ),
            _FollowButton(userData: userData, source: source),
          ],
        ),
      ),
    );
  }
}


class _UserAvatar extends StatelessWidget {
  final String? avatarPath;
  const _UserAvatar({required this.avatarPath});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 35.r,
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.subTextColor,
      // ignore: deprecated_member_use
      ).withOpacity(0.1),
      backgroundImage:
          avatarPath != null ? NetworkImage(avatarPath!) : null,
      child: avatarPath == null
          ? SvgPicture.asset(
              AssetsSource.appIcons.userPersonIcon,
              width: 40.r,
              height: 40.r,
              colorFilter: ColorFilter.mode(
                getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
                BlendMode.srcIn,
              ),
            )
          : null,
    );
  }
}


class _StatWidget extends StatelessWidget {
  final String count;
  final String label;
  const _StatWidget({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: count,
          fontSize: 14.sp,
          fontWeight: FontWeight.w700,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
        TextWidget(
          text: label,
          fontSize: 12.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}


class _FollowButton extends StatelessWidget {
  final SocialEntity userData;
  final SocialCardSource source;

  const _FollowButton({required this.userData, required this.source});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      buildWhen: (prev, curr) => _shouldRebuild(prev, curr),
      builder: (context, state) {
        final isLoading = state.actionUserId == userData.userId;
        final isFollowing = _resolveFollowState(state);

        if (isLoading) {
          return SizedBox(
            height: 40.h,
            width: 40.w,
            child: Padding(
              padding: EdgeInsets.all(8.r),
              child: const CircularProgressIndicator(strokeWidth: 2),
            ),
          );
        }

        if (source == SocialCardSource.following) {
          return GestureDetector(
            onTap: () => context
                .read<SocialBloc>()
                .add(UnfollowUserEvent(userData.userId)),
            child: _FollowingChip(),
          );
        }

        return GestureDetector(
          onTap: () {
            if (isFollowing) {
              context
                  .read<SocialBloc>()
                  .add(UnfollowUserEvent(userData.userId));
            } else {
              context
                  .read<SocialBloc>()
                  .add(FollowUserEvent(userData.userId));
            }
          },
          child: isFollowing ? _FollowingChip() : _FollowChip(),
        );
      },
    );
  }

  bool _resolveFollowState(SocialState state) {
    switch (source) {
      case SocialCardSource.discover:
        final user = state.discoverUsers
            .cast<SocialEntity?>()
            .firstWhere((u) => u?.userId == userData.userId,
                orElse: () => null);
        return user?.isFollowing ?? userData.isFollowing;

      case SocialCardSource.followers:
        final isInFollowingList =
            state.following.any((u) => u.userId == userData.userId);
        final user = state.followers
            .cast<SocialEntity?>()
            .firstWhere((u) => u?.userId == userData.userId,
                orElse: () => null);
        return isInFollowingList ||
            (user?.isFollowing ?? userData.isFollowing);

      case SocialCardSource.following:
        return true; 
    }
  }

  bool _shouldRebuild(SocialState prev, SocialState curr) {
    if ((prev.actionUserId == userData.userId) !=
        (curr.actionUserId == userData.userId)) {
      return true;
    }

    switch (source) {
      case SocialCardSource.discover:
        return prev.discoverUsers
                .cast<SocialEntity?>()
                .firstWhere((u) => u?.userId == userData.userId,
                    orElse: () => null)
                ?.isFollowing !=
            curr.discoverUsers
                .cast<SocialEntity?>()
                .firstWhere((u) => u?.userId == userData.userId,
                    orElse: () => null)
                ?.isFollowing;

      case SocialCardSource.followers:
        final prevFollowing =
            prev.following.any((u) => u.userId == userData.userId);
        final currFollowing =
            curr.following.any((u) => u.userId == userData.userId);
        final prevIsFollowing = prev.followers
            .cast<SocialEntity?>()
            .firstWhere((u) => u?.userId == userData.userId,
                orElse: () => null)
            ?.isFollowing;
        final currIsFollowing = curr.followers
            .cast<SocialEntity?>()
            .firstWhere((u) => u?.userId == userData.userId,
                orElse: () => null)
            ?.isFollowing;
        return prevFollowing != currFollowing ||
            prevIsFollowing != currIsFollowing;

      case SocialCardSource.following:
        return false; 
    }
  }
}


class _FollowingChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerButton,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgImageRenderWidget(
            svgImagePath: AssetsSource.appIcons.personFollowingIcon,
            height: 14.h,
            width: 14.w,
          ),
          4.horizontalSpace,
          TextWidget(
            text: 'Following',
            fontSize: 14.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.textColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _FollowChip extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            getColorByTheme(
              context: context,
              colorClass: AppColors.gr0XFF526DFF,
            ),
            getColorByTheme(
              context: context,
              colorClass: AppColors.gr0XFF8B32FB,
            ),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgImageRenderWidget(
            svgImagePath: AssetsSource.appIcons.personFollowIcon,
            height: 14.h,
            width: 14.w,
            svgColor: AppColors.allWhite,
          ),
          4.horizontalSpace,
          TextWidget(
            text: 'Follow',
            fontSize: 14.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.allWhite,
            ),
          ),
        ],
      ),
    );
  }
}