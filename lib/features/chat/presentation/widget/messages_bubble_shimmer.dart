import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class MessagesBubbleShimmer extends StatelessWidget {
  const MessagesBubbleShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode =
        Theme.of(context).brightness == Brightness.dark;

    final Color baseColor =
        isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;

    final Color highlightColor =
        isDarkMode ? Colors.grey[700]! : Colors.grey[100]!;

    return ListView.builder(
      reverse: true,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
      itemCount: 6,
      itemBuilder: (context, index) {
        final isMe = index % 2 == 0;

        return Padding(
          padding: EdgeInsets.only(bottom: 20.h),
          child: isMe
              ? _buildSenderBubbleShimmer(
                  context, index, baseColor, highlightColor)
              : _buildReceiverBubbleShimmer(
                  context, index, baseColor, highlightColor),
        );
      },
    );
  }

  Widget _buildSenderBubbleShimmer(
    BuildContext context,
    int index,
    Color baseColor,
    Color highlightColor,
  ) {
    final widths = [180.0, 220.0, 160.0, 200.0, 140.0, 240.0];
    final width = widths[index % widths.length].w;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: width,
            height: 45.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.r),
                topRight: Radius.circular(20.r),
                bottomLeft: Radius.circular(20.r),
                bottomRight: Radius.circular(4.r),
              ),
            ),
          ),
          4.verticalSpace,
          Container(
            width: 35.w,
            height: 12.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiverBubbleShimmer(
    BuildContext context,
    int index,
    Color baseColor,
    Color highlightColor,
  ) {
    final widths = [200.0, 160.0, 240.0, 180.0, 220.0, 150.0];
    final width = widths[index % widths.length].w;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Avatar shimmer
              Container(
                width: 36.w,
                height: 36.h,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              8.horizontalSpace,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Name shimmer
                  Container(
                    width: 80.w,
                    height: 14.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  8.verticalSpace,
                  // Message bubble shimmer
                  Container(
                    width: width,
                    height: 45.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4.r),
                        topRight: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 44.w, top: 4.h),
            child: Container(
              width: 35.w,
              height: 12.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ],
      ),
    );
  }
}