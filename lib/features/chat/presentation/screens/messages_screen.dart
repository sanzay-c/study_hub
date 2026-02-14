import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class ChatMessage {
  final String message;
  final String time;
  final bool isSender;
  final String? senderName;

  ChatMessage({
    required this.message,
    required this.time,
    required this.isSender,
    this.senderName,
  });
}

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final TextEditingController messageController = TextEditingController();
  final List<ChatMessage> messages = [
    ChatMessage(
      message: "I have some questions about Big O notation can you help ?",
      time: "8:34 PM",
      isSender: true,
    ),
    ChatMessage(
      message:
          "Big o is all about analyzing time complexity. What specific part are you confused about ?, hello can?",
      time: "8:34 PM",
      isSender: false,
      senderName: "Alex Martinez",
    ),
    ChatMessage(message: "hello", time: "8:34 PM", isSender: true),
    ChatMessage(
      message: "Thanks for sharing",
      time: "8:34 PM",
      isSender: false,
      senderName: "Alex Martinez",
    ),
  ];

  void _sendMessage() {
    if (messageController.text.trim().isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          message: messageController.text.trim(),
          time: _getCurrentTime(),
          isSender: true,
        ),
      );
      messageController.clear();
    });
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    final hour = now.hour > 12 ? now.hour - 12 : now.hour;
    final minute = now.minute.toString().padLeft(2, '0');
    final period = now.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: 'Computer Science 101',
        fontWeight: FontWeight.w400,
        fontSize: 20.sp,
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
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final chat = messages[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  child: chat.isSender
                      ? _buildSenderBubble(chat.message, chat.time, context)
                      : _buildReceiverBubble(
                          chat.senderName ?? "",
                          chat.message,
                          chat.time,
                          context,
                        ),
                );
              },
            ),
          ),
          _buildMessageInput(context),
        ],
      ),
    );
  }

  Widget _buildSenderBubble(String message, String time, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
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
                context: context, colorClass: AppColors.allWhite),
          ),
        ),
        4.verticalSpace,
        TextWidget(
          text: time,
          fontSize: 12.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverBubble(
    String name,
    String message,
    String time,
    BuildContext context,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: const Color(0xFFE2E8F0),
            ),
            8.horizontalSpace,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(text: name, fontSize: 13.sp),
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
            SvgImageRenderWidget(
              svgImagePath: AssetsSource.appIcons.paperClip,
              svgColor: AppColors.appIconColor,
              height: 20.h,
              width: 20.w,
            ),
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
                  onFieldSubmitted: (_) => _sendMessage(), // Enter press गर्दा send
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
              onTap: _sendMessage, // Send button tap
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