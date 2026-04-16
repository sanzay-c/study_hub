import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class SocialEmpty extends StatelessWidget {
  const SocialEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildIllustration(context),
            40.verticalSpace,
            TextWidget(
              text: 'No users found yet',
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            12.verticalSpace,
            TextWidget(
              text: 'Follow people to see their\nupdates and activity here.',
              fontSize: 16.sp,
              textalign: TextAlign.center,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ).withValues(alpha: 0.7),
            ),
            60.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildIllustration(BuildContext context) {
    // Standardizing Gradient Colors
    final gradientColors = [
      getColorByTheme(context: context, colorClass: AppColors.gr0XFF526DFF),
      getColorByTheme(context: context, colorClass: AppColors.gr0XFF8B32FB),
    ];

    return SizedBox(
      width: 200.w,
      height: 180.h,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Background glow
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gradientColors[0].withValues(alpha: 0.04),
            ),
          ),

          // 2. Random Floating Dots (Static)
          _buildDot(top: 10, left: 30, size: 8, color: gradientColors[0]),
          _buildDot(top: 50, right: 10, size: 12, color: gradientColors[1].withValues(alpha: 0.4)),
          _buildDot(bottom: 20, left: 10, size: 10, color: gradientColors[0].withValues(alpha: 0.3)),
          _buildDot(bottom: 40, right: 40, size: 6, color: gradientColors[1]),

          // 3. Avatar Group (Static)
          // Side User (Back Left)
          Positioned(
            left: 25.w,
            top: 15.h,
            child: _buildAvatar(size: 60.w, iconSize: 28, colors: gradientColors, opacity: 0.12),
          ),
          // Side User (Back Right)
          Positioned(
            right: 25.w,
            top: 40.h,
            child: _buildAvatar(size: 50.w, iconSize: 22, colors: gradientColors, opacity: 0.10),
          ),
          // Main User (Front Center)
          Positioned(
            bottom: 30.h,
            child: _buildAvatar(
              size: 85.w,
              iconSize: 38,
              colors: gradientColors,
              opacity: 0.15,
              hasShadow: true,
            ),
          ),

          // 4. "Add" Badge (Solid Gradient)
          Positioned(
            bottom: 25.h,
            right: 45.w,
            child: Container(
              width: 38.w,
              height: 38.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: gradientColors[0].withValues(alpha: 0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Icon(Icons.person_add_rounded, color: Colors.white, size: 18.sp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({
    required double size,
    required double iconSize,
    required List<Color> colors,
    required double opacity,
    bool hasShadow = false,
  }) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors[0].withValues(alpha: opacity),
        border: Border.all(color: colors[0].withValues(alpha: 0.2), width: 1.5.w),
        boxShadow: hasShadow
            ? [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                )
              ]
            : null,
      ),
      child: Icon(
        Icons.person_rounded,
        size: iconSize.sp,
        color: colors[0].withValues(alpha: 0.5),
      ),
    );
  }

  Widget _buildDot({double? top, double? bottom, double? left, double? right, required double size, required Color color}) {
    return Positioned(
      top: top?.h,
      bottom: bottom?.h,
      left: left?.w,
      right: right?.w,
      child: Container(
        width: size.w,
        height: size.w,
        decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      ),
    );
  }
}