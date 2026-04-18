import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';
import 'package:study_hub/features/groups/presentation/widgets/empty_group.dart';
import 'package:study_hub/features/groups/presentation/widgets/group_placeholder_widget.dart';
import 'package:study_hub/features/groups/presentation/widgets/groups_shimmer.dart';

class GroupsDiscover extends StatefulWidget {
  const GroupsDiscover({super.key});

  @override
  State<GroupsDiscover> createState() => _GroupsDiscoverState();
}

class _GroupsDiscoverState extends State<GroupsDiscover>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<GroupsCubit>().getDiscoverGroups(loadMore: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocBuilder<GroupsCubit, GroupsState>(
      builder: (context, state) {
        if (state is GroupsLoading) {
          return const GroupsShimmer();
        } else if (state is GroupsError) {
          return Center(child: Text(state.message));
        } else if (state is GroupsSuccess) {
          final groups = state.getGroups;
          if (groups == null || groups.isEmpty) {
            return EmptyGroup();
          }
          return ListView.builder(
            controller: _scrollController,
            itemCount: state.hasNext ? groups.length + 1 : groups.length,
            itemBuilder: (context, index) {
              if (index >= groups.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              final group = groups[index];
              return Padding(
                padding: EdgeInsets.only(bottom: 24.h),
                child: _buildGroupCard(group, context),
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGroupCard(GetGroupsEntity group, BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await getIt<NavigationService>().pushNamed(
          RouteName.groupDetailsScreen,
          extra: group.id,
        );
        if (context.mounted) {
          context.read<GroupsCubit>().getDiscoverGroups();
        }
      },
      child: Container(
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
            width: 1.w,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
              child: group.imagePath != null && group.imagePath!.isNotEmpty
                  ? Image.network(
                      group.imagePath!,
                      height: 140.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return GroupPlaceholderWidget();
                      },
                      errorBuilder: (context, error, stackTrace) =>
                          GroupPlaceholderWidget(),
                    )
                  : GroupPlaceholderWidget(),
            ),
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: group.name ?? 'Unknown Group',
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.6,
                  ),
                  8.verticalSpace,
                  TextWidget(
                    text: group.description ?? 'No description available.',
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
                        text: group.members.length.toString(),
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.subTextColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () async {
                          await getIt<NavigationService>().pushNamed(
                            RouteName.groupDetailsScreen,
                            extra: group.id,
                          );
                          if (context.mounted) {
                            context.read<GroupsCubit>().getDiscoverGroups();
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
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
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: TextWidget(
                            text: 'Join',
                            fontSize: 18.sp,
                            color: getColorByTheme(
                              context: context,
                              colorClass: AppColors.allWhite,
                            ),
                          ),
                        ),
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
