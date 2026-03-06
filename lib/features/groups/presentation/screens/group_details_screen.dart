import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/groups/presentation/widgets/group_main_info_card.dart';
import 'package:study_hub/features/groups/presentation/widgets/member_tile.dart';
import 'package:study_hub/features/groups/presentation/widgets/note_tile.dart';
import 'package:study_hub/features/groups/presentation/widgets/section_container.dart';
import 'package:study_hub/features/groups/presentation/widgets/view_all_bottom_sheet.dart';

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
    {
      "name": "John Doe",
      "status": "Offline",
      "isOnline": false,
      "isOwner": false,
    },
  ],
  "notes": [
    {"title": "Chapter 1 Notes", "size": "2.4 MB - PDF"},
    {"title": "Introduction to Algorithms", "size": "1.8 MB - PDF"},
    {"title": "Data Structures Basics", "size": "3.2 MB - PDF"},
  ],
};

class GroupDetailsScreen extends StatelessWidget {
  const GroupDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List members = groupDetailsData['members'];
    final List notes = groupDetailsData['notes'];
    final onlineCount = members.where((m) => m['isOnline']).length;
    final previewMemberCount = members.length > 4 ? 4 : members.length;
    final previewNoteCount = notes.length > 2 ? 2 : notes.length;

    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: 'Group Details',
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: GestureDetector(
              onTap: () {
                //TODO:
              },
              child: SvgImageRenderWidget(
                svgImagePath: AssetsSource.appIcons.gearIcon,
                svgColor: AppColors.appIconColor,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Banner
            Image.network(
              groupDetailsData['bannerImage'],
              height: 150.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Transform.translate(
              offset: Offset(0, -40.h),
              child: GroupMainInfoCard(
                groupName: groupDetailsData['groupName'],
                description: groupDetailsData['description'],
                memberCount: groupDetailsData['memberCount'],
                createdBy: "sanjayaa",
                onChat: () {
                  // TODO: Navigate to chat
                },
                onLeave: () {
                  // TODO: Leave group logic
                },
              ),
            ),

            SectionContainer(
              title: "Members",
              trailing: "View All",
              onTrailingTap: () => ViewAllBottomSheet.show(
                context: context,
                title: "All Members",
                data: members,
                itemBuilder: (item) => MemberTile(
                  name: item['name'],
                  status: item['status'],
                  isOnline: item['isOnline'],
                  isOwner: item['isOwner'],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _OnlineCountBadge(count: onlineCount),
                  12.verticalSpace,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: previewMemberCount,
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return MemberTile(
                        name: member['name'],
                        status: member['status'],
                        isOnline: member['isOnline'],
                        isOwner: member['isOwner'],
                      );
                    },
                  ),
                ],
              ),
            ),

            16.verticalSpace,

            // Recent Notes Section
            SectionContainer(
              title: "Recent Notes",
              trailing: "View All",
              onTrailingTap: () => ViewAllBottomSheet.show(
                context: context,
                title: "All Notes",
                data: notes,
                itemBuilder: (item) =>
                    NoteTile(title: item['title'], subtitle: item['size']),
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: previewNoteCount,
                separatorBuilder: (_, __) => 12.verticalSpace,
                itemBuilder: (context, index) => NoteTile(
                  title: notes[index]['title'],
                  subtitle: notes[index]['size'],
                ),
              ),
            ),

            40.verticalSpace,
          ],
        ),
      ),
    );
  }
}

class _OnlineCountBadge extends StatelessWidget {
  final int count;

  const _OnlineCountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextWidget(
        text: "$count online",
        fontSize: 12.sp,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
