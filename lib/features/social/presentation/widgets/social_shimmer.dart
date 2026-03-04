import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SocialShimmer extends StatelessWidget {
  const SocialShimmer({super.key});

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
              border: Border.all(width: 1.w, color: baseColor),
            ),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center, // ✅ CENTERED
                children: [
                  // ✅ Avatar directly (removed Column)
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: baseColor,
                      shape: BoxShape.circle,
                    ),
                  ),

                  16.horizontalSpace,

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment:
                          MainAxisAlignment.center, // ✅ CENTER CONTENT
                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // ✅ CENTER BUTTON
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Name placeholder
                            Container(
                              width: 130.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                color: baseColor,
                                borderRadius: BorderRadius.circular(4.r),
                              ),
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
                  Column(children: [_buildActionPlaceholder(baseColor)]),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionPlaceholder(Color color) {
    return Container(
      width: 80.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(50.r),
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
