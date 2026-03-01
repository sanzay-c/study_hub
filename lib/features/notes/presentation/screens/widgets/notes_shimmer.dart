import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesShimmer extends StatelessWidget {
  const NotesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey[300]!;
    final highlightColor = Colors.grey[100]!;

    return ListView.builder(
      itemCount: 6, 
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            margin: EdgeInsets.only(bottom: 16.h), 
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                width: 1.w,
                color: baseColor,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w), 
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 50.w, 
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: baseColor,
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      16.horizontalSpace,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: 130.w,
                                  height: 16.h,
                                  decoration: BoxDecoration(
                                    color: baseColor,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                ),
                                Row(
                                  children: [
                                    _buildActionPlaceholder(baseColor),
                                    8.horizontalSpace,
                                    _buildActionPlaceholder(baseColor),
                                  ],
                                ),
                              ],
                            ),
                            8.verticalSpace,
                            Container(
                              width: 90.w,
                              height: 12.h,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(2.r),
                              ),
                            ),
                            12.verticalSpace,
                            Row(
                              children: [
                                _buildMetaPlaceholder(35.w, baseColor),
                                12.horizontalSpace,
                                _buildMetaPlaceholder(45.w, baseColor),
                                12.horizontalSpace,
                                _buildMetaPlaceholder(60.w, baseColor),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 1.h,
                  thickness: 1.w,
                  color: baseColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Container(
                    width: 160.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: baseColor,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionPlaceholder(Color color) {
    return Container(
      width: 32.w, 
      height: 32.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.r),
      ),
    );
  }

  Widget _buildMetaPlaceholder(double width, Color color) {
    return Container(
      width: width,
      height: 10.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2.r),
      ),
    );
  }
}