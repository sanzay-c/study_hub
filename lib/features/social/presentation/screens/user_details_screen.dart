import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/social/presentation/widgets/customized_button.dart';

class UserDetailsScreen extends StatelessWidget {
  const UserDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StudyHubAppBar(title: 'Profile'),
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ProfileCard(
            name: 'Micheal Chen',
            bio: 'Math enthusiast |Teaching assistant',
            email: 'micheal.c@gmail.com',
            joinDate: 'Joined January 2024',
            followers: 234,
            following: 145,
            groups: 12,
            avatarUrl:
                'https://images.unsplash.com/photo-1518199266791-5375a83190b7?w=400',
          ),
        ),
      ),
    );
  }
}

// ✅ MADE STATEFUL
class ProfileCard extends StatefulWidget {
  final String name;
  final String bio;
  final String email;
  final String joinDate;
  final int followers;
  final int following;
  final int groups;
  final String avatarUrl;

  const ProfileCard({
    super.key,
    required this.name,
    required this.bio,
    required this.email,
    required this.joinDate,
    required this.followers,
    required this.following,
    required this.groups,
    required this.avatarUrl,
  });

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  late bool isFollowing;
  late int followerCount;

  @override
  void initState() {
    super.initState();
    isFollowing = false; // Initial state: not following
    followerCount = widget.followers;
  }

  void _toggleFollow() {
    setState(() {
      if (isFollowing) {
        // Unfollow
        isFollowing = false;
        followerCount--;
      } else {
        // Follow
        isFollowing = true;
        followerCount++;
      }
    });

    // TODO: When API is ready, call it here
    // await userRepository.toggleFollow(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipOval(
                  child: Image.network(
                    widget.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.person,
                          size: 50.sp,
                          color: Colors.grey[600],
                        ),
                      );
                    },
                  ),
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
              TextWidget(
                text: widget.name,
                fontSize: 24.sp,
                fontWeight: FontWeight.w800,
              ),

              8.verticalSpace,

              TextWidget(
                text: widget.bio,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
              ),

              8.verticalSpace,

              // ✅ UPDATED: Use dynamic follower count
              Row(
                children: [
                  _StatItem(count: followerCount, label: 'Followers'),
                  32.horizontalSpace,
                  _StatItem(count: widget.following, label: 'Following'),
                  32.horizontalSpace,
                  _StatItem(count: widget.groups, label: 'Groups'),
                ],
              ),

              24.verticalSpace,

              // ✅ UPDATED: Dynamic Follow Button
              Row(
                children: [
                  Expanded(
                    child: CustomizedButton(
                      text: isFollowing ? "Following" : "Follow",
                      prefixIcon: isFollowing
                          ? AssetsSource.appIcons.personFollowingIcon
                          : AssetsSource.appIcons.personFollowIcon,
                      textColor: isFollowing
                          ? getColorByTheme(
                              context: context,
                              colorClass: AppColors.subTextColor,
                            )
                          : getColorByTheme(
                              context: context,
                              colorClass: AppColors.allWhite,
                            ),
                      svgColor: isFollowing
                          ? AppColors.appIconColor
                          : AppColors.allWhite,
                      grColors: isFollowing
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
                      containerColor: isFollowing
                          ? getColorByTheme(
                              context: context,
                              colorClass: AppColors.containerColor,
                            )
                          : null,
                      borderColor: isFollowing
                          ? getColorByTheme(
                              context: context,
                              colorClass: AppColors.containerBorderColor,
                            )
                          : null,
                      onTap: _toggleFollow, // ✅ ADDED
                    ),
                  ),

                  12.horizontalSpace,

                  Expanded(
                    child: CustomizedButton(
                      text: "Message",
                      prefixIcon: AssetsSource.bottomNavAssetsSource.chatIcon,
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
                        // Handle message action
                      },
                    ),
                  ),
                ],
              ),

              16.verticalSpace,

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
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
                    _InfoRow(
                      icon: AssetsSource.appIcons.messageIcon,
                      text: widget.email,
                    ),
                    12.verticalSpace,
                    _InfoRow(
                      icon: AssetsSource.appIcons.calendarIcon,
                      text: widget.joinDate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final int count;
  final String label;

  const _StatItem({required this.count, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: count.toString(),
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
