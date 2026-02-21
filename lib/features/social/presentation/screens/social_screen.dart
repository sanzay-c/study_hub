import 'package:flutter/material.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/study_hub_tabbar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/social/presentation/screens/users_discover_screen.dart';

class SocialScreen extends StatelessWidget {
  const SocialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(title: "Social"),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 16.h),
            child: const UserSearchBar(),
          ),

          Expanded(
            child: StudyHubTabBar(
              tabs: ["Discover", "Following", "Followers"],
              children: [
                UsersDiscoverScreen(), 
                const Center(
                  child: Text('Following'),
                ),
                const Center(child: Text('Followers')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserSearchBar extends StatelessWidget {
  const UserSearchBar({super.key});

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
          hintText: 'Search users...',
          hintStyle: TextStyle(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),

          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 18.w,
              vertical: 18.h,
            ), // Icon ra text ko gap
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
