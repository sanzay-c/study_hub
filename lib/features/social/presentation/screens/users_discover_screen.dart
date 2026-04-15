import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/features/social/presentation/bloc/social_bloc.dart';
import 'package:study_hub/features/social/presentation/widgets/social_empty.dart';
import 'package:study_hub/features/social/presentation/widgets/social_shimmer.dart';
import 'package:study_hub/features/social/presentation/widgets/social_user_card.dart';

class UsersDiscoverScreen extends StatefulWidget {
  const UsersDiscoverScreen({super.key});

  @override
  State<UsersDiscoverScreen> createState() => _UsersDiscoverScreenState();
}

class _UsersDiscoverScreenState extends State<UsersDiscoverScreen> {
  @override
  void initState() {
    super.initState();
    context.read<SocialBloc>().add(GetSocialDiscoverEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialBloc, SocialState>(
      builder: (context, state) {
        if (state.status == SocialStatus.loading &&
            state.discoverUsers.isEmpty) {
          return const SocialShimmer();
        }
        if (state.status == SocialStatus.error &&
            state.discoverUsers.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'An error occurred'));
        }
        if (state.discoverUsers.isEmpty) {
          return const SocialEmpty();
        }
        return CustomDotsRefreshIndicator(
          onRefresh: () async =>
              context.read<SocialBloc>().add(GetSocialDiscoverEvent()),
          child: ListView.builder(
            itemCount: state.discoverUsers.length,
            itemBuilder: (context, index) => SocialUserCard(
              userData: state.discoverUsers[index],
              source: SocialCardSource.discover,
            ),
          ),
        );
      },
    );
  }
}