import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/social/presentation/widgets/social_shimmer.dart';

class UserFollowersScreen extends StatefulWidget {
  const UserFollowersScreen({super.key});

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(GetSocialFollowersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.followers.isEmpty) {
          return SocialShimmer();
        }

        if (state.status == SocialStatus.error && state.followers.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }

        if (state.followers.isEmpty) {
          return const Center(child: Text('No such user found'));
        }

        return CustomDotsRefreshIndicator(
          onRefresh: () async {
            context.read<SocialBloc>().add(GetSocialFollowersEvent());
          },
          child: ListView.builder(
            itemCount: state.followers.length,
            itemBuilder: (context, index) {
              return UserProfileCard(userData: state.followers[index]);
            },
          ),
        );
      },
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final SocialEntity userData;

  const UserProfileCard({super.key, required this.userData});

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
            CircleAvatar(
              radius: 35.r,
              backgroundColor: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ).withOpacity(0.1),
              backgroundImage: userData.avatarPath != null
                  ? NetworkImage(userData.avatarPath!)
                  : null,
              child: userData.avatarPath == null
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
            ),
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
                    text: 'User bio here...',
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
                      _buildStat(userData.followers, 'followers', context),
                      24.horizontalSpace,
                      _buildStat(userData.following, 'following', context),
                    ],
                  ),
                ],
              ),
            ),

            BlocBuilder<SocialBloc, SocialState>(
              buildWhen: (previous, current) {
                // Check if isFollowing changed in followers list for this user
                final prevFollower =
                    previous.followers.cast<SocialEntity?>().firstWhere(
                          (u) => u?.userId == userData.userId,
                          orElse: () => null,
                        );
                final currFollower =
                    current.followers.cast<SocialEntity?>().firstWhere(
                          (u) => u?.userId == userData.userId,
                          orElse: () => null,
                        );
                final followerListChanged =
                    prevFollower?.isFollowing != currFollower?.isFollowing;

                // ✅ Also check if this user appeared/disappeared in the following list
                // This catches follow/unfollow done from Discover or Following tabs
                final prevInFollowing =
                    previous.following.any((u) => u.userId == userData.userId);
                final currInFollowing =
                    current.following.any((u) => u.userId == userData.userId);
                final followingListChanged = prevInFollowing != currInFollowing;

                // Rebuild when loading state changes for THIS specific user
                final loadingChanged =
                    (previous.actionUserId == userData.userId) !=
                        (current.actionUserId == userData.userId);

                return followerListChanged || followingListChanged || loadingChanged;
              },
              builder: (context, state) {
                // ✅ Check BOTH lists — following list is the source of truth
                final isInFollowingList =
                    state.following.any((u) => u.userId == userData.userId);

                final currentUser =
                    state.followers.cast<SocialEntity?>().firstWhere(
                          (u) => u?.userId == userData.userId,
                          orElse: () => null,
                        );

                // Either source confirming we follow = show Following button
                final isCurrentlyFollowing =
                    isInFollowingList ||
                    (currentUser?.isFollowing ?? userData.isFollowing);

                final isActionLoading = state.actionUserId == userData.userId;

                return GestureDetector(
                  onTap: isActionLoading
                      ? null
                      : () {
                          if (isCurrentlyFollowing) {
                            context.read<SocialBloc>().add(
                                  UnfollowUserEvent(userData.userId),
                                );
                          } else {
                            context.read<SocialBloc>().add(
                                  FollowUserEvent(userData.userId),
                                );
                          }
                        },
                  child: _buildActionButton(
                    isCurrentlyFollowing,
                    context,
                    isActionLoading,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStat(String count, String label, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: count,
          fontSize: 14.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
          fontWeight: FontWeight.w700,
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

  Widget _buildActionButton(
    bool isFollowing,
    BuildContext context,
    bool isLoading,
  ) {
    if (isLoading) {
      return Container(
        height: 40.h,
        width: 40.w,
        padding: EdgeInsets.all(8.r),
        child: const CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (isFollowing) {
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