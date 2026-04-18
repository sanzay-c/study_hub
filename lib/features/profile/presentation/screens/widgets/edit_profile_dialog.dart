import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_text_form_field.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class EditProfileDialog extends StatefulWidget {
  final String currentFullName;
  final Function(String newFullName) onConfirm;

  const EditProfileDialog({
    super.key,
    required this.currentFullName,
    required this.onConfirm,
  });

  static void show(
    BuildContext context, {
    required String currentFullName,
    required Function(String newFullName) onConfirm,
  }) {
    showDialog(
      context: context,
      builder: (_) => EditProfileDialog(
        currentFullName: currentFullName,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  State<EditProfileDialog> createState() => _EditProfileDialogState();
}

class _EditProfileDialogState extends State<EditProfileDialog> {
  late final TextEditingController _controller;
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentFullName);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.containerColor,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      title: TextWidget(
        text: 'Edit Profile',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'Update your full name displayed on your profile.',
            fontSize: 14.sp,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
          ),
          16.verticalSpace,
          TextWidget(
            text: 'Full Name',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          8.verticalSpace,
          CustomTextFormField(
            controller: _controller,
            hintText: 'Enter full name',
            onChanged: (value) {
              setState(() {
                _isButtonEnabled = value.trim().isNotEmpty &&
                    value.trim() != widget.currentFullName;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextWidget(text: 'Cancel', color: getColorByTheme(context: context, colorClass: AppColors.subTextColor)),
        ),
        ElevatedButton(
          onPressed: _isButtonEnabled
              ? () {
                  Navigator.pop(context);
                  widget.onConfirm(_controller.text.trim());
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: getColorByTheme(
              context: context,
              colorClass: AppColors.gr0XFF8B32FB,
            ),
            disabledBackgroundColor: getColorByTheme(
              context: context,
              colorClass: AppColors.gr0XFF8B32FB,
            ).withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: TextWidget(text: 'Save', color: Colors.white),
        ),
      ],
    );
  }
}
