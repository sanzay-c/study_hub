import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class AppearanceCardWidget extends StatelessWidget {
  final String title;
  final String label;
  final bool value;
  final String activeIcon;
  final String inactiveIcon;
  final ValueChanged<bool> onChanged;

  const AppearanceCardWidget({
    super.key,
    required this.title,
    required this.label,
    required this.value,
    required this.activeIcon,
    required this.inactiveIcon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: getColorByTheme(context: context, colorClass: AppColors.containerColor),
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor), width: 1.w),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: TextWidget(
                text: title,
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
              ),
            ),

            Divider(
              color: getColorByTheme(context: context, colorClass: AppColors.dividerColor),
              height: 1.h,
              thickness: 1.w,
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                children: [
                  SvgImageRenderWidget(
                    height: 20.h,
                    width: 20.w,
                    svgImagePath: value ? activeIcon : inactiveIcon,
                  ),

                  14.horizontalSpace,

                  TextWidget(text: label),

                  const Spacer(),
                  
                  Transform.scale(
                    scale: 0.8,
                    child: CupertinoSwitch(
                      value: value,
                      activeTrackColor: const Color(0xFF6A9BEE),
                      inactiveTrackColor: const Color(0xFFE5E7EB),
                      onChanged: onChanged,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
