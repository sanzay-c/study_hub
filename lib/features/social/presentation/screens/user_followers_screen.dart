import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/social/presentation/widgets/social_shimmer.dart';
import 'package:study_hub/features/social/presentation/widgets/social_user_card.dart';

class UserFollowersScreen extends StatefulWidget {
  const UserFollowersScreen({super.key});

  @override
  State<UserFollowersScreen> createState() => _UserFollowersScreenState();
}

class _UserFollowersScreenState extends State<UserFollowersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(GetSocialFollowersEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading && state.followers.isEmpty) {
          return const SocialShimmer();
        }
        if (state.status == SocialStatus.error && state.followers.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }
        if (state.followers.isEmpty) {
          return const Center(child: Text('No such user found'));
        }
        return CustomDotsRefreshIndicator(
          onRefresh: () async =>
              context.read<SocialBloc>().add(GetSocialFollowersEvent()),
          child: ListView.builder(
            itemCount: state.followers.length,
            itemBuilder: (context, index) => SocialUserCard(
              userData: state.followers[index],
              source: SocialCardSource.followers,
            ),
          ),
        );
      },
    );
  }
}