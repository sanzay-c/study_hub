import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/features/social/presentation/screens/users_discover_screen.dart';
import 'package:study_hub/features/social/presentation/widgets/custom_tab_bar.dart';

class StudyHubTabBar extends StatefulWidget {
  const StudyHubTabBar({super.key});

  @override
  State<StudyHubTabBar> createState() => _StudyHubTabBarState();
}

class _StudyHubTabBarState extends State<StudyHubTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          children: [
            CustomTabBar(
              controller: _tabController,
              tabs: const ['Discover', 'Following', 'Followers'],
            ),
            16.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UsersDiscoverScreen(),
                  const Center(child: Text('Following')),
                  const Center(child: Text('Followers')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
