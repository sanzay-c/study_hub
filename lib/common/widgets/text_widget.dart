import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/core/constants/app_color.dart';

class TextWidget extends StatelessWidget {
  final String text;
  final TextAlign? textalign;
  final Color? color;
  final FontWeight? fontWeight;
  final double? fontSize;
  final double? letterSpacing;
  final int? maxLines;
  final TextOverflow? textOverflow;
  
  // RichText support
  final String? highlightText;
  final Color? highlightColor;
  final FontWeight? highlightFontWeight;
  final VoidCallback? onHighlightTap;

  const TextWidget({
    super.key,
    required this.text,
    this.textalign,
    this.color,
    this.fontWeight,
    this.fontSize,
    this.highlightText,
    this.highlightColor,
    this.highlightFontWeight,
    this.onHighlightTap,
    this.letterSpacing,
    this.maxLines,
    this.textOverflow,
  });

  @override
  Widget build(BuildContext context) {
    // If no highlight text, return regular Text widget
    if (highlightText == null || !text.contains(highlightText!)) {
      return Text(
        text,
        textAlign: textalign,
        maxLines: maxLines ,
        overflow: textOverflow ,
        style: TextStyle(
          color: color ?? getColorByTheme(context: context, colorClass: AppColors.textColor),
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: fontSize ?? 16.sp,
          letterSpacing: letterSpacing,
        ),
      );
    }

    // Split text into parts
    final parts = text.split(highlightText!);
    
    return GestureDetector(
      onTap: onHighlightTap,
      child: RichText(
        textAlign: textalign ?? TextAlign.start,
        text: TextSpan(
          style: TextStyle(
            color: color ?? Colors.black,
            fontWeight: fontWeight,
            fontSize: fontSize ?? 18.sp,
          ),
          children: [
            TextSpan(text: parts[0]),
            TextSpan(
              text: highlightText,
              style: TextStyle(
                color: highlightColor ?? Color(0XFF526DFF),
                fontWeight: highlightFontWeight ?? FontWeight.w700,
              ),
            ),
            if (parts.length > 1) TextSpan(text: parts[1]),
          ],
        ),
      ),
    );
  }
}