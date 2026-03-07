import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/groups/presentation/cubit/create_group_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/create_group_state.dart';

class CreateGroupBottomSheet extends StatelessWidget {
  const CreateGroupBottomSheet({super.key});

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && context.mounted) {
      context.read<CreateGroupCubit>().onImagePicked(image);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreateGroupCubit, CreateGroupState>(
      listenWhen: (previous, current) =>
          previous.isSuccess != current.isSuccess || previous.error != current.error,
      listener: (context, state) {
        if (state.isSuccess) {
          CustomToast.show(
            context,
            message: "Group created successfully!",
            type: ToastType.success,
          );
          Navigator.pop(context);
        } else if (state.error != null) {
          CustomToast.show(
            context,
            message: state.error!,
            type: ToastType.error,
          );
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerColor,
          ),
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Bottom Sheet Handle
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerBorderColor,
                    ),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
              16.verticalSpace,
              
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(
                    text: 'Create Groups',
                    fontWeight: FontWeight.w800,
                    fontSize: 18.sp,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: SvgImageRenderWidget(
                      svgImagePath: AssetsSource.appIcons.closeIcon,
                      height: 14.h,
                      width: 14.w,
                    ),
                  ),
                ],
              ),
              24.verticalSpace,

              // Group Image Upload Area
              _buildLabel('Group Image'),
              GestureDetector(
                onTap: () => _pickImage(context),
                child: BlocBuilder<CreateGroupCubit, CreateGroupState>(
                  buildWhen: (previous, current) => previous.image != current.image,
                  builder: (context, state) {
                    return Container(
                      width: double.infinity,
                      height: 120.h,
                      decoration: BoxDecoration(
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.containerInput,
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                        image: state.image != null
                            ? DecorationImage(
                                image: FileImage(File(state.image!.path)),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: state.image == null
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SvgImageRenderWidget(
                                  svgImagePath: AssetsSource.appIcons.uploadIcon,
                                ),
                                8.verticalSpace,
                                const TextWidget(text: 'Click to upload'),
                              ],
                            )
                          : const SizedBox.shrink(),
                    );
                  },
                ),
              ),
              20.verticalSpace,

              // Group Name Input
              _buildLabel('Group Name'),
              _buildTextField(
                context,
                'Enter group name',
                onChanged: (val) => context.read<CreateGroupCubit>().onNameChanged(val),
              ),
              20.verticalSpace,

              // Description Input
              _buildLabel('Description'),
              _buildTextField(
                context,
                'Describe your group',
                maxLines: 3,
                onChanged: (val) => context.read<CreateGroupCubit>().onDescriptionChanged(val),
              ),
              20.verticalSpace,

              // Privacy Toggle
              BlocBuilder<CreateGroupCubit, CreateGroupState>(
                buildWhen: (previous, current) => previous.isPublic != current.isPublic,
                builder: (context, state) {
                  return Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: getColorByTheme(
                        context: context,
                        colorClass: AppColors.containerInput,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const TextWidget(
                                text: 'Private Group',
                                fontWeight: FontWeight.w600,
                              ),
                              8.verticalSpace,
                              TextWidget(
                                text: 'Require approval to join',
                                fontSize: 12.sp,
                              ),
                            ],
                          ),
                        ),
                        Transform.scale(
                          scale: 0.8,
                          child: CupertinoSwitch(
                            value: !state.isPublic, // Private is opposite of Public
                            activeTrackColor: const Color(0xFF6A9BEE),
                            inactiveTrackColor: const Color(0xFFE5E7EB),
                            onChanged: (value) {
                              context.read<CreateGroupCubit>().onVisibilityChanged(!value);
                            },
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              24.verticalSpace,

              // Submit Button
              BlocBuilder<CreateGroupCubit, CreateGroupState>(
                buildWhen: (previous, current) => previous.isLoading != current.isLoading,
                builder: (context, state) {
                  return CommonButton(
                    text: 'Create Group',
                    isLoading: state.isLoading,
                    onTap: () => context.read<CreateGroupCubit>().submitGroup(),
                    color: [
                      getColorByTheme(
                        context: context,
                        colorClass: AppColors.gr0XFF526DFF,
                      ),
                      getColorByTheme(
                        context: context,
                        colorClass: AppColors.gr0XFF8B32FB,
                      ),
                    ],
                  );
                },
              ),
              
              // Keyboard avoidance padding
              Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: TextWidget(text: text, fontWeight: FontWeight.w500),
    );
  }

  Widget _buildTextField(
    BuildContext context, 
    String hint, {
    int maxLines = 1, 
    Function(String)? onChanged,
  }) {
    return TextField(
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(
          fontSize: 14.sp,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.subTextColor,
          ),
        ),
        filled: true,
        fillColor: getColorByTheme(
          context: context,
          colorClass: AppColors.containerInput,
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}