import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class EmptyMessageState extends StatelessWidget {

  const EmptyMessageState({
    super.key,
  });

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
              text: 'No messages yet',
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
            ),
            12.verticalSpace,
            TextWidget(
              text:'Your conversations\nwill show up here, Say something to start\nthe conversation!',
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
          // Background soft glow
          Container(
            width: 140.w,
            height: 140.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gradientColors[0].withValues(alpha: 0.04),
            ),
          ),

          // Floating dots
          _buildDot(top: 5, left: 40, size: 8, color: gradientColors[0]),
          _buildDot(top: 45, right: 15, size: 12, color: gradientColors[1].withValues(alpha: 0.4)),
          _buildDot(bottom: 25, left: 20, size: 10, color: gradientColors[0].withValues(alpha: 0.3)),
          _buildDot(bottom: 10, right: 50, size: 7, color: gradientColors[1]),
          _buildDot(top: 80, left: -5, size: 5, color: gradientColors[0].withValues(alpha: 0.5)),

          // Small back chat bubble (tilted)
          Positioned(
            right: 30.w,
            top: 20.h,
            child: _buildBubbleIcon(
              size: 55.w,
              iconSize: 24,
              colors: gradientColors,
              opacity: 0.10,
              rotation: 0.2,
            ),
          ),

          // Main center chat bubble
          Positioned(
            bottom: 30.h,
            child: _buildBubbleIcon(
              size: 88.w,
              iconSize: 40,
              colors: gradientColors,
              opacity: 0.15,
              hasShadow: true,
            ),
          ),

          // Send badge (gradient circle)
          Positioned(
            bottom: 22.h,
            right: 36.w,
            child: Container(
              width: 40.w,
              height: 40.w,
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
              child: Icon(
                Icons.send_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBubbleIcon({
    required double size,
    required double iconSize,
    required List<Color> colors,
    required double opacity,
    double rotation = 0,
    bool hasShadow = false,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: colors[0].withValues(alpha: opacity),
          border: Border.all(
            color: colors[0].withValues(alpha: 0.2),
            width: 1.5.w,
          ),
          boxShadow: hasShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  ),
                ]
              : null,
        ),
        child: Icon(
          Icons.chat_bubble_outline_rounded,
          size: iconSize.sp,
          color: colors[0].withValues(alpha: 0.5),
        ),
      ),
    );
  }

  Widget _buildDot({
    double? top,
    double? bottom,
    double? left,
    double? right,
    required double size,
    required Color color,
  }) {
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