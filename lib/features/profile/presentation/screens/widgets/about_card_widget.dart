import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class AboutCardWidget extends StatelessWidget {
  final String label;

  const AboutCardWidget({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
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
            child: Row(
              children: [
                SvgImageRenderWidget(
                  svgImagePath: AssetsSource.appIcons.infoIcon,
                  height: 20.h,
                  width: 20.w,
                ),
                16.horizontalSpace,
                TextWidget(text: label),
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
