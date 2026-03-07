import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_toast.dart';
import 'package:study_hub/common/widgets/study_hub_app_bar.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/common/widgets/text_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/core/routing/route_name.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/features/groups/presentation/cubit/group_detail_cubit.dart';
import 'package:study_hub/features/groups/presentation/cubit/group_detail_state.dart';
import 'package:study_hub/features/groups/presentation/widgets/group_main_info_card.dart';
import 'package:study_hub/features/groups/presentation/widgets/groups_detail_shimmer.dart';
import 'package:study_hub/features/groups/presentation/widgets/member_tile.dart';
import 'package:study_hub/features/groups/presentation/widgets/note_tile.dart';
import 'package:study_hub/features/groups/presentation/widgets/section_container.dart';
import 'package:study_hub/features/groups/presentation/widgets/view_all_bottom_sheet.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:study_hub/features/notes/data/model/notes_model.dart';
import 'package:study_hub/features/notes/presentation/screens/note_preview_screen.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/presentation/screens/user_details_screen.dart';
import 'package:study_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:study_hub/features/bottom_nav/presentation/bloc/main_bottom_nav_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shimmer/shimmer.dart';


class GroupDetailsScreen extends StatefulWidget {
  final String groupId;
  const GroupDetailsScreen({super.key, required this.groupId});

  @override
  State<GroupDetailsScreen> createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorByTheme(
        context: context,
        colorClass: AppColors.backgroundColor,
      ),
      appBar: StudyHubAppBar(
        title: 'Group Details',
        actions: [
          BlocBuilder<GroupDetailCubit, GroupDetailState>(
            builder: (context, state) {
              if (state is GroupDetailSuccess) {
                final currentUserId = context.read<AuthBloc>().state.user?.id;
                final isMember = state.groupDetail.members.contains(currentUserId) || 
                               state.groupDetail.membersPreview.any((m) => m.userId == currentUserId) ||
                               state.groupDetail.createdBy == currentUserId;
                if (!isMember) return const SizedBox.shrink();

                return Padding(
                  padding: EdgeInsets.only(right: 20.w),
                  child: GestureDetector(
                    onTap: () {},
                    child: SvgImageRenderWidget(
                      svgImagePath: AssetsSource.appIcons.gearIcon,
                      svgColor: AppColors.appIconColor,
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: BlocBuilder<GroupDetailCubit, GroupDetailState>(
        builder: (context, state) {
          if (state is GroupDetailLoading) {
            return const GroupDetailShimmer();
          } else if (state is GroupDetailError) {
            return Center(child: TextWidget(text: state.message));
          } else if (state is GroupDetailSuccess) {
            final data = state.groupDetail;
            
            final currentUserId = context.read<AuthBloc>().state.user?.id;
            final isMember = data.members.contains(currentUserId) || 
                            data.membersPreview.any((m) => m.userId == currentUserId) ||
                            data.createdBy == currentUserId;
            final isOwner = data.createdBy == currentUserId;

            // Logic for preview counts
            final previewMemberCount = data.membersPreview.length > 4 ? 4 : data.membersPreview.length;
            final previewNoteCount = data.notesPreview.length > 2 ? 2 : data.notesPreview.length;

            return SingleChildScrollView(
              child: Column(
                children: [
                  // Banner - Using imageUrl from API
                  if (data.imageUrl != null && data.imageUrl!.isNotEmpty)
                    CachedNetworkImage(
                      imageUrl: data.imageUrl!,
                      height: 150.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => _buildPlaceholder(),
                      errorWidget: (context, url, error) => _buildPlaceholder(),
                    )
                  else
                    _buildPlaceholder(),

                  Transform.translate(
                    offset: Offset(0, -40.h),
                    child: GroupMainInfoCard(
                      groupName: data.name,
                      description: data.description,
                      memberCount: data.memberCount,
                      createdBy: data.creatorName,
                      isMember: isMember,
                      isOwner: isOwner,
                      onChat: () {},
                      onLeave: () {},
                      onJoin: () {
                        // TODO: Implement join group logic (e.g. calling cubit/usecase)
                        CustomToast.show(
                          context, 
                          message: "Join request sent (Placeholder)",
                          type: ToastType.info,
                        );
                      },
                    ),
                  ),

                  // Members Section - Only show if user is a member
                  if (isMember)
                    SectionContainer(
                      title: "Members",
                      trailing: "View All",
                      onTrailingTap: () => ViewAllBottomSheet.show(
                        context: context,
                        title: "All Members",
                        data: data.membersPreview,
                        itemBuilder: (item) {
                          final member = item as MembersPreviewEntity;
                          return MemberTile(
                            name: member.fullname,
                            status: member.isOnline ? "Online" : "Offline",
                            isOnline: member.isOnline,
                            isOwner: member.isOwner,
                            imageUrl: member.avatarPath,
                            onTap: () {
                              final currentUserId = context.read<AuthBloc>().state.user?.id;
                              
                              if (member.userId == currentUserId) {
                                context.read<MainBottomNavBloc>().add(const NavSlugChanged('Profile'));
                                context.go(RouteName.bottomNavScreen);
                              } else {
                                final socialUser = SocialEntity(
                                  userId: member.userId,
                                  username: member.username.isEmpty ? (member.fullname.isEmpty ? "Unknown" : member.fullname) : member.username,
                                  avatarPath: member.avatarPath,
                                  followers: '0',
                                  following: '0',
                                  isFollowing: false,
                                  followedAt: null,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UserDetailsScreen(user: socialUser),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _OnlineCountBadge(count: data.onlineCount),
                          12.verticalSpace,
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: previewMemberCount,
                            itemBuilder: (context, index) {
                              final member = data.membersPreview[index];
                              return MemberTile(
                                imageUrl: member.avatarPath ?? '',
                                name: member.fullname,
                                status: member.isOnline ? "Online" : "Offline",
                                isOnline: member.isOnline,
                                isOwner: member.isOwner,
                                onTap: () {
                                  final currentUserId = context.read<AuthBloc>().state.user?.id;

                                  if (member.userId == currentUserId) {
                                    context.read<MainBottomNavBloc>().add(const NavSlugChanged('Profile'));
                                    context.go(RouteName.bottomNavScreen);
                                  } else {
                                    final socialUser = SocialEntity(
                                      userId: member.userId,
                                      username: member.username.isEmpty ? (member.fullname.isEmpty ? "Unknown" : member.fullname) : member.username,
                                      avatarPath: member.avatarPath,
                                      followers: '0',
                                      following: '0',
                                      isFollowing: false,
                                      followedAt: null,
                                    );
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => UserDetailsScreen(user: socialUser),
                                      ),
                                    );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),

                  16.verticalSpace,

                  // Recent Notes Section - Only show if notes exist
                  if (data.notesPreview.isNotEmpty)
                    SectionContainer(
                      title: "Recent Notes",
                      trailing: "View All",
                      onTrailingTap: () => ViewAllBottomSheet.show(
                        context: context,
                        title: "All Notes",
                        data: data.notesPreview,
                        itemBuilder: (item) => NoteTile(
                          title: item['title'] ?? "Untitled",
                          subtitle: item['uploader_username'] ?? "Unknown uploader",
                          onTap: () {
                            final noteEntity = NotesModel.fromJson(item).toEntity();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NotePreviewScreen(note: noteEntity),
                              ),
                            );
                          },
                        ),
                      ),
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: previewNoteCount,
                        separatorBuilder: (_, __) => 12.verticalSpace,
                        itemBuilder: (context, index) {
                          final note = data.notesPreview[index];
                          return NoteTile(
                            title: note['title'] ?? "Untitled",
                            subtitle: note['uploader_username'] ?? "Unknown uploader",
                            onTap: () {
                              final noteEntity = NotesModel.fromJson(note).toEntity();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NotePreviewScreen(note: noteEntity),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),

                  40.verticalSpace,
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      height: 150.h,
      width: double.infinity,
      color: Colors.grey[300],
      child: Icon(Icons.group, size: 50.sp, color: Colors.grey[600]),
    );
  }
}

class _OnlineCountBadge extends StatelessWidget {
  final int count;
  const _OnlineCountBadge({required this.count});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextWidget(
        text: "$count online",
        fontSize: 12.sp,
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}