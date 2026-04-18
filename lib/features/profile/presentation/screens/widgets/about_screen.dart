import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:study_hub/features/profile/presentation/legal_content_screen.dart';
import 'package:study_hub/features/profile/presentation/screens/widgets/legal_content_data.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String _version = '';
  String _buildNumber = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    if (mounted) {
      setState(() {
        _version = info.version;
        _buildNumber = info.buildNumber;
      });
    }
  }

  void _openLegal(BuildContext context, String type) {
    final isTerms = type == 'terms';
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LegalContentScreen(
          title: isTerms ? 'Terms of Service' : 'Privacy Policy',
          lastUpdated: isTerms
              ? LegalContentData.termsLastUpdated
              : LegalContentData.privacyLastUpdated,
          sections: isTerms
              ? LegalContentData.termsSections
              : LegalContentData.privacySections,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: const StudyHubAppBar(title: 'About'),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: Column(
          children: [
            _buildAppHeader(context),
            24.verticalSpace,
            _buildLinksCard(context),
            24.verticalSpace,
            _buildFooter(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAppHeader(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 80.w,
          height: 80.w,
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: const LinearGradient(
              colors: [Color(0xFF526DFF), Color(0xFF8B32FB)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF526DFF).withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: SvgImageRenderWidget(
            svgImagePath: AssetsSource.splashAssetsSource.bookIcon,
            svgColor: AppColors.allWhite,
          ),
        ),
        16.verticalSpace,
        TextWidget(
          text: 'Study Hub',
          fontSize: 20.sp,
          fontWeight: FontWeight.w700,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.textColor,
          ),
        ),
        6.verticalSpace,
        TextWidget(
          text: _version.isEmpty
              ? 'Checking version...'
              : 'Version $_version (Build $_buildNumber)',
          fontSize: 13.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildLinksCard(BuildContext context) {
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
        children: [
          _buildLinkItem(
            context,
            svgImagePath: AssetsSource.appIcons.privacyIcon,
            title: 'Terms of Service',
            onTap: () => _openLegal(context, 'terms'),
          ),
          Divider(
            height: 1.h,
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
          ),
          _buildLinkItem(
            context,
            svgImagePath: AssetsSource.appIcons.privacyIcon,
            title: 'Privacy Policy',
            onTap: () => _openLegal(context, 'privacy'),
            isLast: true,
          ),
        ],
      ),
    );
  }

  Widget _buildLinkItem(
    BuildContext context, {
    required String svgImagePath,
    required String title,
    required VoidCallback onTap,
    bool isLast = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: Row(
          children: [
            SvgImageRenderWidget(
              svgImagePath: svgImagePath,
              height: 20.h,
              width: 20.w,
            ),
            16.horizontalSpace,
            Expanded(
              child: TextWidget(text: title),
            ),
            SvgImageRenderWidget(
              svgImagePath: AssetsSource.appIcons.arrowForward,
              height: 12.h,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        
        TextWidget(
          text: '© 2026 Study Hub. All rights reserved.',
          fontSize: 12.sp,
          textalign: TextAlign.center,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
      ],
    );
  }
}