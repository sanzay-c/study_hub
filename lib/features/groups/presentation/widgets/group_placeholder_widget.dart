import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/core/constants/app_color.dart';

class GroupPlaceholderWidget extends StatelessWidget {
  const GroupPlaceholderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 140.h,
      width: double.infinity,
      child: Stack(
        children: [
          Container(
            height: 140.h,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          Positioned(
            top: -30.h,
            right: -30.w,
            child: Container(
              width: 120.w,
              height: 120.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.06),
              ),
            ),
          ),

          Positioned(
            bottom: -40.h,
            left: -20.w,
            child: Container(
              width: 140.w,
              height: 140.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),

          Positioned(
            top: 20.h,
            left: 20.w,
            child: Container(
              width: 50.w,
              height: 50.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.groups_rounded,
                  size: 64.sp,
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
