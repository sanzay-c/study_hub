import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PageIndicator extends StatelessWidget {
  final int activeIndex; 
  final int count;

  const PageIndicator({
    super.key,
    required this.activeIndex,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        bool isActive = index == activeIndex;
        
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 3.5.w),
          height: 8.h,
          // Expand width if active, keep it small if not
          width: isActive ? 32.w : 9.w, 
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: isActive ? null : const Color(0XFFD1D5DC),
            gradient: isActive 
              ? const LinearGradient(colors: [Color(0XFF526DFF), Color(0XFF8B32FB)]) 
              : null,
          ),
        );
      }),
    );
  }
}