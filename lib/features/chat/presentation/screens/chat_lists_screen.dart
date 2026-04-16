import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:study_hub/features/chat/presentation/widget/chat_empty_state.dart';
import 'package:study_hub/features/chat/presentation/widget/chat_lists_shimmer.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';
import 'package:study_hub/core/notification/notification_service.dart';

class ChatListsScreen extends StatefulWidget {
  const ChatListsScreen({super.key});

  @override
  State<ChatListsScreen> createState() => _ChatListsScreenState();
}

class _ChatListsScreenState extends State<ChatListsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<GroupsCubit>().getUnifiedChatList();
  }

  String _formatTime(DateTime? time) {
    if (time == null) return "Just now"; // Default if no last message
    
    final localTime = time.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localTime).inDays;
    final yesterday = DateTime(now.year, now.month, now.day - 1);
    final messageDate = DateTime(localTime.year, localTime.month, localTime.day);

    if (messageDate == yesterday) {
      return "Yesterday";
    } else if (difference >= 2 || localTime.year != now.year) {
      if (localTime.year == now.year) {
        return DateFormat('MMM d').format(localTime);
      } else {
        return DateFormat('MMM d yyyy').format(localTime);
      }
    } else if (localTime.day != now.day) {
      // Just in case but usually caught by yesterday
      return DateFormat('MMM d').format(localTime);
    } else {
      return DateFormat('h:mm a').format(localTime); // Today
    }
  }

  // Helper to build unread badge
  Widget _buildUnreadBadge(int count) {
    if (count <= 0) return const SizedBox.shrink();
    
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 7.w, vertical: 2.h),
      decoration: BoxDecoration(
        color: const Color(0xFF526DFF), // Brand primary blue
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextWidget(
        text: count > 10 ? "10+" : count.toString(),
        color: Colors.white,
        fontSize: 10.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: "Chat",
        actions: [
          IconButton(
            onPressed: () => PushNotificationService.showTestNotification(),
            icon: const Icon(Icons.notification_add, color: Colors.blue),
            tooltip: "Test Notification",
          ),
        ],
      ),
      body: BlocBuilder<GroupsCubit, GroupsState>(
        builder: (context, state) {
          if (state is GroupsLoading) {
            return const ChatListShimmer();
          } else if (state is GroupsError) {
            return Center(child: TextWidget(text: state.message));
          } else if (state is GroupsSuccess) {
            final groups = state.getGroups ?? [];

            if (groups.isEmpty) {
              return const ChatEmptyState();
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
                  onTap: () async {
                    // 1. Optimistic update
                    context.read<GroupsCubit>().markAsRead(group.id, isGroup: group.isGroup);
                    
                    // 2. Navigate and wait for return
                    await getIt<NavigationService>().pushNamed(
                      RouteName.messagesScreen,
                      extra: {
                        'id': group.id,
                        'isGroup': group.isGroup,
                        'title': group.name,
                      },
                    );

                    // 3. Refresh list when coming back
                    if (context.mounted) {
                      context.read<GroupsCubit>().getUnifiedChatList();
                    }
                  },
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
                              ? Icon(
                                  group.isGroup ? Icons.group : Icons.person,
                                  size: 28.r,
                                  color: Colors.grey[600],
                                )
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
                                      text: group.name ?? "Community",
                                      fontWeight: FontWeight.w600,
                                      letterSpacing: -0.5,
                                      fontSize: 18.sp,
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      color: getColorByTheme(
                                        context: context,
                                        colorClass: AppColors.textColor,
                                      ),
                                    ),
                                  ),
                                  4.horizontalSpace,
                                  TextWidget(
                                    text: _formatTime(group.lastMessageTime),
                                    color: getColorByTheme(
                                      context: context,
                                      colorClass: AppColors.subTextColor,
                                    ),
                                    fontSize: 11.sp,
                                  ),
                                ],
                              ),
                              4.verticalSpace,
                              Row(
                                children: [
                                  Expanded(
                                    child: TextWidget(
                                      text: group.lastMessageText ?? group.description ?? "No messages yet",
                                      maxLines: 1,
                                      textOverflow: TextOverflow.ellipsis,
                                      fontSize: 14.sp,
                                      color: getColorByTheme(
                                        context: context,
                                        colorClass: AppColors.subTextColor,
                                      ),
                                    ),
                                  ),
                                  8.horizontalSpace,
                                  _buildUnreadBadge(group.unreadCount),
                                ],
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
