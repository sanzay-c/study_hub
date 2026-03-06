import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class NoteTile extends StatelessWidget {
  final String title;
  final String subtitle;

  const NoteTile({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerInput,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          _NoteIconBox(),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
                TextWidget(
                  text: 'uploaded by: $subtitle',
                  fontSize: 12.sp,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.subTextColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NoteIconBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: SvgImageRenderWidget(
        svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
        svgColor: AppColors.allRed,
        height: 24.h,
        width: 24.w,
      ),
    );
  }
}