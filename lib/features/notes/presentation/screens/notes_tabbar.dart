import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_lists.dart';
import 'package:study_hub/features/social/presentation/screens/users_discover_screen.dart';
import 'package:study_hub/features/social/presentation/widgets/custom_tab_bar.dart';

class NotesTabbar extends StatefulWidget {
  const NotesTabbar({super.key});

  @override
  State<NotesTabbar> createState() => _NotesTabbarState();
}

class _NotesTabbarState extends State<NotesTabbar>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
              tabs: const ['Discover', 'My Notes'],
            ),
            16.verticalSpace,
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  FileListPage(),
                  const Center(child: Text('my notes that i have shared in the groups')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
