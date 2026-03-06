import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/groups/presentation/widgets/group_action_button.dart';

class GroupMainInfoCard extends StatelessWidget {
  final String groupName;
  final String description;
  final String createdBy;
  final int memberCount;
  final VoidCallback onChat;
  final VoidCallback onLeave;

  const GroupMainInfoCard({
    super.key,
    required this.groupName,
    required this.description,
    required this.memberCount,
    required this.onChat,
    required this.onLeave,
    required this.createdBy,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
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
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: groupName,
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.6,
          ),
          8.verticalSpace,
          TextWidget(text: description),
          
          16.verticalSpace,
          Row(
            children: [
              SvgImageRenderWidget(
                svgImagePath: AssetsSource.bottomNavAssetsSource.socialIcon,
                height: 18.h,
                width: 18.w,
              ),
              8.horizontalSpace,
              TextWidget(text: "$memberCount members"),
            ],
          ),
          8.verticalSpace,
          TextWidget(text: "Created By: $createdBy", fontWeight: FontWeight.bold,),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: GroupActionButton(
                  label: "Chat",
                  isPrimary: true,
                  icon: Icons.chat_bubble_outline,
                  onTap: onChat,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: GroupActionButton(
                  label: "Leave",
                  isPrimary: false,
                  backgroundColor: getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerInput,
                  ),
                  onTap: onLeave,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
