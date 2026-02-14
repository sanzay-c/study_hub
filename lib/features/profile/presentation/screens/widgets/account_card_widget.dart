import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class AccountCardWidget extends StatelessWidget {
  final String label;

  const AccountCardWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(context: context, colorClass: AppColors.containerColor),
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor), width: 1.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: TextWidget(
              text: label,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          _buildAccountItem(
            context,
            () {},
            AssetsSource.appIcons.userPersonIcon,
            'Edit Profile',
          ),
          _buildAccountItem(
            context,
            () {},
            AssetsSource.appIcons.notificationIcon,
            'Notification',
          ),
          _buildAccountItem(
            context,
            () {},
            AssetsSource.appIcons.privacyIcon,
            'Privacy & Security',
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildAccountItem(
    BuildContext context,
    void Function()? onTap,
    String svgImagePath,
    String title, {
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Divider(color: getColorByTheme(context: context, colorClass: AppColors.dividerColor), height: 1.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Row(
              children: [
                SvgImageRenderWidget(
                  svgImagePath: svgImagePath,
                  height: 20.h,
                  width: 20.w,
                ),
                16.horizontalSpace,
                TextWidget(text: title),
                const Spacer(),
                SvgImageRenderWidget(
                  svgImagePath: AssetsSource.appIcons.arrowForward,
                  height: 12.h,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
