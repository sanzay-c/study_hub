import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/groups/presentation/screens/create_group_bottom_sheet.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: "Groups",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (context) => CreateGroupBottomSheet(),
                );
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
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
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  height: 16.h,
                  width: 16.w,
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.addIcon,
                    svgColor: AppColors.allWhite,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: GroupCardList(),
    );
  }
}

final List<Map<String, dynamic>> groupData = [
  {
    "title": "Computer Science 101",
    "description":
        "Introduction to Computer Science - Algorithms, Data Structure, and Problem Solving",
    "memberCount": 234,
    "category": "Computer Science",
    "image":
        "https://images.unsplash.com/photo-1497633762265-9d179a990aa6", // Library image
  },
  {
    "title": "Graphic Design Pro",
    "description":
        "Mastering UI/UX principles, color theory, and modern digital illustrations.",
    "memberCount": 156,
    "category": "Design",
    "image": "https://images.unsplash.com/photo-1558655146-d09347e92766",
  },
];

class GroupCardList extends StatelessWidget {
  const GroupCardList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(20.w),
      itemCount: groupData.length,
      itemBuilder: (context, index) {
        final group = groupData[index];
        return Padding(
          padding: EdgeInsets.only(bottom: 24.h),
          child: _buildGroupCard(group, context),
        );
      },
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group, BuildContext context) {
    return GestureDetector(
      onTap: () => getIt<NavigationService>().pushNamed(RouteName.groupDetailsScreen),
      child: Container(
        decoration: BoxDecoration(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerColor,
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.containerBorderColor,
            ),
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Group Image ---
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              child: Image.network(
                group['image'],
                height: 180.h,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
      
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: group['title'],
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                  8.verticalSpace,
      
                  TextWidget(
                    text: group['description'],
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
                  ),
      
                  16.verticalSpace,
      
                  Row(
                    children: [
                      SvgImageRenderWidget(
                        svgImagePath:
                            AssetsSource.bottomNavAssetsSource.socialIcon,
                        height: 16.h,
                        width: 16.w,
                      ),
                      8.horizontalSpace,
                      TextWidget(
                        text: group['memberCount'].toString(),
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.subTextColor,
                        ),
                      ),
      
                      const Spacer(),
      
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 8.h,
                        ),
                        decoration: BoxDecoration(
                          color: getColorByTheme(context: context, colorClass: AppColors.containerInput),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: TextWidget(text:group['category'], fontSize: 14.sp,)
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
