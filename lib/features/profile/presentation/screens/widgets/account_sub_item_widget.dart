import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';

class AccountSubItemWidget extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final IconData icon;
  final bool isDestructive;

  const AccountSubItemWidget({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(
          left: 56.w,
          right: 20.w,
          bottom: 16.h,
          top: 8.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isDestructive ? Colors.red : null,
              size: 20.sp,
            ),
            8.horizontalSpace,
            TextWidget(
              text: title,
              color: isDestructive ? Colors.red : null,
              fontWeight: isDestructive ? FontWeight.w600 : null,
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}