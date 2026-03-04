import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/svg_image_render_widget.dart';
import 'package:study_hub/core/constants/app_color.dart';
import 'package:study_hub/core/constants/assets_source.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';

class UserSearchBar extends StatefulWidget {
  const UserSearchBar({super.key});

  @override
  State<UserSearchBar> createState() => _UserSearchBarState();
}

class _UserSearchBarState extends State<UserSearchBar> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;

  @override
  void dispose() {
    _controller.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (mounted) {
        context.read<SocialBloc>().add(SearchSocialEvent(query));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: getColorByTheme(
          context: context,
          colorClass: AppColors.containerButton,
        ),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: TextField(
        controller: _controller,
        onChanged: _onSearchChanged,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: getColorByTheme(
            context: context,
            colorClass: AppColors.textColor,
          ),
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
        ),
        decoration: InputDecoration(
          hintText: 'Search users...',
          hintStyle: TextStyle(
            color: getColorByTheme(
              context: context,
              colorClass: AppColors.subTextColor,
            ),
            fontWeight: FontWeight.w600,
            fontSize: 16.sp,
          ),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 18.h),
            child: SvgImageRenderWidget(
              height: 20.h,
              width: 20.w,
              svgImagePath: AssetsSource.appIcons.searchIcon,
            ),
          ),
          prefixIconConstraints: BoxConstraints(
            minWidth: 24.w,
            minHeight: 24.h,
          ),
          suffixIcon: _controller.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, size: 20),
                  onPressed: () {
                    _controller.clear();
                    _onSearchChanged('');
                    setState(() {});
                  },
                )
              : null,
          border: InputBorder.none,
          isDense: true,
        ),
      ),
    );
  }
}
