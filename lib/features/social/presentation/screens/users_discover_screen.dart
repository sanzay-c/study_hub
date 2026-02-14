import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

class UsersDiscoverScreen extends StatelessWidget {
  const UsersDiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> dummyUsers = [
      {
        'name': 'Micheal Chen',
        'bio': 'Math enthusiast...',
        'followers': '234',
        'following': '145',
        'isFollowing': false,
        'image': null,
      },
      {
        'name': 'Micheal Chen',
        'bio': 'Math enthusiast...',
        'followers': '234',
        'following': '145',
        'isFollowing': true,
        'image': null,
      },
      {
        'name': 'Sanjay Chaudhary',
        'bio': 'Math enthusiast...',
        'followers': '234',
        'following': '145',
        'isFollowing': false,
        'image': null,
      },
    ];

    return ListView.builder(
      itemCount: dummyUsers.length,
      itemBuilder: (context, index) {
        return UserProfileCard(userData: dummyUsers[index]);
      },
    );
  }
}

class UserProfileCard extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserProfileCard({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    bool isFollowing = userData['isFollowing'] ?? false;

    return GestureDetector(
      onTap: () =>
          getIt<NavigationService>().pushNamed(RouteName.userDetailsScreen),
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
              backgroundColor: const Color(0xFFE0E0E0),
              backgroundImage: userData['image'] != null
                  ? NetworkImage(userData['image'])
                  : null,
            ),
            8.horizontalSpace,

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: userData['name'],
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                  4.verticalSpace,
                  TextWidget(
                    text: userData['bio'],
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
                      _buildStat(userData['followers'], 'followers', context),
                      24.horizontalSpace,
                      _buildStat(userData['following'], 'following', context),
                    ],
                  ),
                ],
              ),
            ),

            _buildActionButton(isFollowing, context),
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

  Widget _buildActionButton(bool isFollowing, BuildContext context) {
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
