import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class MemberTile extends StatelessWidget {
  final String name;
  final String status;
  final bool isOnline;
  final bool isOwner;

  const MemberTile({
    super.key,
    required this.name,
    required this.status,
    required this.isOnline,
    required this.isOwner,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          _OnlineAvatarStack(isOnline: isOnline, context: context),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(text: name, fontWeight: FontWeight.w600),
                    if (isOwner) ...[
                      4.horizontalSpace,
                      SvgImageRenderWidget(
                        svgImagePath: AssetsSource.appIcons.crownIcon,
                        height: 16.h,
                        width: 16.w,
                        svgColor: AppColors.crownColor,
                      ),
                    ],
                  ],
                ),
                TextWidget(
                  text: status,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.subTextColor,
                  ),
                  fontSize: 13.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OnlineAvatarStack extends StatelessWidget {
  final bool isOnline;
  final BuildContext context;

  const _OnlineAvatarStack({required this.isOnline, required this.context});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CircleAvatar(radius: 24.r, backgroundColor: Colors.grey[300]),
        if (isOnline)
          Positioned(
            bottom: 0,
            right: 0,
            child: Container(
              height: 12.h,
              width: 12.h,
              decoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
                border: Border.all(
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.allWhite,
                  ),
                  width: 2.w,
                ),
              ),
            ),
          ),
      ],
    );
  }
}