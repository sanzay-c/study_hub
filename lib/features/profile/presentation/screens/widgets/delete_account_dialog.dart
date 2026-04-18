import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class DeleteAccountDialog extends StatefulWidget {
  final String currentUsername;
  final VoidCallback onConfirmDelete;

  const DeleteAccountDialog({
    super.key,
    required this.currentUsername,
    required this.onConfirmDelete,
  });

  static void show(
    BuildContext context, {
    required String currentUsername,
    required VoidCallback onConfirmDelete,
  }) {
    showDialog(
      context: context,
      builder: (_) => DeleteAccountDialog(
        currentUsername: currentUsername,
        onConfirmDelete: onConfirmDelete,
      ),
    );
  }

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController _controller = TextEditingController();
  bool _isButtonEnabled = false;

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
        text: 'Delete Account',
        fontSize: 20.sp,
        fontWeight: FontWeight.bold,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text:
                'This action is permanent and cannot be undone. All your data will be deleted.',
            fontSize: 14.sp,
          ),
          16.verticalSpace,
          TextWidget(
            text: 'Type your "${widget.currentUsername}" account password to confirm:',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          8.verticalSpace,
          TextField(
            controller: _controller,
            onChanged: (value) {
              setState(() {
                _isButtonEnabled = value == widget.currentUsername;
              });
            },
            decoration: InputDecoration(
              hintText: 'Enter your password',
              hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
              filled: true,
              fillColor: getColorByTheme(
                context: context,
                colorClass: AppColors.backgroundColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 12.w,
                vertical: 8.h,
              ),
            ),
            style: TextStyle(
              fontSize: 14.sp,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.textColor,
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: TextWidget(text: 'Cancel', color: Colors.grey),
        ),
        ElevatedButton(
          onPressed: _isButtonEnabled
              ? () {
                  Navigator.pop(context);
                  widget.onConfirmDelete();
                }
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            disabledBackgroundColor: Colors.red.withValues(alpha: 0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
          ),
          child: TextWidget(text: 'Delete', color: Colors.white),
        ),
      ],
    );
  }
}