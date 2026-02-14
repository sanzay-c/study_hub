import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color? color; 
  final double? radius;
  final List<Color>? gradientColor;
  final Widget? child; 

  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    this.color,
    this.radius,
    this.gradientColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: gradientColor == null ? color : null, 
        gradient: gradientColor != null
            ? LinearGradient(colors: gradientColor!)
            : null,
        borderRadius: BorderRadius.circular(radius ?? 3.r),
      ),
      child: child != null ? Center(child: child) : null,
    );
  }
}
