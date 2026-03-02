part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent extends Equatable {}

class GetMyNotesEvent extends NotesEvent {
  final bool isRefresh;
  final String? search;
  GetMyNotesEvent({this.isRefresh = false, this.search});
  
  @override
  List<Object?> get props => [isRefresh, search];
}

class DownloadNoteRequested extends NotesEvent {
  final String noteId;
  final String fileName;

  DownloadNoteRequested({required this.noteId, required this.fileName});

  @override
  List<Object?> get props => [noteId, fileName];
}

class GetDiscoverNotesEvent extends NotesEvent {
  final bool isRefresh;
  final String? search;
  GetDiscoverNotesEvent({this.isRefresh = false, this.search});
  
  @override
  List<Object?> get props => [isRefresh, search];
}