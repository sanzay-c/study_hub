import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  final List<String> _groups = [
    'Physics — Grade 11',
    'Chemistry — Grade 11',
    'Mathematics — Grade 12',
    'Biology — Grade 11',
  ];

  String? _selectedGroup;

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
          SizedBox(height: 16.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: 'Upload Notes',
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

          _buildLabel('Select Group'),
          _buildGroupsDropdown(context),
          24.verticalSpace,

          _buildLabel('Upload PDF'),
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
                TextWidget(text: 'Click to upload'),
              ],
            ),
          ),
          24.verticalSpace,

          CommonButton(
            text: 'Upload Notes',
            onTap: () {},
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

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }

  Widget _buildGroupsDropdown(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerInput,
        ),
        borderRadius: BorderRadius.circular(14.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 14.w),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: _selectedGroup,
          isExpanded: true,
          hint: TextWidget(
            text: 'Select a group...',
            fontSize: 13.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.textColor,
            ),
          ),
          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.containerBorderColor,
            ),
          ),
          dropdownColor: getColorByTheme(
            context: context,
            colorClass: AppColors.containerColor,
          ),
          borderRadius: BorderRadius.circular(14.r),
          items: _groups.map((group) {
            return DropdownMenuItem<String>(
              value: group,
              child: TextWidget(
                text: group,
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() => _selectedGroup = value);
          },
        ),
      ),
    );
  }

  // ── Label helper (unchanged) ────────────────────────────────────────────────
  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: TextWidget(text: text, fontWeight: FontWeight.w500),
    );
  }
}
