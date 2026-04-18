import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class AccountItemWidget extends StatelessWidget {
  final void Function()? onTap;
  final String svgImagePath;
  final String title;

  const AccountItemWidget({
    super.key,
    required this.onTap,
    required this.svgImagePath,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Divider(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
            height: 1.h,
          ),
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