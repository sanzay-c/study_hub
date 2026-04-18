import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/auth/data/datasource/auth_local_datasource.dart';

import 'package:study_hub/core/di/injection.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:study_hub/features/chat/presentation/bloc/chat_state.dart';
import 'package:study_hub/core/notification/notification_service.dart';
import 'package:study_hub/features/chat/presentation/widget/empty_message_state.dart';
import 'package:study_hub/features/chat/presentation/widget/messages_bubble_shimmer.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';

// ---------------------------------------------------------------------------
// System message types — extend as needed
// ---------------------------------------------------------------------------
enum SystemMessageType { joined, left, addedByAdmin, infoChanged }

// ---------------------------------------------------------------------------
// Helper: detect system messages and their type from message content.
// Adjust the string patterns to match whatever your backend sends.
// ---------------------------------------------------------------------------
SystemMessageType? _detectSystemType(String content) {
  final lower = content.toLowerCase();
  if (lower.contains('joined the group')) return SystemMessageType.joined;
  if (lower.contains('left the group')) return SystemMessageType.left;
  if (lower.contains('was added')) return SystemMessageType.addedByAdmin;
  if (lower.contains('changed') || lower.contains('renamed')) {
    return SystemMessageType.infoChanged;
  }
  return null;
}

class MessagesScreen extends StatefulWidget {
  final String id;
  final bool isGroup;
  final String title;

  const MessagesScreen({
    super.key,
    required this.id,
    required this.isGroup,
    required this.title,
  });

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    PushNotificationService.currentChatId = widget.id;
    _loadChat();
    // Mark as read immediately when screen opens
    context.read<GroupsCubit>().markAsRead(widget.id, isGroup: widget.isGroup);
  }

  void _loadChat() async {
    final authState = context.read<AuthBloc>().state;
    final currentUserId = authState.user?.id ?? '';

    final authLocalDataSource = getIt<AuthLocalDataSource>();
    final tokenModel = await authLocalDataSource.getCachedToken();
    final token = tokenModel?.accessToken ?? '';

    if (mounted) {
      context.read<ChatBloc>().add(
        LoadChatHistoryEvent(
          id: widget.id,
          isGroup: widget.isGroup,
          currentUserId: currentUserId,
          token: token,
          otherUserId: widget.isGroup ? null : widget.id,
        ),
      );
    }
  }

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    final authState = context.read<AuthBloc>().state;
    final currentUserId = authState.user?.id ?? '';

    context.read<ChatBloc>().add(
      SendMessageEvent(
        message: messageController.text.trim(),
        senderId: currentUserId,
        receiverId: widget.isGroup ? null : widget.id,
        isGroup: widget.isGroup,
      ),
    );

    messageController.clear();
  }

  String _formatTime(DateTime time) {
    final localTime = time.toLocal();
    final now = DateTime.now();
    final difference = now.difference(localTime).inDays;

    if (difference >= 30) {
      return DateFormat('MMM yyyy').format(localTime);
    } else if (localTime.day != now.day ||
        localTime.month != now.month ||
        localTime.year != now.year) {
      return DateFormat('MMM d, h:mm a').format(localTime);
    } else {
      return DateFormat('h:mm a').format(localTime);
    }
  }

  String _getDateHeaderText(DateTime date) {
    final now = DateTime.now();
    final localDate = date.toLocal();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final messageDate = DateTime(
      localDate.year,
      localDate.month,
      localDate.day,
    );

    if (messageDate == today) {
      return "Today";
    } else if (messageDate == yesterday) {
      return "Yesterday";
    } else if (now.year == localDate.year) {
      return DateFormat('MMMM d').format(localDate);
    } else {
      return DateFormat('MMMM d yyyy').format(localDate);
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    final local1 = date1.toLocal();
    final local2 = date2.toLocal();
    return local1.year == local2.year &&
        local1.month == local2.month &&
        local1.day == local2.day;
  }

  @override
  void dispose() {
    PushNotificationService.currentChatId = null;
    messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  // -------------------------------------------------------------------------
  // Build
  // -------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: widget.title,
        fontWeight: FontWeight.w700,
        fontSize: 24.sp,
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.appIconColor,
              ),
              size: 24.sp,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: BlocListener<ChatBloc, ChatState>(
              listener: (context, state) {
                if (state.status == ChatStatus.success) {
                  _scrollToBottom();
                }
              },
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state.status == ChatStatus.loading) {
                    return MessagesBubbleShimmer();
                  } else if (state.status == ChatStatus.error) {
                    return Center(
                      child: TextWidget(
                        text: state.errorMessage ?? "An error occurred",
                      ),
                    );
                  }

                  final messages = state.messages;

                  if (messages.isEmpty) {
                    return const Center(
                      child: EmptyMessageState(),
                    );
                  }

                  final reversedMessages = messages.reversed.toList();

                  return ListView.builder(
                    controller: _scrollController,
                    reverse: true,
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 20.h,
                    ),
                    itemCount: reversedMessages.length,
                    itemBuilder: (context, index) {
                      final chat = reversedMessages[index];
                      final timeString = _formatTime(chat.timestamp);
                      final isSending = state.sendingMessageIds.contains(
                        chat.id,
                      );
                      // ---------------------------------------------------------------------------
                      // Date Header Logic
                      // ---------------------------------------------------------------------------
                      bool showDateHeader = false;
                      if (index == reversedMessages.length - 1) {
                        showDateHeader = true;
                      } else {
                        final nextChat = reversedMessages[index + 1];
                        if (!_isSameDay(chat.timestamp, nextChat.timestamp)) {
                          showDateHeader = true;
                        }
                      }

                      final headerText = _getDateHeaderText(chat.timestamp);
                      final isToday = headerText == "Today";

                      // -------------------------------------------------------
                      // Check if this is a system message
                      // -------------------------------------------------------
                      final systemType = _detectSystemType(chat.content);
                      if (systemType != null) {
                        return Column(
                          children: [
                            if (showDateHeader)
                              _buildDateHeader(headerText, isToday, context),
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.h),
                              child: _buildSystemMessage(
                                chat.content,
                                systemType,
                                context,
                              ),
                            ),
                          ],
                        );
                      }

                      return Column(
                        children: [
                          if (showDateHeader)
                            _buildDateHeader(headerText, isToday, context),
                          Padding(
                            padding: EdgeInsets.only(bottom: 20.h),
                            child: chat.isMe
                                ? _buildSenderBubble(
                                    chat.content,
                                    timeString,
                                    context,
                                    isSending,
                                  )
                                : _buildReceiverBubble(
                                    senderName: chat.senderName,
                                    senderId: chat.senderId,
                                    avatarUrl: chat.senderAvatarUrl,
                                    message: chat.content,
                                    time: timeString,
                                    context: context,
                                  ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // System message widget
  // -------------------------------------------------------------------------

  Widget _buildSystemMessage(
    String content,
    SystemMessageType type,
    BuildContext context,
  ) {
    final config = _systemMessageConfig(type, context);

    return Row(
      children: [
        Expanded(
          child: Divider(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
            thickness: 0.5,
          ),
        ),
        8.horizontalSpace,
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 5.h),
          decoration: BoxDecoration(
            color: config.bgColor,
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: config.borderColor, width: 0.5),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(config.icon, size: 13.sp, color: config.iconColor),
              5.horizontalSpace,
              Text(
                content,
                style: TextStyle(fontSize: 12.sp, color: config.textColor),
              ),
            ],
          ),
        ),
        8.horizontalSpace,
        Expanded(
          child: Divider(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
            thickness: 0.5,
          ),
        ),
      ],
    );
  }

  _SystemMessageConfig _systemMessageConfig(
    SystemMessageType type,
    BuildContext context,
  ) {
    switch (type) {
      case SystemMessageType.joined:
        return _SystemMessageConfig(
          icon: Icons.person_add_outlined,
          bgColor: const Color(0xFFEAF3DE),
          borderColor: const Color(0xFFC0DD97),
          iconColor: const Color(0xFF3B6D11),
          textColor: const Color(0xFF27500A),
        );
      case SystemMessageType.left:
        return _SystemMessageConfig(
          icon: Icons.person_remove_outlined,
          bgColor: const Color(0xFFFCEBEB),
          borderColor: const Color(0xFFF7C1C1),
          iconColor: const Color(0xFFA32D2D),
          textColor: const Color(0xFF791F1F),
        );
      case SystemMessageType.addedByAdmin:
        return _SystemMessageConfig(
          icon: Icons.group_outlined,
          bgColor: const Color(0xFFFAEEDA),
          borderColor: const Color(0xFFFAC775),
          iconColor: const Color(0xFF854F0B),
          textColor: const Color(0xFF633806),
        );
      case SystemMessageType.infoChanged:
        return _SystemMessageConfig(
          icon: Icons.info_outline,
          bgColor: const Color(0xFFE6F1FB),
          borderColor: const Color(0xFFB5D4F4),
          iconColor: const Color(0xFF185FA5),
          textColor: const Color(0xFF0C447C),
        );
    }
  }

  // -------------------------------------------------------------------------
  // Date header — pill style, "Today" gets brand accent color
  // -------------------------------------------------------------------------

  Widget _buildDateHeader(String text, bool isToday, BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: [
          Expanded(
            child: Divider(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.dividerColor,
              ),
              thickness: 0.5,
            ),
          ),
          16.horizontalSpace,
          Container(
            padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 5.h),
            decoration: BoxDecoration(
              color: isToday
                  ? const Color(0xFF526DFF).withValues(alpha: 0.10)
                  : getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerColor,
                    ),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isToday
                    ? const Color(0xFF526DFF).withValues(alpha: 0.35)
                    : getColorByTheme(
                        context: context,
                        colorClass: AppColors.dividerColor,
                      ),
                width: 0.5,
              ),
            ),
            child: TextWidget(
              text: text,
              fontSize: 12.sp,
              fontWeight: FontWeight.w500,
              color: isToday
                  ? const Color(0xFF526DFF)
                  : getColorByTheme(
                      context: context,
                      colorClass: AppColors.subTextColor,
                    ),
            ),
          ),
          16.horizontalSpace,
          Expanded(
            child: Divider(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.dividerColor,
              ),
              thickness: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // -------------------------------------------------------------------------
  // Sender bubble
  // -------------------------------------------------------------------------

  Widget _buildSenderBubble(
    String message,
    String time,
    BuildContext context,
    bool isSending,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Opacity(
          opacity: isSending ? 0.7 : 1.0,
          child: Container(
            constraints: BoxConstraints(maxWidth: 280.w),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(4.r),
              ),
            ),
            child: TextWidget(
              text: message,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.allWhite,
              ),
            ),
          ),
        ),
        4.verticalSpace,
        Align(
          alignment: Alignment.centerRight,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextWidget(
                text: time,
                fontSize: 12.sp,
                color: getColorByTheme(
                  context: context,
                  colorClass: AppColors.subTextColor,
                ),
              ),
              if (isSending) ...[
                4.horizontalSpace,
                Icon(
                  Icons.access_time,
                  size: 12.sp,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.subTextColor,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Receiver bubble
  // -------------------------------------------------------------------------

  Widget _buildReceiverBubble({
    required String? senderName,
    required String senderId,
    required String? avatarUrl,
    required String message,
    required String time,
    required BuildContext context,
  }) {
    final displayName = (senderName != null && senderName.isNotEmpty)
        ? senderName
        // ignore: unnecessary_string_interpolations
        : '${senderId.length >= 4 ? senderId.substring(0, 4) : senderId}';

    final initial = displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: const Color(0xFFE2E8F0),
              backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                  ? NetworkImage(avatarUrl)
                  : null,
              child: (avatarUrl == null || avatarUrl.isEmpty)
                  ? Text(
                      initial,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.textColor,
                        ),
                      ),
                    )
                  : null,
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: displayName,
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.textColor,
                  ),
                ),
                8.verticalSpace,
                Container(
                  constraints: BoxConstraints(maxWidth: 240.w),
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 12.h,
                  ),
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerColor,
                    ),
                    border: Border.all(
                      color: getColorByTheme(
                        context: context,
                        colorClass: AppColors.containerBorderColor,
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(4.r),
                      topRight: Radius.circular(20.r),
                      bottomLeft: Radius.circular(20.r),
                      bottomRight: Radius.circular(20.r),
                    ),
                  ),
                  child: TextWidget(text: message),
                ),
              ],
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(left: 44.w, top: 4.h),
          child: TextWidget(
            text: time,
            fontSize: 12.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
          ),
        ),
      ],
    );
  }

  // -------------------------------------------------------------------------
  // Message input bar
  // -------------------------------------------------------------------------

  Widget _buildMessageInput(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
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
      ),
      child: SafeArea(
        child: Row(
          children: [
            // SvgImageRenderWidget(
            //   svgImagePath: AssetsSource.appIcons.paperClip,
            //   svgColor: AppColors.appIconColor,
            //   height: 20.h,
            //   width: 20.w,
            // ),
            8.horizontalSpace,
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerTypeText,
                  ),
                  borderRadius: BorderRadius.circular(25.r),
                ),
                alignment: Alignment.center,
                child: TextFormField(
                  controller: messageController,
                  textAlignVertical: TextAlignVertical.center,
                  onFieldSubmitted: (_) => _sendMessage(),
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: TextStyle(
                      color: getColorByTheme(
                        context: context,
                        colorClass: AppColors.subTextColor,
                      ),
                    ),
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                    suffixIcon: Padding(
                      padding: EdgeInsets.only(right: 8.w),
                      child: Icon(
                        Icons.sentiment_satisfied_alt_outlined,
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.appIconColor,
                        ),
                        size: 20.sp,
                      ),
                    ),
                    suffixIconConstraints: BoxConstraints(
                      minHeight: 20.h,
                      minWidth: 20.w,
                    ),
                  ),
                ),
              ),
            ),
            8.horizontalSpace,
            InkWell(
              onTap: _sendMessage,
              child: Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
                ),
                child: Center(
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.sendIcon,
                    svgColor: AppColors.allWhite,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Internal config model for system message styling
// ---------------------------------------------------------------------------
class _SystemMessageConfig {
  final IconData icon;
  final Color bgColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const _SystemMessageConfig({
    required this.icon,
    required this.bgColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });
}
