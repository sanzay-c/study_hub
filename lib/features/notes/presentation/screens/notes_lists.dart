import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_state.dart';
import 'package:study_hub/features/notes/presentation/screens/note_preview_screen.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';

// class FileListPage extends StatelessWidget {
//   const FileListPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // Dummy Data List
//     final List<Map<String, dynamic>> dummyFiles = [
//       {
//         'title': 'Data Structure and algorithm',
//         'subtitle': 'Computer Science 101',
//         'type': 'PDF',
//         'size': '2.4MB',
//         'time': '2 days ago',
//         'uploader': 'Sarah Johnson',
//       },
//       {
//         'title': 'Data Structure and algorithm',
//         'subtitle': 'Computer Science 101',
//         'type': 'PDF',
//         'size': '2.4MB',
//         'time': '2 days ago',
//         'uploader': 'Sarah Johnson',
//       },
//     ];

//     return Scaffold(
//       backgroundColor: getColorByTheme(
//         context: context,
//         colorClass: AppColors.backgroundColor,
//       ),
//       body: ListView.builder(
//         itemCount: dummyFiles.length,
//         itemBuilder: (context, index) {
//           return FileCard(fileData: dummyFiles[index]);
//         },
//       ),
//     );
//   }
// }

// class FileCard extends StatelessWidget {
//   final Map<String, dynamic> fileData;

//   const FileCard({super.key, required this.fileData});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//         color: getColorByTheme(
//           context: context,
//           colorClass: AppColors.containerColor,
//         ),
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(
//           width: 1.w,
//           color: getColorByTheme(
//             context: context,
//             colorClass: AppColors.containerBorderColor,
//           ),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: .start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               crossAxisAlignment: .start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16.w),
//                   decoration: BoxDecoration(
//                     color: getColorByTheme(
//                       context: context,
//                       colorClass: AppColors.containerOrangeColor,
//                     ),
//                     borderRadius: BorderRadius.circular(16.r),
//                   ),
//                   child: SvgImageRenderWidget(
//                     svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
//                     svgColor: AppColors.allWhite,
//                   ),
//                 ),
//                 16.horizontalSpace,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: .start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: .spaceBetween,
//                         children: [
//                           Expanded(
//                             child: TextWidget(
//                               text: fileData['title'],
//                               fontWeight: FontWeight.w700,
//                               maxLines: 1,
//                               textOverflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           InkWell(
//                             onTap: () {},
//                             child: SvgImageRenderWidget(
//                               height: 20.h,
//                               width: 20.w,
//                               svgImagePath: AssetsSource.appIcons.downloadIcon,
//                             ),
//                           ),
//                         ],
//                       ),
//                       8.verticalSpace,
//                       TextWidget(
//                         text: fileData['subtitle'],
//                         color: getColorByTheme(
//                           context: context,
//                           colorClass: AppColors.subTextColor,
//                         ),
//                       ),
//                       8.verticalSpace,

//                       Row(
//                         children: [
//                           _buildMetaItem(fileData['type'], context),
//                           _buildDot(context),
//                           _buildMetaItem(fileData['size'], context),
//                           _buildDot(context),
//                           _buildMetaItem(fileData['time'], context),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             height: 1.h,
//             thickness: 1.w,
//             color: getColorByTheme(
//               context: context,
//               colorClass: AppColors.dividerColor,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             child: TextWidget(
//               text: 'Uploaded by ${fileData['uploader']}',
//               fontSize: 14.sp,
//               color: getColorByTheme(
//                 context: context,
//                 colorClass: AppColors.subTextColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildMetaItem(String text, BuildContext context) {
//     return TextWidget(
//       text: text,
//       fontSize: 14.sp,
//       color: getColorByTheme(
//         context: context,
//         colorClass: AppColors.subTextColor,
//       ),
//     );
//   }

//   Widget _buildDot(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w),
//       child: Container(
//         width: 3.w,
//         height: 3.w,
//         decoration: BoxDecoration(
//           color: getColorByTheme(
//             context: context,
//             colorClass: AppColors.appIconColor,
//           ),
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }


// class FileCard extends StatelessWidget {
//   final NotesEntity note;

//   const FileCard({super.key, required this.note});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 16.h),
//       decoration: BoxDecoration(
//         color: getColorByTheme(
//           context: context,
//           colorClass: AppColors.containerColor,
//         ),
//         borderRadius: BorderRadius.circular(20.r),
//         border: Border.all(
//           width: 1.w,
//           color: getColorByTheme(
//             context: context,
//             colorClass: AppColors.containerBorderColor,
//           ),
//         ),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withValues(alpha: 0.05),
//             blurRadius: 15,
//             offset: const Offset(0, 8),
//           ),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.w),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   padding: EdgeInsets.all(16.w),
//                   decoration: BoxDecoration(
//                     color: getColorByTheme(
//                       context: context,
//                       colorClass: AppColors.containerOrangeColor,
//                     ),
//                     borderRadius: BorderRadius.circular(16.r),
//                   ),
//                   child: SvgImageRenderWidget(
//                     svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
//                     svgColor: AppColors.allWhite,
//                   ),
//                 ),
//                 16.horizontalSpace,
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Expanded(
//                             child: TextWidget(
//                               text: note.title ?? 'Untitled',
//                               fontWeight: FontWeight.w700,
//                               maxLines: 1,
//                               textOverflow: TextOverflow.ellipsis,
//                             ),
//                           ),
//                           Row(
//                             children: [
//                               InkWell(
//                                 onTap: () {
//                                   Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           NotePreviewScreen(note: note),
//                                     ),
//                                   );
//                                 },
//                                 child: Icon(
//                                   Icons.visibility_outlined,
//                                   size: 22.h,
//                                   color: getColorByTheme(
//                                     context: context,
//                                     colorClass: AppColors.appIconColor,
//                                   ),
//                                 ),
//                               ),
//                               12.horizontalSpace,
//                               BlocBuilder<NotesBloc, NotesState>(
//                                 buildWhen: (previous, current) =>
//                                     previous.downloadingNoteId !=
//                                         current.downloadingNoteId ||
//                                     previous.downloadSuccess !=
//                                         current.downloadSuccess,
//                                 builder: (context, state) {
//                                   final isDownloading =
//                                       state.downloadingNoteId == note.id;

//                                   if (isDownloading) {
//                                     return SizedBox(
//                                       height: 20.h,
//                                       width: 20.w,
//                                       child: const CircularProgressIndicator(
//                                         strokeWidth: 2,
//                                       ),
//                                     );
//                                   }

//                                   return InkWell(
//                                     onTap: () {
//                                       final fileName =
//                                           note.filePath.split('/').last;

//                                       context.read<NotesBloc>().add(
//                                             DownloadNoteRequested(
//                                               noteId: note.id,
//                                               fileName: fileName,
//                                             ),
//                                           );
//                                     },
//                                     child: SvgImageRenderWidget(
//                                       height: 20.h,
//                                       width: 20.w,
//                                       svgImagePath:
//                                           AssetsSource.appIcons.downloadIcon,
//                                     ),
//                                   );
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       8.verticalSpace,
//                       TextWidget(
//                         text: note.groupName,
//                         color: getColorByTheme(
//                           context: context,
//                           colorClass: AppColors.subTextColor,
//                         ),
//                       ),
//                       8.verticalSpace,
//                       Row(
//                         children: [
//                           _buildMetaItem(
//                             note.fileType.split('/').last.toUpperCase(),
//                             context,
//                           ),
//                           _buildDot(context),
//                           _buildMetaItem(_formatSize(note.fileSize), context),
//                           _buildDot(context),
//                           _buildMetaItem(_formatDate(note.createdAt), context),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider(
//             height: 1.h,
//             thickness: 1.w,
//             color: getColorByTheme(
//               context: context,
//               colorClass: AppColors.dividerColor,
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
//             child: TextWidget(
//               text: 'Uploaded by ${note.uploaderUsername}',
//               fontSize: 14.sp,
//               color: getColorByTheme(
//                 context: context,
//                 colorClass: AppColors.subTextColor,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   String _formatSize(int bytes) {
//     if (bytes < 1024) return '${bytes}B';
//     if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
//     return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
//   }

//   String _formatDate(DateTime? date) {
//     if (date == null) return '';
//     final difference = DateTime.now().difference(date);
//     if (difference.inDays > 0) return '${difference.inDays} days ago';
//     if (difference.inHours > 0) return '${difference.inHours} hours ago';
//     return '${difference.inMinutes} mins ago';
//   }

//   Widget _buildMetaItem(String text, BuildContext context) {
//     return TextWidget(
//       text: text,
//       fontSize: 14.sp,
//       color: getColorByTheme(
//         context: context,
//         colorClass: AppColors.subTextColor,
//       ),
//     );
//   }

//   Widget _buildDot(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(horizontal: 8.w),
//       child: Container(
//         width: 3.w,
//         height: 3.w,
//         decoration: BoxDecoration(
//           color: getColorByTheme(
//             context: context,
//             colorClass: AppColors.appIconColor,
//           ),
//           shape: BoxShape.circle,
//         ),
//       ),
//     );
//   }
// }



class FileCard extends StatelessWidget {
  final NotesEntity note;
  const FileCard({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerColor,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          width: 1.w,
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.containerBorderColor,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
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
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: getColorByTheme(
                      context: context,
                      colorClass: AppColors.containerOrangeColor,
                    ),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: SvgImageRenderWidget(
                    svgImagePath: AssetsSource.bottomNavAssetsSource.notesIcon,
                    svgColor: AppColors.allWhite,
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
                          Expanded(
                            child: TextWidget(
                              text: note.title ?? 'Untitled',
                              fontWeight: FontWeight.w700,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),
                          // ── ACTION BUTTONS ──────────────────────────
                          Row(
                            children: [
                              _ActionIconButton(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          NotePreviewScreen(note: note),
                                    ),
                                  );
                                },
                                child: Icon(
                                  Icons.visibility_outlined,
                                  size: 18.sp,
                                  color: getColorByTheme(
                                    context: context,
                                    colorClass: AppColors.appIconColor,
                                  ),
                                ),
                              ),
                              8.horizontalSpace,
                              BlocBuilder<NotesBloc, NotesState>(
                                buildWhen: (previous, current) =>
                                    previous.downloadingNoteId !=
                                        current.downloadingNoteId ||
                                    previous.downloadSuccess !=
                                        current.downloadSuccess,
                                builder: (context, state) {
                                  final isDownloading =
                                      state.downloadingNoteId == note.id;

                                  if (isDownloading) {
                                    return _ActionIconButton(
                                      onTap: null,
                                      child: SizedBox(
                                        height: 16.h,
                                        width: 16.w,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          color: getColorByTheme(
                                            context: context,
                                            colorClass: AppColors.appIconColor,
                                          ),
                                        ),
                                      ),
                                    );
                                  }

                                  return _ActionIconButton(
                                    onTap: () {
                                      final fileName =
                                          note.filePath.split('/').last;
                                      context.read<NotesBloc>().add(
                                            DownloadNoteRequested(
                                              noteId: note.id,
                                              fileName: fileName,
                                            ),
                                          );
                                    },
                                    child: SvgImageRenderWidget(
                                      height: 18.h,
                                      width: 18.w,
                                      svgImagePath:
                                          AssetsSource.appIcons.downloadIcon,
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                          // ────────────────────────────────────────────
                        ],
                      ),
                      8.verticalSpace,
                      TextWidget(
                        text: note.groupName,
                        color: getColorByTheme(
                          context: context,
                          colorClass: AppColors.subTextColor,
                        ),
                      ),
                      8.verticalSpace,
                      Row(
                        children: [
                          _buildMetaItem(
                              note.fileType.split('/').last.toUpperCase(),
                              context),
                          _buildDot(context),
                          _buildMetaItem(_formatSize(note.fileSize), context),
                          _buildDot(context),
                          _buildMetaItem(_formatDate(note.createdAt), context),
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
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.dividerColor,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            child: TextWidget(
              text: 'Uploaded by ${note.uploaderUsername}',
              fontSize: 14.sp,
              color: getColorByTheme(
                context: context,
                colorClass: AppColors.subTextColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024) return '${bytes}B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)}KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)}MB';
  }

  String _formatDate(DateTime? date) {
    if (date == null) return '';
    final difference = DateTime.now().difference(date);
    if (difference.inDays > 0) return '${difference.inDays} days ago';
    if (difference.inHours > 0) return '${difference.inHours} hours ago';
    return '${difference.inMinutes} mins ago';
  }

  Widget _buildMetaItem(String text, BuildContext context) {
    return TextWidget(
      text: text,
      fontSize: 14.sp,
      color: getColorByTheme(
        context: context,
        colorClass: AppColors.subTextColor,
      ),
    );
  }

  Widget _buildDot(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w),
      child: Container(
        width: 3.w,
        height: 3.w,
        decoration: BoxDecoration(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.appIconColor,
          ),
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// _ActionIconButton — bordered pill button with press feedback
// Only this widget is new; everything above is your original code unchanged.
// ─────────────────────────────────────────────────────────────────────────────
class _ActionIconButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Widget child;

  const _ActionIconButton({
    required this.onTap,
    required this.child,
  });

  @override
  State<_ActionIconButton> createState() => _ActionIconButtonState();
}

class _ActionIconButtonState extends State<_ActionIconButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final iconColor = getColorByTheme(
      context: context,
      colorClass: AppColors.appIconColor,
    );
    final borderColor = getColorByTheme(
      context: context,
      colorClass: AppColors.containerBorderColor,
    );

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 130),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(7.w),
        decoration: BoxDecoration(
          color: _pressed
              ? iconColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(
            width: 1.w,
            color: _pressed
                ? iconColor.withValues(alpha: 0.35)
                : borderColor,
          ),
        ),
        child: widget.child,
      ),
    );
  }
}