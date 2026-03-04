import 'package:flutter/material.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/study_hub_tabbar.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/features/social/presentation/screens/user_followers_screen.dart';
import 'package:study_hub/features/social/presentation/screens/user_following_screen.dart';
import 'package:study_hub/features/social/presentation/screens/users_discover_screen.dart';
import 'package:study_hub/features/social/presentation/widgets/user_search_bar.dart';

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
              tabs: const ["Discover", "Following", "Followers"],
              children: const [
                UsersDiscoverScreen(),
                UserFollowingScreen(),
                UserFollowersScreen(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
