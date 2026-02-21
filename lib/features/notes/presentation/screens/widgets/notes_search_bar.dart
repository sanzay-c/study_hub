import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class NotesSearchBar extends StatelessWidget {
  const NotesSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerButton,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: 'Search notes...',
          hintStyle: TextStyle(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
            fontWeight: FontWeight.w600,
            fontSize: 16.sp, 
          ),

          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h), 
            child: SvgImageRenderWidget(
              height: 20.h,
              width: 20.w,
              svgImagePath: AssetsSource.appIcons.searchIcon,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 24.w,
            minHeight: 24.h,
          ),
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}