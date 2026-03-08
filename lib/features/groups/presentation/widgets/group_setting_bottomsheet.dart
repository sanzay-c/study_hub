import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class GroupSettingsBottomSheet extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onEdit;
  final bool isOwner;

  const GroupSettingsBottomSheet({
    super.key,
    required this.onDelete,
    required this.onEdit,
    required this.isOwner,
  });

  static Future<void> show({
    required BuildContext context,
    required VoidCallback onDelete,
    required VoidCallback onEdit,
    required bool isOwner,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => GroupSettingsBottomSheet(
        onDelete: onDelete,
        onEdit: onEdit,
        isOwner: isOwner,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle
          Center(
            child: Container(
              width: 40.w,
              height: 4.h,
              margin: EdgeInsets.only(bottom: 20.h),
              decoration: BoxDecoration(
                color: Colors.grey[400],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          
          _buildOption(
            context,
            icon: Icons.edit_outlined,
            title: "Edit Group Details",
            subtitle: "Update name, photo, and description",
            onTap: () {
              Navigator.pop(context);
              onEdit();
            },
          ),
          
          if (isOwner) ...[
            12.verticalSpace,
            _buildOption(
              context,
              icon: Icons.delete_outline,
              title: "Delete Group",
              subtitle: "Permanently remove this group",
              isDanger: true,
              onTap: () {
                Navigator.pop(context);
                onDelete();
              },
            ),
          ],
          
          30.verticalSpace,
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    bool isDanger = false,
  }) {
    final color = isDanger ? Colors.red : AppColors.appIconColor;
    
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          border: Border.all(
            color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor),
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Icon(icon, color: isDanger ? Colors.red : null, size: 24.sp),
            16.horizontalSpace,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: title,
                    fontWeight: FontWeight.w600,
                    color: isDanger ? Colors.red : null,
                  ),
                  TextWidget(
                    text: subtitle,
                    fontSize: 12.sp,
                    color: getColorByTheme(context: context, colorClass: AppColors.subTextColor),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 14.sp, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}