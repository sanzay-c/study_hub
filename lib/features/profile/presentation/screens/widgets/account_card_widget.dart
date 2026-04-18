import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/account_expandable_item_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/account_item_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/account_sub_item_widget.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/delete_account_dialog.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/notification_toggle_item_widget.dart';

class AccountCardWidget extends StatefulWidget {
  final String label;

  const AccountCardWidget({super.key, required this.label});

  @override
  State<AccountCardWidget> createState() => _AccountCardWidgetState();
}

class _AccountCardWidgetState extends State<AccountCardWidget> {
  bool _isPrivacyExpanded = false;
  bool _isNotificationExpanded = false;
  bool _isPushNotificationEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.circular(16.r),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: TextWidget(
              text: widget.label,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          AccountItemWidget(
            onTap: () {},
            svgImagePath: AssetsSource.appIcons.userPersonIcon,
            title: 'Edit Profile',
          ),

          AccountExpandableItemWidget(
            svgImagePath: AssetsSource.appIcons.notificationIcon,
            title: 'Notification',
            isExpanded: _isNotificationExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isNotificationExpanded = expanded;
              });
            },
            children: [
              NotificationToggleItemWidget(
                icon: Icons.notifications_outlined,
                title: 'Push Notifications',
                subtitle: 'Receive alerts on your device',
                value: _isPushNotificationEnabled,
                onChanged: (value) {
                  setState(() {
                    _isPushNotificationEnabled = value;
                  });
                },
              ),
            ],
          ),

          AccountExpandableItemWidget(
            svgImagePath: AssetsSource.appIcons.privacyIcon,
            title: 'Privacy & Security',
            isExpanded: _isPrivacyExpanded,
            onExpansionChanged: (expanded) {
              setState(() {
                _isPrivacyExpanded = expanded;
              });
            },
            children: [
              AccountSubItemWidget(
                onTap: () {
                  final authState = context.read<AuthBloc>().state;
                  final username = authState.user?.username ?? '';
                  DeleteAccountDialog.show(
                    context,
                    currentUsername: username,
                    onConfirmDelete: (password) {
                      context.read<AuthBloc>().add(
                        DeleteAccountRequested(password),
                      );
                      CustomToast.show(
                        context,
                        message: 'Account deletion requested.',
                        type: ToastType.success,
                      );
                    },
                  );
                },
                title: 'Delete Account',
                icon: Icons.delete,
                isDestructive: true,
              ),
            ],
          ),
        ],
      ),
    );
  }
}