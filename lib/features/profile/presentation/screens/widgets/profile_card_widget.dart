import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class ProfileCardWidget extends StatelessWidget {
  final String username;
  final String fullname;
  final String bio;
  final int followers;
  final int following;
  final int groups;
  final String? avatarUrl;
  final VoidCallback? onEditProfile;
  final VoidCallback? onCameraIconTap;
  final Widget? avatarWidget;

  const ProfileCardWidget({
    super.key,
    required this.username,
    required this.fullname,
    required this.bio,
    required this.followers,
    required this.following,
    required this.groups,
    this.avatarUrl,
    this.onEditProfile,
    this.onCameraIconTap,
    this.avatarWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      
      padding: EdgeInsets.all(24.w),
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
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildProfileAvatar(context),
            16.verticalSpace,
            TextWidget(
              text: username,
              fontSize: 22.sp,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w800,
            ),
            8.verticalSpace,
            TextWidget(
              text: fullname,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700,
            ),
            8.verticalSpace,
            TextWidget(
              text: bio,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ),
              fontSize: 14.sp,
              letterSpacing: 0.5,
            ),
            16.verticalSpace,
            _buildEditProfileButton(context),
            24.verticalSpace,
            Divider(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.dividerColor,
              ),
              thickness: 1,
            ),
            24.verticalSpace,
            _buildStatsRow(context),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileAvatar(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 104.h,
          width: 104.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor),
              style: BorderStyle.solid,
              width: 1.w,
            ),
          ),
          child: ClipOval( // ClipOval use garda image circle vitra ramrari bascha
            child: avatarWidget ?? (avatarUrl != null 
                ? Image.network(
                    avatarUrl!, 
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return SvgImageRenderWidget(
                        svgImagePath: AssetsSource.appIcons.userPersonIcon,
                      );
                    },
                  )
                : SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.userPersonIcon,
                  )), 
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: onCameraIconTap,
            child: Container(
              height: 38.h,
              width: 38.w,
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
                ),
                border: Border.all(
                  color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor),
                  width: 2.w,
                ),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgImageRenderWidget(
                  height: 16.h,
                  width: 16.w,
                  svgImagePath: AssetsSource.appIcons.cameraIcon,
                  svgColor: AppColors.allWhite,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfileButton(BuildContext context) {
    return GestureDetector(
      onTap: onEditProfile,
      child: Container(
        height: 43.h,
        width: 150.w,
        decoration: BoxDecoration(
          color: getColorByTheme(context: context, colorClass: AppColors.containerButton),
          borderRadius: BorderRadius.circular(50.r),
        ),
        child: Center(child: TextWidget(text: 'Edit Profile')),
      ),
    );
  }

  Widget _buildStatsRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildStatColumn('Followers', followers, context),
        _buildStatColumn('Following', following, context),
        _buildStatColumn('Groups', groups, context),
      ],
    );
  }

  Widget _buildStatColumn(String label, int num, BuildContext context) {
    return Column(
      children: [
        TextWidget(text: '$num', fontWeight: FontWeight.w800),
        8.verticalSpace,
        TextWidget(
          text: label,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}
