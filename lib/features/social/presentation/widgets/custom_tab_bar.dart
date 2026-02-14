import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/core/constants/app_color.dart';

class CustomTabBar extends StatelessWidget {
  final TabController controller;
  final List<String> tabs;

  const CustomTabBar({super.key, required this.controller, required this.tabs});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Row(
          children: List.generate(tabs.length, (index) {
            final animationValue = (controller.animation!.value - index).abs();
            final progress = (1 - animationValue.clamp(0.0, 1.0));

            return Expanded(
              child: GestureDetector(
                onTap: () => controller.animateTo(index),
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 8.w),
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.containerButton,
                          ),
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.gr0XFF526DFF,
                          ),
                          progress,
                        )!,
                        Color.lerp(
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.containerButton,
                          ),
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.gr0XFF8B32FB,
                          ),
                          progress,
                        )!,
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Center(
                    child: Text(
                      tabs[index],
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.lerp(
                          FontWeight.w400,
                          FontWeight.w600,
                          progress,
                        ),
                        color: Color.lerp(
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.subTextColor,
                          ),
                          getColorByTheme(
                            context: context,
                            colorClass: AppColors.allWhite,
                          ),
                          progress,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}