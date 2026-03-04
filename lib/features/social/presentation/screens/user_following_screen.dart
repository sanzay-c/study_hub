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

class UserFollowingScreen extends StatefulWidget {
  const UserFollowingScreen({super.key});

  @override
  State<UserFollowingScreen> createState() => _UserFollowingScreenState();
}

class _UserFollowingScreenState extends State<UserFollowingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(GetSocialFollowingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.following.isEmpty) {
          return const SocialShimmer();
        }

        if (state.status == SocialStatus.error && state.following.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }

        if (state.following.isEmpty) {
          return const Center(child: Text('No such user found'));
        }

        return CustomDotsRefreshIndicator(
          onRefresh: () async {
              context.read<SocialBloc>().add(GetSocialFollowingEvent());
            },
          child: ListView.builder(
            itemCount: state.following.length,
            itemBuilder: (context, index) {
              return _FollowingUserCard(userData: state.following[index]);
            },
          ),
        );
      },
    );
  }
}

/// A card for use in the Following tab.
/// Every user shown here is ALWAYS someone the current user follows,
/// so the button always shows "Following" and always triggers an unfollow.
class _FollowingUserCard extends StatelessWidget {
  final SocialEntity userData;

  const _FollowingUserCard({required this.userData});

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

            // Since this is the Following tab, every user here is someone we follow.
            // The button ALWAYS shows "Following" and ALWAYS triggers an unfollow.
            BlocBuilder<SocialBloc, SocialState>(
              // Only rebuild this button when THIS user's action state changes.
              buildWhen: (previous, current) =>
                  previous.actionUserId == userData.userId ||
                  current.actionUserId == userData.userId,
              builder: (context, state) {
                final isActionLoading = state.actionUserId == userData.userId;
                if (isActionLoading) {
                  return Container(
                    height: 40.h,
                    width: 40.w,
                    padding: EdgeInsets.all(8.r),
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  );
                }
                // Always the "Following" button — tap to unfollow.
                return GestureDetector(
                  onTap: () {
                    context
                        .read<SocialBloc>()
                        .add(UnfollowUserEvent(userData.userId));
                  },
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
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
                          svgImagePath:
                              AssetsSource.appIcons.personFollowingIcon,
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
}
