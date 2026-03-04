import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/social/presentation/widgets/social_shimmer.dart';
import 'package:study_hub/features/social/presentation/widgets/social_user_card.dart';

class UserFollowingScreen extends StatefulWidget {
  const UserFollowingScreen({super.key});

  @override
  State<UserFollowingScreen> createState() => _UserFollowingScreenState();
}

class _UserFollowingScreenState extends State<UserFollowingScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(GetSocialFollowingEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.following.isEmpty) {
          return const SocialShimmer();
        }
        if (state.status == SocialStatus.error && state.following.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }
        if (state.following.isEmpty) {
          return const Center(child: Text('No such user found'));
        }
        return CustomDotsRefreshIndicator(
          onRefresh: () async =>
              context.read<SocialBloc>().add(GetSocialFollowingEvent()),
          child: ListView.builder(
            itemCount: state.following.length,
            itemBuilder: (context, index) => SocialUserCard(
              userData: state.following[index],
              source: SocialCardSource.following,
            ),
          ),
        );
      },
    );
  }
}