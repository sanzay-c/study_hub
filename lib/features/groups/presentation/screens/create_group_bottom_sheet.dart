import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class CreateGroupBottomSheet extends StatelessWidget {
  CreateGroupBottomSheet({super.key});

 
  final ValueNotifier<bool> isPrivateNotifier = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerBorderColor,
                  ),
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),
            ),
            16.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: 'Create Groups',
                  fontWeight: FontWeight.w800,
                  fontSize: 18.sp,
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.closeIcon,
                    height: 14.h,
                    width: 14.w,
                  ),
                ),
              ],
            ),
            24.verticalSpace,

            _buildLabel('Group Image'),
            Container(
              width: double.infinity,
              height: 120.h,
              decoration: BoxDecoration(
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.containerInput,
                ),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.uploadIcon,
                  ),
                  8.verticalSpace,
                  const TextWidget(text: 'Click to upload'),
                ],
              ),
            ),
            20.verticalSpace,

            _buildLabel('Group Name'),
            _buildTextField(context, 'Enter group name'),
            20.verticalSpace,

            _buildLabel('Description'),
            _buildTextField(context, 'Describe your group', maxLines: 3),
            20.verticalSpace,

            _buildLabel('Category'),
            _buildTextField(context, 'Provide Category'),
            20.verticalSpace,

           
            ValueListenableBuilder<bool>(
              valueListenable: isPrivateNotifier,
              builder: (context, isPrivate, child) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerInput,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextWidget(
                              text: 'Private Group',
                              fontWeight: FontWeight.w600,
                            ),
                            8.verticalSpace,
                            TextWidget(
                              text: 'Require approval to join',
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                      ),
                      Transform.scale(
                        scale: 0.8,
                        child: CupertinoSwitch(
                          value: isPrivate,
                          activeTrackColor: const Color(0xFF6A9BEE),
                          inactiveTrackColor: const Color(0xFFE5E7EB),
                          onChanged: (value) {
                            isPrivateNotifier.value = value;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),

            24.verticalSpace,

            CommonButton(
              text: 'Create Group',
              onTap: () {
                // Form submit logic
              },
              color: [
                getColorByTheme(
                  context: context,
                  colorClass: AppColors.gr0XFF526DFF,
                ),
                getColorByTheme(
                  context: context,
                  colorClass: AppColors.gr0XFF8B32FB,
                ),
              ],
            ),
            
            Padding(
              padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: TextWidget(text: text, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildTextField(BuildContext context, String hint, {int maxLines = 1}) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
        filled: true,
        fillColor: getColorByTheme(
          context: context,
          colorClass: AppColors.containerInput,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}