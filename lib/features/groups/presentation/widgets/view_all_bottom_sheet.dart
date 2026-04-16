import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';

class ViewAllBottomSheet<T> extends StatelessWidget {
  final String title;
  final List<T> data;
  final Widget Function(T item) itemBuilder;

  const ViewAllBottomSheet({
    super.key,
    required this.title,
    required this.data,
    required this.itemBuilder,
  });

  static void show<T>({
    required BuildContext context,
    required String title,
    required List<T> data,
    required Widget Function(T item) itemBuilder,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => ViewAllBottomSheet<T>(
        title: title,
        data: data,
        itemBuilder: itemBuilder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.backgroundColor,
        ),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      child: Column(
        children: [
          8.verticalSpace,
          _DragHandle(),
          16.verticalSpace,
          _SheetHeader(title: title),
          const Divider(),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.all(20.w),
              itemCount: data.length,
              separatorBuilder: (_, _) => 12.verticalSpace,
              itemBuilder: (_, index) => itemBuilder(data[index]),
            ),
          ),
        ],
      ),
    );
  }
}

class _DragHandle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.w,
      height: 4.h,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }
}

class _SheetHeader extends StatelessWidget {
  final String title;

  const _SheetHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(
            text: title,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}