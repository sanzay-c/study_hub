import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/social/presentation/cubit/user_stats_cubit.dart';
import 'package:study_hub/features/social/presentation/widgets/customized_button.dart';
import 'package:go_router/go_router.dart';
import 'package:study_hub/core/routing/route_name.dart';

class UserDetailsScreen extends StatelessWidget {
  final SocialEntity user;

  const UserDetailsScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<UserStatsCubit>()..fetchStats(user.userId),
      child: Scaffold(
        appBar: StudyHubAppBar(title: 'Profile'),
        backgroundColor: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: _ProfileCard(user: user),
          ),
        ),
      ),
    );
  }
}

class _ProfileCard extends StatelessWidget {
  final SocialEntity user;

  const _ProfileCard({required this.user});

  /// Searches all three social lists to get the freshest copy of this user.
  /// Prioritizes instances where isFollowing is true.
  SocialEntity? _findUser(SocialState state) {
    final allOccurrences = [
      ...state.following,
      ...state.followers,
      ...state.discoverUsers,
    ].where((u) => u.userId == user.userId).toList();

    if (allOccurrences.isEmpty) return null;

    // If we follow them in ANY list, consider it the truth.
    return allOccurrences.firstWhere(
      (u) => u.isFollowing,
      orElse: () => allOccurrences.first,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      buildWhen: (previous, current) {
        final prevUser = _findUser(previous);
        final currUser = _findUser(current);
        return previous.actionUserId == user.userId ||
            current.actionUserId == user.userId ||
            prevUser?.isFollowing != currUser?.isFollowing;
      },
      builder: (context, state) {
        final liveUser = _findUser(state) ?? user;
        final isActionLoading = state.actionUserId == user.userId;

        return Column(
          children: [
            // ── Banner + Avatar ────────────────────────────────────────────
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 120.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
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
                    ),
                  ),
                ),
                Positioned(
                  left: 20.w,
                  bottom: -40.h,
                  child: Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.containerBorderColor,
                        ),
                        width: 4.w,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: liveUser.avatarPath != null
                          ? Image.network(
                              liveUser.avatarPath!,
                              fit: BoxFit.cover,
                              errorBuilder: (_, _, _) =>
                                  _buildAvatarFallback(context),
                            )
                          : _buildAvatarFallback(context),
                    ),
                  ),
                ),
              ],
            ),

            50.verticalSpace,

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ── Username ─────────────────────────────────────────────
                  TextWidget(
                    text: liveUser.username,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w800,
                  ),

                  8.verticalSpace,

                  // ── Stats ─────────────────────────────────────────────────
                  Row(
                    children: [
                      _StatItem(count: liveUser.followers, label: 'Followers'),
                      32.horizontalSpace,
                      _StatItem(count: liveUser.following, label: 'Following'),
                    ],
                  ),

                  24.verticalSpace,

                  // ── Action Buttons ─────────────────────────────────────────
                  Row(
                    children: [
                      Expanded(
                        child: isActionLoading
                            ? const Center(
                                child: SizedBox(
                                  height: 44,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                              )
                            : CustomizedButton(
                                text: liveUser.isFollowing
                                    ? 'Following'
                                    : 'Follow',
                                prefixIcon: liveUser.isFollowing
                                    ? AssetsSource.appIcons.personFollowingIcon
                                    : AssetsSource.appIcons.personFollowIcon,
                                textColor: liveUser.isFollowing
                                    ? getColorByTheme(
                                        context: context,
                                        colorClass: AppColors.textColor,
                                      )
                                    : getColorByTheme(
                                        context: context,
                                        colorClass: AppColors.allWhite,
                                      ),
                                svgColor: liveUser.isFollowing
                                    ? AppColors.appIconColor
                                    : AppColors.allWhite,
                                grColors: liveUser.isFollowing
                                    ? null
                                    : [
                                        getColorByTheme(
                                          context: context,
                                          colorClass: AppColors.gr0XFF526DFF,
                                        ),
                                        getColorByTheme(
                                          context: context,
                                          colorClass: AppColors.gr0XFF8B32FB,
                                        ),
                                      ],
                                containerColor: liveUser.isFollowing
                                    ? getColorByTheme(
                                        context: context,
                                        colorClass: AppColors.containerButton,
                                      )
                                    : null,
                                borderColor: liveUser.isFollowing
                                    ? getColorByTheme(
                                        context: context,
                                        colorClass:
                                            AppColors.containerBorderColor,
                                      )
                                    : null,
                                onTap: () {
                                  if (liveUser.isFollowing) {
                                    context.read<SocialBloc>().add(
                                        UnfollowUserEvent(liveUser.userId));
                                  } else {
                                    context
                                        .read<SocialBloc>()
                                        .add(FollowUserEvent(liveUser.userId));
                                  }
                                },
                              ),
                      ),

                      12.horizontalSpace,

                      Expanded(
                        child: CustomizedButton(
                          text: 'Message',
                          prefixIcon:
                              AssetsSource.bottomNavAssetsSource.chatIcon,
                          textColor: getColorByTheme(
                            context: context,
                            colorClass: AppColors.subTextColor,
                          ),
                          svgColor: AppColors.appIconColor,
                          containerColor: getColorByTheme(
                            context: context,
                            colorClass: AppColors.containerColor,
                          ),
                          borderColor: getColorByTheme(
                            context: context,
                            colorClass: AppColors.containerBorderColor,
                          ),
                          onTap: () {
                            context.pushNamed(
                              RouteName.messagesScreen,
                              extra: {
                                'id': liveUser.userId,
                                'isGroup': false,
                                'title': liveUser.username,
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),

                  24.verticalSpace,

                  // ── About Section (Dynamic Stats) ──────────────────────────
                  Container(
                    width: double.infinity,
                    padding:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
                    decoration: BoxDecoration(
                      color: getColorByTheme(
                        context: context,
                        colorClass: AppColors.containerColor,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.containerBorderColor,
                        ),
                        width: 1.w,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'About',
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                        ),
                        16.verticalSpace,
                        BlocBuilder<UserStatsCubit, UserStatsState>(
                          builder: (context, statsState) {
                            if (statsState is UserStatsLoading) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            }

                            if (statsState is UserStatsError) {
                              return TextWidget(
                                text: 'Failed to load profile info',
                                color: getColorByTheme(context: context, colorClass: AppColors.gr0XFF8B32FB),
                              );
                            }

                            if (statsState is UserStatsLoaded) {
                              final stats = statsState.stats;
                              return Column(
                                children: [
                                  _InfoRow(
                                    icon: AssetsSource.appIcons.messageIcon,
                                    text: stats.email ?? 'Private email',
                                  ),
                                  12.verticalSpace,
                                  _InfoRow(
                                    icon: AssetsSource.appIcons.calendarIcon,
                                    text: stats.joinedDate != null
                                        ? 'Joined ${DateFormat('MMMM yyyy').format(stats.joinedDate!)}'
                                        : 'Member since 2024',
                                  ),
                                ],
                              );
                            }

                            return const SizedBox.shrink();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAvatarFallback(BuildContext context) {
    return Container(
      color: getColorByTheme(
        context: context,
        colorClass: AppColors.containerColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          AssetsSource.appIcons.userPersonIcon,
          width: 50.r,
          height: 50.r,
          colorFilter: ColorFilter.mode(
            getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: count,
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
        ),
        2.verticalSpace,
        TextWidget(
          text: label,
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 20.h,
          width: 20.w,
          child: SvgImageRenderWidget(svgImagePath: icon),
        ),
        12.horizontalSpace,
        TextWidget(
          text: text,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}
