import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/model/color_model.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';

class CustomizedButton extends StatelessWidget {
  final String text;
  final String? prefixIcon;
  final Color? textColor;
  final Color? borderColor;
  final Color? containerColor;
  final List<Color>? grColors;
  final ColorModel? svgColor;
  final VoidCallback? onTap;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CustomizedButton({
    super.key,
    required this.text,
    this.prefixIcon,
    this.textColor,
    this.svgColor,
    this.borderColor,
    this.grColors,
    this.containerColor,
    this.onTap,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: containerColor,
          gradient: grColors != null && grColors!.length >= 2
              ? LinearGradient(
                  colors: grColors!,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
              : null,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: borderColor ?? Colors.transparent,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (prefixIcon != null) ...[
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: SvgImageRenderWidget(
                  svgImagePath: prefixIcon!,
                  svgColor: svgColor,
                ),
              ),
              8.horizontalSpace,
            ],
            TextWidget(
              text: text,
              color: textColor,
              fontSize:  18.sp,
              fontWeight: fontWeight ?? FontWeight.w600,
            ),
          ],
        ),
      ),
    );
  }
}