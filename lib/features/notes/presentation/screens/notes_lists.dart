import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class FileListPage extends StatelessWidget {
  const FileListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy Data List
    final List<Map<String, dynamic>> dummyFiles = [
      {
        'title': 'Data Structure and algorithm',
        'subtitle': 'Computer Science 101',
        'type': 'PDF',
        'size': '2.4MB',
        'time': '2 days ago',
        'uploader': 'Sarah Johnson',
      },
      {
        'title': 'Data Structure and algorithm',
        'subtitle': 'Computer Science 101',
        'type': 'PDF',
        'size': '2.4MB',
        'time': '2 days ago',
        'uploader': 'Sarah Johnson',
      },
    ];

    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      body: ListView.builder(
        itemCount: dummyFiles.length,
        itemBuilder: (context, index) {
          return FileCard(fileData: dummyFiles[index]);
        },
      ),
    );
  }
}

class FileCard extends StatelessWidget {
  final Map<String, dynamic> fileData;

  const FileCard({super.key, required this.fileData});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1.w,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerBorderColor,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: .start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              crossAxisAlignment: .start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerOrangeColor,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
                    svgColor: AppColors.allWhite,
                  ),
                ),
                16.horizontalSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          Expanded(
                            child: TextWidget(
                              text: fileData['title'],
                              fontWeight: FontWeight.w700,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: SvgImageRenderWidget(
                              height: 20.h,
                              width: 20.w,
                              svgImagePath: AssetsSource.appIcons.downloadIcon,
                            ),
                          ),
                        ],
                      ),
                      8.verticalSpace,
                      TextWidget(
                        text: fileData['subtitle'],
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.subTextColor,
                        ),
                      ),
                      8.verticalSpace,

                      Row(
                        children: [
                          _buildMetaItem(fileData['type'], context),
                          _buildDot(context),
                          _buildMetaItem(fileData['size'], context),
                          _buildDot(context),
                          _buildMetaItem(fileData['time'], context),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Divider(
            height: 1.h,
            thickness: 1.w,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: TextWidget(
              text: 'Uploaded by ${fileData['uploader']}',
              fontSize: 14.sp,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetaItem(String text, BuildContext context) {
    return TextWidget(
      text: text,
      fontSize: 14.sp,
      color: getColorByTheme(
        context: context,
        colorClass: AppColors.subTextColor,
      ),
    );
  }

  Widget _buildDot(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 3.w,
        height: 3.w,
        decoration: BoxDecoration(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.appIconColor,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
