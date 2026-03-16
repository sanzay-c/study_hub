import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';

class ChatListsScreen extends StatefulWidget {
  const ChatListsScreen({super.key});

  @override
  State<ChatListsScreen> createState() => _ChatListsScreenState();
}

class _ChatListsScreenState extends State<ChatListsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupsCubit>().getJoinedGroups();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(title: "Chat"),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is GroupsError) {
            return Center(child: TextWidget(text: state.message));
          } else if (state is GroupsSuccess) {
            final groups = state.getGroups ?? [];

            if (groups.isEmpty) {
              return const Center(child: TextWidget(text: "No active chats"));
            }

            return ListView.separated(
              itemCount: groups.length,
              separatorBuilder: (context, index) => Divider(
                height: 1.h,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.dividerColor,
                ),
              ),
              itemBuilder: (context, index) {
                final group = groups[index];

                return InkWell(
                  onTap: () => getIt<NavigationService>().pushNamed(
                    RouteName.messagesScreen,
                    extra: {
                      'id': group.id,
                      'isGroup': true,
                      'title': group.name,
                    },
                  ),
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          radius: 28.r,
                          backgroundColor: Colors.grey[300],
                          backgroundImage: group.imageUrl != null && group.imageUrl!.isNotEmpty
                              ? NetworkImage(group.imageUrl!)
                              : null,
                          child: group.imageUrl == null || group.imageUrl!.isEmpty
                              ? Icon(Icons.group, size: 28.r, color: Colors.grey[600])
                              : null,
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: TextWidget(
                                      text: group.name!,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: -0.5,
                                      fontSize: 20.sp,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  TextWidget(
                                    text: "Just now", // Dynamic time logic can be added later
                                    color: getColorByTheme(
                                      context: context,
                                      colorClass: AppColors.subTextColor,
                                    ),
                                    fontSize: 12.sp,
                                  ),
                                ],
                              ),
                              8.verticalSpace,
                              TextWidget(
                                text: group.description!,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                                color: getColorByTheme(
                                  context: context,
                                  colorClass: AppColors.subTextColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                        8.horizontalSpace,
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
