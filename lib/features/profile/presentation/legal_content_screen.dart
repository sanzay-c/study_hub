import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class LegalSection {
  final String heading;
  final String body;

  const LegalSection({required this.heading, required this.body});
}

class LegalContentScreen extends StatelessWidget {
  final String title;
  final String lastUpdated;
  final List<LegalSection> sections;

  const LegalContentScreen({
    super.key,
    required this.title,
    required this.lastUpdated,
    required this.sections,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(title: title),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Last updated pill
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              decoration: BoxDecoration(
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.containerColor,
                ),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerBorderColor,
                  ),
                  width: 0.5,
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 12.sp,
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
                  ),
                  6.horizontalSpace,
                  TextWidget(
                    text: 'Last updated: $lastUpdated',
                    fontSize: 12.sp,
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
                  ),
                ],
              ),
            ),

            24.verticalSpace,

            // Sections
            ...sections.asMap().entries.map((entry) {
              final index = entry.key + 1;
              final section = entry.value;
              return _buildSection(context, index, section);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(
    BuildContext context,
    int index,
    LegalSection section,
  ) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Heading row with numbered badge
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 26.w,
                height: 26.w,
                decoration: BoxDecoration(
                  color: const Color(0xFF526DFF).withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(6.r),
                ),
                alignment: Alignment.center,
                child: TextWidget(
                  text: '$index',
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF526DFF),
                ),
              ),
              10.horizontalSpace,
              Expanded(
                child: TextWidget(
                  text: section.heading,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          10.verticalSpace,

          // Body text — slight left indent to align with heading text
          Padding(
            padding: EdgeInsets.only(left: 36.w),
            child: TextWidget(
              text: section.body,
              fontSize: 13.sp,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ),
            ),
          ),

          // Divider between sections (except last)
          if (index < 10) ...[
            16.verticalSpace,
            Divider(
              height: 0,
              thickness: 0.5,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.dividerColor,
              ),
            ),
          ],
        ],
      ),
    );
  }
}