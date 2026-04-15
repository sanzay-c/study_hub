import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:study_hub/common/widgets/custom_dots_refresh_indicator.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_state.dart';
import 'package:study_hub/features/notes/presentation/screens/notes_lists.dart';
import 'package:study_hub/features/notes/presentation/screens/widgets/notes_empty.dart';
import 'package:study_hub/features/notes/presentation/screens/widgets/notes_shimmer.dart';

class MyNotesPage extends StatefulWidget {
  const MyNotesPage({super.key});

  @override
  State<MyNotesPage> createState() => _MyNotesPageState();
}

class _MyNotesPageState extends State<MyNotesPage> {
  @override
  void initState() {
    super.initState();
    context.read<NotesBloc>().add(GetMyNotesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesBloc, NotesState>(
      builder: (context, state) {
        if (state.status == NotesStatus.loading && state.myNotes.isEmpty) {
          return NotesShimmer();
        }

        if (state.status == NotesStatus.error && state.myNotes.isEmpty) {
          return Center(child: Text(state.errorMessage ?? 'Error'));
        }

        if (state.status == NotesStatus.success && state.myNotes.isEmpty) {
          return const NotesEmpty();
        }

        return CustomDotsRefreshIndicator(
          onRefresh: () async {
            context.read<NotesBloc>().add(GetMyNotesEvent(isRefresh: true));
          },
          child: ListView.builder(
            // controller: context.read<NotesBloc>().scrollController,
            controller: context.read<NotesBloc>().myNotesScrollController,
            // itemCount: state.myNotes.length + (state.hasMore ? 1 : 0),
            itemCount:
                state.myNotes.length + (state.hasMoreMyNotes ? 1 : 0), 
            itemBuilder: (context, index) {
              if (index == state.myNotes.length) {
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              return FileCard(note: state.myNotes[index]);
            },
          ),
        );
      },
    );
  }
}
