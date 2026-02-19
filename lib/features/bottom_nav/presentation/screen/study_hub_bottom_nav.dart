import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/features/bottom_nav/dao/bottom_nav_bar_model.dart';
import 'package:study_hub/features/chat/presentation/screens/chat_lists_screen.dart';
import 'package:study_hub/features/groups/presentation/screens/groups_screen.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_screen.dart';
import 'package:study_hub/features/profile/presentation/screens/profile_screen.dart';
import 'package:study_hub/features/social/presentation/screens/social_screen.dart';
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart';

class StudyHubBottomNav extends StatelessWidget {
  const StudyHubBottomNav({super.key});

  static final Map<String, Widget> _screenMap = {
    "Groups": const GroupsScreen(),
    "Chat": const ChatListsScreen(),
    "Notes": const NotesScreen(),
    "Social": const SocialScreen(),
    "Profile": const ProfileScreen(),
  };

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MainBottomNavBloc, MainBottomNavState>(
      builder: (context, state) {
        final selectedSlug = (state as BottomNavInitial).currentSlug;

        final currentIndex =
            bottomNavModel.indexWhere((item) => item.slug == selectedSlug);

        final isDesktop = MediaQuery.of(context).size.width >= 600;

        return Scaffold(
          body: isDesktop
              ? Row(
                  children: [
                    /// 🔵 NavigationRail (Tablet / Web)
                    NavigationRail(
                      selectedIndex: currentIndex < 0 ? 0 : currentIndex,
                      onDestinationSelected: (index) {
                        final item = bottomNavModel[index];
                        context
                            .read<MainBottomNavBloc>()
                            .add(NavSlugChanged(item.slug));
                      },
                      labelType: NavigationRailLabelType.all,
                      backgroundColor: getColorByTheme(
                        context: context,
                        colorClass: AppColors.bottomNav,
                      ),
                      destinations: bottomNavModel.map((item) {
                        return NavigationRailDestination(
                          icon: SvgImageRenderWidget(
                            height: 20.h,
                            width: 20.w,
                            svgImagePath: item.inactiveImage,
                            applyColorFilter: false,
                          ),
                          selectedIcon: SvgImageRenderWidget(
                            height: 20.h,
                            width: 20.w,
                            svgImagePath: item.activeImage,
                            applyColorFilter: false,
                          ),
                          label: Text(
                            item.label,
                            style: TextStyle(fontSize: 12.sp),
                          ),
                        );
                      }).toList(),
                    ),

                    Expanded(
                      child:
                          _screenMap[selectedSlug] ?? const SizedBox.shrink(),
                    ),
                  ],
                )
              : _screenMap[selectedSlug] ?? const SizedBox.shrink(),

          ///Bottom Nav (Mobile Only)
          bottomNavigationBar: isDesktop
              ? null
              : Container(
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.bottomNav,
                    ),
                    border: Border(
                      top: BorderSide(
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.bottomNavBorder,
                        ),
                        width: 1.w,
                      ),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        offset: const Offset(0, -2),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                  child: SafeArea(
                    top: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 8.w, vertical: 12.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: bottomNavModel.map((item) {
                          final isSelected = selectedSlug == item.slug;

                          return _BottomNavItem(
                            item: item,
                            isSelected: isSelected,
                            onTap: () {
                              if (!isSelected) {
                                context
                                    .read<MainBottomNavBloc>()
                                    .add(NavSlugChanged(item.slug));
                              }
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
        );
      },
    );
  }
}

/// 🔵 Bottom Nav Item (Mobile)
class _BottomNavItem extends StatelessWidget {
  final dynamic item;
  final bool isSelected;
  final VoidCallback onTap;

  const _BottomNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          splashColor: const Color(0xFF526DFF).withValues(alpha: 0.1),
          highlightColor: const Color(0xFF526DFF).withValues(alpha: 0.05),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgImageRenderWidget(
                  height: 18.h,
                  width: 18.w,
                  svgImagePath:
                      isSelected ? item.activeImage : item.inactiveImage,
                  applyColorFilter: false,
                ),
                SizedBox(height: 6.h),
                Text(
                  item.label,
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 12.sp,
                    height: 1.2,
                    foreground: isSelected
                        ? (Paint()
                          ..shader = const LinearGradient(
                            colors: [
                              Color(0xFF526DFF),
                              Color(0xFF8B32FB)
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(
                              const Rect.fromLTWH(0, 0, 100, 20)))
                        : (Paint()..color = const Color(0xFF4A5566)),
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
