import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_tab_bar.dart';

class StudyHubTabBar extends StatefulWidget {
  final List<String> tabs;
  final List<Widget> children;

  const StudyHubTabBar({
    super.key,
    required this.tabs,
    required this.children,
  });

  @override
  State<StudyHubTabBar> createState() => _StudyHubTabBarState();
}

class _StudyHubTabBarState extends State<StudyHubTabBar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: widget.tabs.length,
      vsync: this,
    );
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
              tabs: widget.tabs,
            ),
            16.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: widget.children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}