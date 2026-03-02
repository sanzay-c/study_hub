import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/domain/usecase/get_discover_notes_usecase.dart';
import 'package:study_hub/features/notes/domain/usecase/get_my_notes_usecase.dart';
import 'package:study_hub/features/notes/domain/usecase/download_note_usecase.dart';
import 'package:study_hub/features/notes/presentation/bloc/notes_state.dart';

part 'notes_event.dart';

@injectable
class NotesBloc extends Bloc<NotesEvent, NotesState> {
  final GetDiscoverNotesUsecase getDiscoverNotesUsecase;
  final GetMyNotesUseCase getMyNotesUseCase;
  final DownloadNoteUseCase downloadNoteUseCase;

  int _myNotesPage = 1;
  int _discoverPage = 1;
  String? _currentMyNotesSearch; // for search
  String? _currentDiscoverSearch; // for search
  final int _limit = 10;
  final ScrollController scrollController = ScrollController();

  final ScrollController discoverScrollController = ScrollController();
  final ScrollController myNotesScrollController = ScrollController();

  NotesBloc(
    this.getDiscoverNotesUsecase,
    this.getMyNotesUseCase,
    this.downloadNoteUseCase,
  ) : super(const NotesState()) {
    on<GetMyNotesEvent>(_onGetMyNotesEvent);
    on<GetDiscoverNotesEvent>(_onGetDiscoverNotesEvent);
    on<DownloadNoteRequested>(_onDownloadNoteRequested);

    // scrollController.addListener(() {
    //   if (scrollController.position.pixels >=
    //       scrollController.position.maxScrollExtent - 200) {
    //     add(GetDiscoverNotesEvent());
    //   }
    // });

    discoverScrollController.addListener(() {
      if (discoverScrollController.position.pixels >=
          discoverScrollController.position.maxScrollExtent - 200) {
        add(GetDiscoverNotesEvent());
      }
    });

    myNotesScrollController.addListener(() {
      if (myNotesScrollController.position.pixels >=
          myNotesScrollController.position.maxScrollExtent - 200) {
        add(GetMyNotesEvent());
      }
    });
  }

  @override
  Future<void> close() {
    discoverScrollController.dispose();
    myNotesScrollController.dispose();
    return super.close();
  }

  FutureOr<void> _onGetMyNotesEvent(
    GetMyNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    final bool isNewSearch = event.search != _currentMyNotesSearch;

    if (event.isRefresh || isNewSearch) {
      _myNotesPage = 1;
      _currentMyNotesSearch = event.search;
      emit(
        state.copyWith(
          myNotes: [],
          hasMoreMyNotes: true,
          status: NotesStatus.initial,
        ),
      );
    }

    if (state.status == NotesStatus.loading) return;
    if (!state.hasMoreMyNotes && !event.isRefresh && !isNewSearch) return; // ✅

    emit(state.copyWith(status: NotesStatus.loading));

    try {
      final notes = await getMyNotesUseCase(
        page: _myNotesPage,
        limit: _limit,
        search: _currentMyNotesSearch,
      );
      _myNotesPage++;
      emit(
        state.copyWith(
          status: NotesStatus.success,
          myNotes: [...state.myNotes, ...notes],
          hasMoreMyNotes: notes.length >= _limit, //
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: NotesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onGetDiscoverNotesEvent(
    GetDiscoverNotesEvent event,
    Emitter<NotesState> emit,
  ) async {
    final bool isNewSearch = event.search != _currentDiscoverSearch;

    if (event.isRefresh || isNewSearch) {
      _discoverPage = 1;
      _currentDiscoverSearch = event.search;
      emit(
        state.copyWith(
          discoverNotes: [],
          hasMoreDiscover: true,
          status: NotesStatus.initial,
        ),
      );
    }

    if (state.status == NotesStatus.loading) return;
    if (!state.hasMoreDiscover && !event.isRefresh && !isNewSearch) return; // ✅

    emit(state.copyWith(status: NotesStatus.loading));

    try {
      final notes = await getDiscoverNotesUsecase(
        page: _discoverPage,
        limit: _limit,
        search: _currentDiscoverSearch,
      );
      _discoverPage++;
      emit(
        state.copyWith(
          status: NotesStatus.success,
          discoverNotes: [...state.discoverNotes, ...notes],
          hasMoreDiscover: notes.length >= _limit, // ✅
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: NotesStatus.error, errorMessage: e.toString()),
      );
    }
  }

  FutureOr<void> _onDownloadNoteRequested(
    DownloadNoteRequested event,
    Emitter<NotesState> emit,
  ) async {
    emit(
      state.copyWith(
        downloadingNoteId: event.noteId,
        downloadSuccess: null,
        downloadError: null,
      ),
    );

    try {
      await downloadNoteUseCase(noteId: event.noteId, fileName: event.fileName);
      emit(state.copyWith(downloadingNoteId: null, downloadSuccess: true));
    } catch (e) {
      emit(
        state.copyWith(downloadingNoteId: null, downloadError: e.toString()),
      );
    }
  }
}
