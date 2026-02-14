import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_hub/common/model/color_model.dart';
import 'package:study_hub/core/constants/app_color.dart';

class SvgImageRenderWidget extends StatelessWidget {
  final String svgImagePath;
  final double? height;
  final double? width;
  final ColorModel? svgColor;
  final bool applyColorFilter;

  const SvgImageRenderWidget({
    super.key,
    required this.svgImagePath,
    this.height,
    this.width,
    this.svgColor,
    this.applyColorFilter = true,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = getColorByTheme(
      context: context,
      colorClass: svgColor ?? AppColors.appIconColor,
    );

    return SvgPicture.asset(
      svgImagePath,
      height: height ?? 24.h,
      width: width ?? 24.w,
      fit: BoxFit.contain,
      colorFilter: applyColorFilter
          ? ColorFilter.mode(color, BlendMode.srcIn)
          : null,
    );
  }
}
