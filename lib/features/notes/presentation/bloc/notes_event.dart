part of 'notes_bloc.dart';

@immutable
sealed class NotesEvent extends Equatable {}

class GetMyNotesEvent extends NotesEvent {
  final bool isRefresh;
  GetMyNotesEvent({this.isRefresh = false});
  
  @override
  List<Object?> get props => [isRefresh];
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
  GetDiscoverNotesEvent({this.isRefresh = false});
  
  @override
  List<Object?> get props => [isRefresh];
}