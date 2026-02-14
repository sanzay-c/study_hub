import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class StudyHubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final VoidCallback? onBackPressed;
  final Color? backgroundColor;
  final bool showBottomBorder;
  final double? fontSize;
  final FontWeight? fontWeight;

  const StudyHubAppBar({
    super.key,
    required this.title,
    this.actions,
    this.leading,
    this.showBackButton = false,
    this.onBackPressed,
    this.backgroundColor,
    this.showBottomBorder = true,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor:
          backgroundColor ??
          getColorByTheme(context: context, colorClass: AppColors.appBarColor),
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,
      elevation: 0,
      leading: showBackButton
          ? IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: onBackPressed ?? () => Navigator.pop(context),
            )
          : leading,
      title: TextWidget(
        text: title,
        fontSize: fontSize ?? 24.sp,
        fontWeight: fontWeight ?? FontWeight.w800,
      ),
      actions: actions,
      shape: showBottomBorder
          ? Border(
              bottom: BorderSide(
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.appBarBorderColor,
                ),
              ),
            )
          : null,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
