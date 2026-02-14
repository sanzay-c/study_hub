import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';

class LogoContainer extends StatelessWidget {
  final List<Color> gradienColor;

  const LogoContainer({super.key, required this.gradienColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 80.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradienColor,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Center(
        child: TextWidget(
          text: "SH",
          fontSize: 40.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
