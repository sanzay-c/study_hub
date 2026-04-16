import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class ChatEmptyState extends StatelessWidget {
  const ChatEmptyState({super.key});

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
              text: 'No active chats',
              fontSize: 26.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: -0.5,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.textColor,
              ),
            ),
            12.verticalSpace,
            TextWidget(
              text:
                  'Your conversations with groups and\nfriends will appear here.',
              fontSize: 16.sp,
              textalign: TextAlign.center,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ).withValues(alpha: 0.7),
            ),
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
      width: 220.w,
      height: 180.h,
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // 1. Background soft glow circle
          Container(
            width: 150.w,
            height: 150.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: gradientColors[0].withValues(alpha: 0.04),
            ),
          ),

          // 2. Floating Dots (Chat "particles")
          _buildDot(top: 10, left: 50, size: 8, color: gradientColors[0]),
          _buildDot(
            top: 50,
            right: 20,
            size: 12,
            color: gradientColors[1].withValues(alpha: 0.4),
          ),
          _buildDot(
            bottom: 30,
            left: 30,
            size: 10,
            color: gradientColors[0].withValues(alpha: 0.3),
          ),
          _buildDot(bottom: 15, right: 60, size: 7, color: gradientColors[1]),

          // 3. Chat Bubbles Group
          // Back Bubble (Small & Faded)
          Positioned(
            right: 40.w,
            top: 30.h,
            child: _buildChatBubble(
              width: 60.w,
              height: 45.h,
              colors: gradientColors,
              opacity: 0.10,
              rotation: 0.15,
              icon: Icons.chat_bubble_outline_rounded,
            ),
          ),

          // Main Center Bubble
          Positioned(
            bottom: 40.h,
            child: _buildChatBubble(
              width: 90.w,
              height: 70.h,
              colors: gradientColors,
              opacity: 0.15,
              hasShadow: true,
              icon: Icons.forum_rounded,
            ),
          ),

          // 4. "Active" Badge (Online/Message Status indicator)
          Positioned(
            bottom: 35.h,
            right: 45.w,
            child: Container(
              width: 42.w,
              height: 42.w,
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
                Icons.add_comment_rounded,
                color: Colors.white,
                size: 20.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatBubble({
    required double width,
    required double height,
    required List<Color> colors,
    required double opacity,
    required IconData icon,
    double rotation = 0,
    bool hasShadow = false,
  }) {
    return Transform.rotate(
      angle: rotation,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(4.r), // Chat bubble "tail" look
          ),
          color: colors[0].withValues(alpha: opacity),
          border: Border.all(color: colors[0].withValues(alpha: 0.2), width: 1.5.w),
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
          icon,
          size: (width * 0.4).sp,
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
