import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/upload_avatar/presentation/cubit/upload_avatar_cubit.dart';

class SelectImgBottomSheet extends StatelessWidget {
  const SelectImgBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(top: 12.h),
            height: 4.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor),
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),

          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 20.h, 20.w, 10.h),
            child: Align(
              alignment: Alignment.centerLeft,
              child: TextWidget(
                text: 'Select Image',
                fontSize: 18.sp,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),

          Divider(
            thickness: 1.w,
            color: getColorByTheme(context: context, colorClass: AppColors.containerBorderColor),
          ),

          _buildListTile(
            context,
            iconPath: AssetsSource.appIcons.cameraIcon,
            label: 'Camera',
            source: ImageSource.camera,
          ),
          _buildListTile(
            context,
            iconPath: AssetsSource.appIcons.galleryIcon,
            label: 'Gallery',
            source: ImageSource.gallery,
          ),
          
          SizedBox(height: 10.h),
        ],
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {
    required String iconPath,
    required String label,
    required ImageSource source,
  }) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      leading: SvgImageRenderWidget(svgImagePath: iconPath),
      title: TextWidget(text: label),
      onTap: () {
        Navigator.pop(context);
        context.read<UploadAvatarCubit>().pickAndUploadImage(source);
      },
    );
  }
}