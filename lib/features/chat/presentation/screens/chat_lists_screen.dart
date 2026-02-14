import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';

class ChatListsScreen extends StatelessWidget {
  const ChatListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(title: "Chat"),
      body: ListView.separated(
        itemCount: chatData.length,
        separatorBuilder: (context, index) => Divider(
          height: 1.h,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.dividerColor,
          ),
        ),
        itemBuilder: (context, index) {
          final item = chatData[index];
          return InkWell(
            onTap: () => getIt<NavigationService>().pushNamed(RouteName.messagesScreen),
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 17.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  8. verticalSpace,
                  
                  CircleAvatar(
                    radius: 28.r,
                    backgroundImage: NetworkImage(item['imageUrl']),
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
                                text: item['title'],
                                fontWeight: FontWeight.w500,
                                letterSpacing: -0.5,
                                fontSize: 20.sp,
                                maxLines: 1,
                          textOverflow: TextOverflow.ellipsis,
                              ),
                            ),
                            TextWidget(
                              text: item['time'],
                              color: getColorByTheme(
                                context: context,
                                colorClass: AppColors.subTextColor,
                              ),
                              fontSize: 12.sp,
                            ),
                          ],
                        ),
                        8.horizontalSpace,
            
                        TextWidget(
                          text: item['lastMessage'],
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
            
                  if (item['unreadCount'] != null && item['unreadCount'] > 0)
                    Container(
                      padding: EdgeInsets.all(8.r),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
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
                      child: TextWidget(
                        text: item['unreadCount'].toString(),
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.allWhite,
                        ),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

final List<Map<String, dynamic>> chatData = [
  {
    "title": "Computer Science 101 fahfakfkalsdhfkahsdkfhas;hfda;",
    "lastMessage": "Hey, did anyone finish the assignment?",
    "time": "6m ago",
    "unreadCount": 3,
    "imageUrl":
        "https://images.unsplash.com/photo-1610116306796-6fea9f4fae38?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D", // Replace with your laptop image
  },
  {
    "title": "Graphic Design Group",
    "lastMessage": "The new frames look great!",
    "time": "12m ago",
    "unreadCount": null,
    "imageUrl":
        "https://images.unsplash.com/photo-1495446815901-a7297e633e8d?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  },
  {
    "title": "Mobile App Dev",
    "lastMessage": "Check the Flutter screen utils implementation.",
    "time": "1h ago",
    "unreadCount": 5,
    "imageUrl":
        "https://images.unsplash.com/photo-1594312915251-48db9280c8f1?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
  },
];
