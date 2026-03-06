import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:study_hub/common/widgets/common_button.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/groups_state.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:study_hub/features/notes/presentation/cubit-upload-note/upload_note_cubit.dart';

class UploadNotes extends StatefulWidget {
  const UploadNotes({super.key});

  @override
  State<UploadNotes> createState() => _UploadNotesState();
}

class _UploadNotesState extends State<UploadNotes> {
  GroupsEntity? _selectedGroup;
  File? _selectedFile;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UploadNoteCubit, UploadNoteState>( // uploadNotes cubit
      listener: (context, state) {
        if (state is UploadNoteSuccess) {
          CustomToast.show(
            context,
            message: 'Note uploaded successfully!',
            type: ToastType.success,
          );
          context.read<NotesBloc>().add(GetMyNotesEvent(isRefresh: true));
          Navigator.pop(context);
        } else if (state is UploadNoteError) {
          CustomToast.show(
            context,
            message: state.message,
            type: ToastType.error,
          );
        }
      },
      child: Builder(
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.containerColor,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
            ),
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
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
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: 'Upload Notes',
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
                _buildLabel('Select Group'),
                _buildGroupsDropdown(context),
                24.verticalSpace,
                _buildLabel('Upload PDF'),
                GestureDetector(
                  onTap: _pickFile,
                  child: Container(
                    width: double.infinity,
                    height: 120.h,
                    decoration: BoxDecoration(
                      color: getColorByTheme(
                        context: context,
                        colorClass: AppColors.containerInput,
                      ),
                      borderRadius: BorderRadius.circular(16.r),
                      border: _selectedFile != null
                          ? Border.all(color: Colors.green, width: 2.w)
                          : null,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgImageRenderWidget(
                          svgImagePath: AssetsSource.appIcons.uploadIcon,
                          height: 32.h,
                          width: 32.w,
                        ),
                        8.verticalSpace,
                        TextWidget(
                          text: _selectedFile != null
                              ? _selectedFile!.path.split('/').last
                              : 'Click to upload PDF',
                          fontSize: 13.sp,
                          color: _selectedFile != null ? Colors.green : null,
                        ),
                      ],
                    ),
                  ),
                ),
                24.verticalSpace,
                BlocBuilder<UploadNoteCubit, UploadNoteState>(
                  builder: (context, state) {
                    return CommonButton(
                      text: state is UploadNoteLoading
                          ? 'Uploading...'
                          : 'Upload Notes',
                      isLoading: state is UploadNoteLoading,
                      onTap: () => _handleUpload(context),
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
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom + 16.h,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        _selectedFile = File(result.files.single.path!);
      });
    }
  }

  void _handleUpload(BuildContext context) {
    if (_selectedGroup == null) {
      CustomToast.show(context, message: "Please select a group", type: .info);
      return;
    }
    if (_selectedFile == null) {
      CustomToast.show(
        context,
        message: "Please select a PDF file",
        type: .info,
      );
      return;
    }

    context.read<UploadNoteCubit>().uploadNote(
      groupId: _selectedGroup!.id,
      filePath: _selectedFile!.path,
    );
  }

  Widget _buildGroupsDropdown(BuildContext context) {
    return BlocBuilder<GroupsCubit, GroupsState>( // Groups cubit
      builder: (context, state) {
        if (state is GroupsLoading) {
          return DropdownShimmer();
        }
        if (state is GroupsError) {
          return Center(child: TextWidget(text: state.message));
        }
        if (state is GroupsSuccess) {
          return Container(
            decoration: BoxDecoration(
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.containerInput,
              ),
              borderRadius: BorderRadius.circular(14.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GroupsEntity>(
                value: _selectedGroup,
                isExpanded: true,
                hint: TextWidget(
                  text: 'Select a group...',
                  fontSize: 13.sp,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.textColor,
                  ),
                ),
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: getColorByTheme(
                    context: context,
                    colorClass: AppColors.containerBorderColor,
                  ),
                ),
                dropdownColor: getColorByTheme(
                  context: context,
                  colorClass: AppColors.containerColor,
                ),
                borderRadius: BorderRadius.circular(14.r),
                items: (state.groups ?? []).map((group) {
                  return DropdownMenuItem<GroupsEntity>(
                    value: group,
                    child: TextWidget(
                      text: group.name,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() => _selectedGroup = value);
                },
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: TextWidget(text: text, fontWeight: FontWeight.w500),
    );
  }
}

class DropdownShimmer extends StatelessWidget {
  const DropdownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final Color baseColor = getColorByTheme(
      context: context,
      colorClass: AppColors.containerInput,
    );

    return Shimmer.fromColors(
      baseColor: baseColor,
      // ignore: deprecated_member_use
      highlightColor: baseColor.withOpacity(0.5),
      period: const Duration(milliseconds: 1500),
      child: Container(
        height: 50.h,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white, width: 1.w),
        ),
      ),
    );
  }
}
