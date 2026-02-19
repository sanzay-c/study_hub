import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/page_indicator.dart';
import 'package:study_hub/common/widgets/splash_circle.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/di/injection.dart';
import 'package:study_hub/core/routing/navigation_service.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';

class InitialSplashScreen extends StatefulWidget {
  const InitialSplashScreen({super.key});

  @override
  State<InitialSplashScreen> createState() => _InitialSplashScreenState();
}

class _InitialSplashScreenState extends State<InitialSplashScreen> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthCheckRequested());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.success) {
          // Go straight to home if already authenticated
          getIt<NavigationService>().pushReplacementNamed(
            RouteName.bottomNavScreen,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SplashCircle(
                color: const [Color(0XFF526DFF), Color(0XFF8B32FB)],
                child: Center(
                  child: SizedBox(
                    child: SvgImageRenderWidget(
                      svgImagePath: AssetsSource.splashAssetsSource.bookIcon,
                      height: 56.h,
                      width: 56.w,
                      svgColor: AppColors.allWhite,
                    ),
                  ),
                ),
              ),
              40.verticalSpace,
              TextWidget(
                text: 'Study Together',
                fontSize: 32.sp,
                fontWeight: FontWeight.w800,
              ),
              24.verticalSpace,
              TextWidget(
                text:
                    'Join study groups, share knowledge, and learn collaboratively with peers around the world.',
                textalign: TextAlign.center,
                fontWeight: FontWeight.w600,
              ),
              56.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [PageIndicator(activeIndex: 0)],
              ),
              32.verticalSpace,
              CommonButton(
                text: "Next",
                onTap: () => getIt<NavigationService>().pushReplacementNamed(
                  RouteName.secondSplashScreen,
                ),
                color: const [Color(0XFF526DFF), Color(0XFF8B32FB)],
                icon: Icons.arrow_forward,
              ),
              32.verticalSpace,
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => getIt<NavigationService>().pushReplacementNamed(
                  RouteName.loginScreen,
                ),
                child: TextWidget(
                    text: 'Skip', fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
