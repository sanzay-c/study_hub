import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/study_hub_tabbar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/groups/presentation/screens/create_group_bottom_sheet.dart';
import 'package:study_hub/features/groups/presentation/screens/groups_created.dart';
import 'package:study_hub/features/groups/presentation/screens/groups_discover.dart';
import 'package:study_hub/features/groups/presentation/screens/groups_joined.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: StudyHubTabBar(
                tabs: ['Discover', 'Joined', 'Created'],
                children: [
                  BlocProvider(
                    create: (_) => getIt<GroupsCubit>()..getDiscoverGroups(),
                    child: const GroupsDiscover(),
                  ),
                  BlocProvider(
                    create: (_) => getIt<GroupsCubit>()..getJoinedGroups(),
                    child: const GroupsJoined(),
                  ),
                  BlocProvider(
                    create: (_) => getIt<GroupsCubit>()..getCreatedGroups(),
                    child: const GroupsCreated(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
