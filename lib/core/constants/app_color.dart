import 'package:flutter/material.dart';
import 'package:study_hub/common/model/color_model.dart';

class AppColors {
  AppColors._();

  static ColorModel backgroundColor = ColorModel(
    lightModeColor: const Color.fromARGB(255, 255, 255, 255),
    darkModeColor: Color(0XFF0F172B),
  );

  static ColorModel appBarColor = ColorModel(
    lightModeColor: const Color.fromARGB(255, 255, 255, 255),
    darkModeColor: Color(0XFF0F172B),
  );

  static ColorModel appBarBorderColor = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFF314158),
  );

  static ColorModel textColor = ColorModel(
    lightModeColor: Color(0XFF000000),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel subTextColor = ColorModel(
    lightModeColor: Color(0XFF4A5566),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel containerColor = ColorModel(
    lightModeColor: Color(0XFFFFFFFF),
    darkModeColor: Color(0xFF1D293D),
  );

  static ColorModel containerBorderColor = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel dividerColor = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel containerButton = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFF314158),
  );

  static ColorModel containerInput = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFF314158),
  );

  static ColorModel containerTypeText = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFF314158),
  );

  static ColorModel bottomNav = ColorModel(
    lightModeColor: Color(0XFFFFFFFF),
    darkModeColor: Color(0XFF0F172B),
  );

  static ColorModel bottomNavBorder = ColorModel(
    lightModeColor: Color(0XFFE5E7EB),
    darkModeColor: Color(0XFF314158),
  );

  static ColorModel appIconColor   = ColorModel(
    lightModeColor: Color(0XFF4A5566),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel allWhite   = ColorModel(
    lightModeColor: Color(0XFFFFFFFF),
    darkModeColor: Color(0XFFFFFFFF),
  );

  static ColorModel allRed   = ColorModel(
    lightModeColor: Color(0XFFEB000B),
    darkModeColor: Color(0XFFEB000B),
  );

  static ColorModel crownColor   = ColorModel(
    lightModeColor: Color(0XFFF2BB20),
    darkModeColor: Color(0XFFF2BB20),
  );

  static ColorModel containerOrangeColor   = ColorModel(
    lightModeColor: Color(0XFFFF6737),
    darkModeColor: Color(0XFFFF6737),
  );


  static ColorModel gr0XFF526DFF = ColorModel(
    lightModeColor: Color(0XFF526DFF),
    darkModeColor: Color(0XFF526DFF),
  );

  static ColorModel gr0XFF8B32FB = ColorModel(
    lightModeColor: Color(0XFF8B32FB),
    darkModeColor: Color(0XFF8B32FB),
  );
}

extension ThemeContextExtension on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;
}

Color getColorByTheme({
  required BuildContext context,
  required ColorModel? colorClass,
  Color fallbackLight = Colors.black,
  Color fallbackDark = Colors.white,
}) {
  final isDark = context.isDark;
  if (colorClass == null) return isDark ? fallbackDark : fallbackLight;
  return isDark ? colorClass.darkModeColor : colorClass.lightModeColor;
}
