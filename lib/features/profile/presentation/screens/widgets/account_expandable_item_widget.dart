import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';

class AccountExpandableItemWidget extends StatelessWidget {
  final String svgImagePath;
  final String title;
  final bool isExpanded;
  final ValueChanged<bool> onExpansionChanged;
  final List<Widget> children;

  const AccountExpandableItemWidget({
    super.key,
    required this.svgImagePath,
    required this.title,
    required this.isExpanded,
    required this.onExpansionChanged,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.dividerColor,
          ),
          height: 1.h,
        ),
        Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            onExpansionChanged: onExpansionChanged,
            tilePadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 4.h),
            leading: SvgImageRenderWidget(
              svgImagePath: svgImagePath,
              height: 20.h,
              width: 20.w,
            ),
            title: TextWidget(text: title),
            trailing: RotationTransition(
              turns: AlwaysStoppedAnimation(isExpanded ? 0.25 : 0),
              child: SvgImageRenderWidget(
                svgImagePath: AssetsSource.appIcons.arrowForward,
                height: 12.h,
              ),
            ),
            children: children,
          ),
        ),
      ],
    );
  }
}