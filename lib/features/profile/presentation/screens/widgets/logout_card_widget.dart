// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class LogoutCardWidget extends StatelessWidget {
  final String label;
  final void Function() onTap;

  const LogoutCardWidget({super.key, required this.label, required this.onTap});
  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Color(0XFFFEF2F2),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: .center,
                children: [
                  SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.logoutIcon,
                    height: 20.h,
                    width: 20.w,
                    svgColor: AppColors.allRed,
                  ),
                  16.horizontalSpace,
                  TextWidget(text: label, color: Color(0XFFEB000B), fontWeight: FontWeight.w700, fontSize: 18.sp,),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
