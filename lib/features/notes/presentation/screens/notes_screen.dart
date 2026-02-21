import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_lists.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_tabbar.dart';
import 'package:study_hub/features/notes/presentation/screens/upload_notes.dart';
import 'package:study_hub/features/notes/presentation/screens/widgets/notes_search_bar.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(context: context, colorClass: AppColors.backgroundColor),
      appBar: StudyHubAppBar(title: "Notes",actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.w),
            child: GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true, 
                  backgroundColor: Colors.transparent,
                  builder: (context) => UploadNotes(),
                );
              },
              child: Container(
                height: 32.h,
                width: 32.w,
                alignment: Alignment.center, 
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      getColorByTheme(
                        context: context,
                        colorClass: AppColors.gr0XFF526DFF,
                      ),
                      getColorByTheme(
                        context: context,
                        colorClass: AppColors.gr0XFF8B32FB,
                      ),
                    ],
                  ),
                  shape: BoxShape.circle,
                ),
                child: SizedBox(
                  height: 16.h,
                  width: 16.w,
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.appIcons.uploadIcon,
                    svgColor: AppColors.allWhite,
                  ),
                ),
              ),
            ),
          ),
        ],),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 8.h),
            child: const NotesSearchBar(),
          ),
          8.verticalSpace,
          Expanded(child: NotesTabbar()),
        ],
      ),
    );
  }
}
