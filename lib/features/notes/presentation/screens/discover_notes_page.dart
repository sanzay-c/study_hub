import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_state.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_lists.dart';
import 'package:study_hub/features/notes/presentation/screens/widgets/notes_shimmer.dart';

class DiscoverNotesPage extends StatefulWidget {
  const DiscoverNotesPage({super.key});

  @override
  State<DiscoverNotesPage> createState() => _DiscoverNotesPageState();
}

class _DiscoverNotesPageState extends State<DiscoverNotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(GetDiscoverNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.status == NotesStatus.loading && state.discoverNotes.isEmpty) {
          return const NotesShimmer();
        }

        if (state.status == NotesStatus.error && state.discoverNotes.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }

        if (state.status == NotesStatus.success && state.discoverNotes.isEmpty) {
          return const Center(child: Text('No notes found'));
        }

        return CustomDotsRefreshIndicator(
          onRefresh: () async {
            context.read<NotesBloc>().add(
                  GetDiscoverNotesEvent(isRefresh: true),
                );
            // Ensure the BLoC operation completes before finishing refresh
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: ListView.builder(
            controller: context.read<NotesBloc>().discoverScrollController,
            itemCount: state.discoverNotes.length + (state.hasMoreDiscover ? 1 : 0),
            physics: const BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            itemBuilder: (context, index) {
              if (index == state.discoverNotes.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return FileCard(note: state.discoverNotes[index]);
            },
          ),
        );
      },
    );
  }
}

