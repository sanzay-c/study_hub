import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class GroupActionButton extends StatelessWidget {
  final String label;
  final bool isPrimary;
  final IconData? icon;
  final Color? backgroundColor;
  final VoidCallback? onTap;

  const GroupActionButton({
    super.key,
    required this.label,
    required this.isPrimary,
    this.icon,
    this.backgroundColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(14.r),
          gradient: isPrimary
              ? LinearGradient(
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
                )
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              SvgImageRenderWidget(
                svgImagePath: AssetsSource.bottomNavAssetsSource.chatIcon,
                svgColor: AppColors.allWhite,
                height: 18.h,
                width: 18.w,
              ),
              8.horizontalSpace,
            ],
            TextWidget(
              text: label,
              fontWeight: FontWeight.bold,
              color: isPrimary
                  ? getColorByTheme(
                      context: context,
                      colorClass: AppColors.allWhite,
                    )
                  : getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
            ),
          ],
        ),
      ),
    );
  }
}