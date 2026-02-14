import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CommonButton extends StatelessWidget {
  final String text;
  final double? fontSize;
  final IconData? icon;
  final VoidCallback onTap;
  final List<Color>? color;
  final bool isLoading;

  const CommonButton({
    super.key,
    required this.text,
    this.fontSize,
    this.icon,
    required this.onTap,
    this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        width: double.infinity,
        height: 60.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: color ?? [],
          ),
          borderRadius: BorderRadius.circular(16.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 20.w,
                height: 20.h,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              10.horizontalSpace,
            ],
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: fontSize ?? 18.sp,
              ),
            ),
            if (icon != null && !isLoading) ...[
              10.horizontalSpace,
              Icon(icon, color: Colors.white, size: 18.sp),
            ],
          ],
        ),
      ),
    );
  }
}