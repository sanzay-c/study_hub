import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/splash_circle.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/common/widgets/page_indicator.dart';

class ChatSplashScreen extends StatelessWidget {
  const ChatSplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            SplashCircle(
              color: [Color(0XFFB046FD), Color(0XFFDF178A)],
              child: Center(
                child: SizedBox(
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.splashAssetsSource.chatIcon,
                    height: 56.h,
                    width: 56.w,
                    svgColor: AppColors.allWhite,
                  ),
                ),
              ),
            ),
            40.verticalSpace,
            TextWidget(
              text: 'Real-time Chat',
              fontSize: 32.sp,
              fontWeight: FontWeight.w800,
            ),
            24.verticalSpace,
            TextWidget(
              text:
                  'Connect instantly with group members through real-time messaging and discussion.',
              textalign: TextAlign.center,
              fontWeight: FontWeight.w600,
            ),

            56.verticalSpace,

            Row(
              mainAxisAlignment: .center,
              children: [PageIndicator(activeIndex: 1)],
            ),
            32.verticalSpace,
            CommonButton(
              text: "Next",
              onTap: () => getIt<NavigationService>().pushReplacementNamed(
                RouteName.thirdSplashScreen,
              ),
              icon: Icons.arrow_forward,
              color: [Color(0XFFB046FD), Color(0XFFDF178A)],
            ),
          ],
        ),
      ),
    );
  }
}
