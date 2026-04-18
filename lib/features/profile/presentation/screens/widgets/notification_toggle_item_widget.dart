import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';

class NotificationToggleItemWidget extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;

  const NotificationToggleItemWidget({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 56.w,
        right: 20.w,
        bottom: 16.h,
        top: 4.h,
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: Colors.grey,
          ),
          8.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(text: title),
              if (subtitle != null)
                TextWidget(
                  text: subtitle!,
                  fontSize: 12.sp,
                  color: Colors.grey,
                ),
            ],
          ),
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
    );
  }
}