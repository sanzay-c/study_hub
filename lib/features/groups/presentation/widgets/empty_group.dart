import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class EmptyGroup extends StatelessWidget {
  const EmptyGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildStaticOrb(context),
            40.verticalSpace,
            TextWidget(
              text: 'No groups yet',
              fontSize: 28.sp,
              fontWeight: FontWeight.w700,
            ),
            12.verticalSpace,
            TextWidget(
              text: 'Be the first to build your\nlearning community here.',
              fontSize: 16.sp,
              textalign: TextAlign.center,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ).withValues(alpha: 0.8),
            ),
            60.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildStaticOrb(BuildContext context) {
    return SizedBox(
      width: 220.w,
      height: 220.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer Soft Ring
          Container(
            width: 200.w,
            height: 200.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF526DFF).withValues(alpha: 0.06),
            ),
          ),

          // Mid Soft Ring
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF526DFF).withValues(alpha: 0.10),
            ),
          ),

          // Core Gradient Orb
          Container(
            width: 95.w,
            height: 95.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF526DFF).withValues(alpha: 0.3),
                  blurRadius: 25,
                  spreadRadius: 2,
                  offset: const Offset(0, 10),
                ),
              ],
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
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
              ),
            ),
            child: Icon(Icons.groups_rounded, color: Colors.white, size: 44.sp),
          ),

          // Random Decorative Dots (Static)
          // Top Left Small Dot
          _buildRandomDot(
            top: 30.h,
            left: 45.w,
            size: 8,
            color: const Color(0xFF526DFF),
          ),

          // Top Right Medium Dot
          _buildRandomDot(
            top: 50.h,
            right: 35.w,
            size: 12,
            color: const Color(0xFF8B32FB).withValues(alpha: 0.4),
          ),

          // Bottom Left Medium Dot
          _buildRandomDot(
            bottom: 45.h,
            left: 35.w,
            size: 10,
            color: const Color(0xFF526DFF).withValues(alpha: 0.5),
          ),

          // Bottom Right Small Dot
          _buildRandomDot(
            bottom: 30.h,
            right: 45.w,
            size: 8,
            color: const Color(0xFF8B32FB).withValues(alpha: 0.6),
          ),

          // Extra tiny dot for detail
          _buildRandomDot(
            top: 100.h,
            right: 15.w,
            size: 6,
            color: const Color(0xFF526DFF).withValues(alpha: 0.3),
          ),
        ],
      ),
    );
  }

  Widget _buildRandomDot({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}