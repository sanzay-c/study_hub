import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

final Map<String, dynamic> groupDetailsData = {
  "groupName": "Computer Science 101",
  "description":
      "Introduction to Computer Science - Algorithms, Data Structure, and Problem Solving",
  "bannerImage": "https://images.unsplash.com/photo-1497633762265-9d179a990aa6",
  "memberCount": 234,
  "category": "Computer Science",
  "members": [
    {
      "name": "Sarah Johnson",
      "status": "Online",
      "isOnline": true,
      "isOwner": true,
    },
    {
      "name": "Michael Chen",
      "status": "Offline",
      "isOnline": false,
      "isOwner": false,
    },
    {
      "name": "Emily Davis",
      "status": "Online",
      "isOnline": true,
      "isOwner": false,
    },
    {
      "name": "Alex Martinez",
      "status": "Online",
      "isOnline": true,
      "isOwner": false,
    },
  ],
  "notes": [
    {"title": "Chapter 1 Notes", "size": "2.4 MB - PDF"},
    {"title": "Introduction to Algorithms", "size": "1.8 MB - PDF"},
  ],
};

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Accessing dummy data
    final data = groupDetailsData;
    final List members = data['members'];
    final List notes = data['notes'];

    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: const StudyHubAppBar(title: 'Group Details'),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner Image
            Stack(
              children: [
                Image.network(
                  data['bannerImage'],
                  height: 150.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),

            // Floating Main Info Card
            Transform.translate(
              offset: Offset(0, -40.h),
              child: _buildMainInfoCard(context, data),
            ),

            // Members Section
            _buildSectionContainer(
              context: context,
              title: "Members",
              trailing: "${members.where((m) => m['isOnline']).length} online",
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: members.length,
                itemBuilder: (context, index) {
                  final member = members[index];
                  return _buildMemberTile(
                    member['name'],
                    member['status'],
                    member['isOnline'],
                    member['isOwner'],
                    context,
                  );
                },
              ),
            ),

            16.verticalSpace,

            // Recent Notes Section
            _buildSectionContainer(
              context: context,
              title: "Recent Notes",
              trailing: "View All",
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: notes.length,
                separatorBuilder: (context, index) => 12.verticalSpace,
                itemBuilder: (context, index) {
                  final note = notes[index];
                  return _buildNoteTile(note['title'], note['size'], context);
                },
              ),
            ),
            40.verticalSpace,
          ],
        ),
      ),
    );
  }

  Widget _buildMainInfoCard(BuildContext context, Map<String, dynamic> data) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerBorderColor,
          ),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: data['groupName'],
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.6,
          ),
          8.verticalSpace,
          TextWidget(text: data['description']),
          16.verticalSpace,
          Row(
            children: [
              SvgImageRenderWidget(
                svgImagePath: AssetsSource.bottomNavAssetsSource.socialIcon,
                height: 18.h,
                width: 18.w,
              ),
              8.horizontalSpace,
              TextWidget(text: "${data['memberCount']} member"),
            ],
          ),
          24.verticalSpace,
          Row(
            children: [
              Expanded(
                child: _buildButton(
                  "Chat",
                  null,
                  Icons.chat_bubble_outline,
                  true,
                  context,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: _buildButton(
                  "Leave",
                  getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerInput,
                  ),
                  null,
                  false,
                  context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Reusable Section Container
  Widget _buildSectionContainer({
    required String title,
    required String trailing,
    required Widget child,
    required BuildContext context,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerBorderColor,
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextWidget(
                text: title,
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
              TextWidget(
                text: trailing,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
              ),
            ],
          ),
          16.verticalSpace,
          child,
        ],
      ),
    );
  }

  Widget _buildMemberTile(
    String name,
    String status,
    bool isOnline,
    bool isOwner,
    BuildContext context,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Stack(
            children: [
              CircleAvatar(radius: 24.r, backgroundColor: Colors.grey[300]),
              if (isOnline)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    height: 12.h,
                    width: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.allWhite,
                        ),
                        width: 2.w,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    TextWidget(text: name, fontWeight: FontWeight.w600),
                    if (isOwner) ...[
                      4.horizontalSpace,
                      SvgImageRenderWidget(
                        svgImagePath: AssetsSource.appIcons.crownIcon,
                        height: 16.h,
                        width: 16.w,
                        svgColor: AppColors.crownColor,
                      ),
                    ],
                  ],
                ),
                TextWidget(
                  text: status,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.subTextColor,
                  ),
                  fontSize: 13.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoteTile(String title, String subtitle, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerInput,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: SvgImageRenderWidget(
              svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
              svgColor: AppColors.allRed,
              height: 24.h,
              width: 24.w,
            ),
          ),
          12.horizontalSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextWidget(
                text: title,
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
              TextWidget(
                text: subtitle,
                fontSize: 12.sp,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildButton(
    String label,
    Color? color,
    IconData? icon,
    bool isPrimary,
    BuildContext context,
  ) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(14.r),
        gradient: isPrimary
            ? LinearGradient(
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
              )
            : null,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            SvgImageRenderWidget(
              svgImagePath: AssetsSource.bottomNavAssetsSource.chatIcon,
              svgColor: AppColors.allWhite,
              height: 18.h,
              width: 18.w,
            ),
            8.horizontalSpace,
          ],
          TextWidget(
            text: label,
            fontWeight: FontWeight.bold,
            color: isPrimary
                ? getColorByTheme(context: context, colorClass: AppColors.allWhite)
                : getColorByTheme(
                    context: context,
                    colorClass: AppColors.subTextColor,
                  ),
          ),
        ],
      ),
    );
  }
}
