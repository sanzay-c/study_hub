import 'package:equatable/equatable.dart';
import 'package:study_hub/features/notes/domain/entities/notes_entity.dart';

enum NotesStatus { initial, loading, success, error }

class NotesState extends Equatable {
  final NotesStatus status;
  final List<NotesEntity> myNotes;
  final List<NotesEntity> discoverNotes;
  final bool hasMoreMyNotes;      // ✅ छुट्टाछुट्टै
  final bool hasMoreDiscover;     // ✅ छुट्टाछुट्टै
  final String? errorMessage;
  
  // Download related state
  final String? downloadingNoteId;
  final bool? downloadSuccess;
  final String? downloadError;

  const NotesState({
    this.status = NotesStatus.initial,
    this.myNotes = const [],
    this.discoverNotes = const [],
    this.hasMoreMyNotes = true,   // ✅
    this.hasMoreDiscover = true,  // ✅
    this.errorMessage,
    this.downloadingNoteId,
    this.downloadSuccess,
    this.downloadError,
  });

  NotesState copyWith({
    NotesStatus? status,
    List<NotesEntity>? myNotes,
    List<NotesEntity>? discoverNotes,
    bool? hasMoreMyNotes,
    bool? hasMoreDiscover,
    String? errorMessage,
    String? downloadingNoteId,
    bool? downloadSuccess,
    String? downloadError,
  }) {
    return NotesState(
      status: status ?? this.status,
      myNotes: myNotes ?? this.myNotes,
      discoverNotes: discoverNotes ?? this.discoverNotes,
      hasMoreMyNotes: hasMoreMyNotes ?? this.hasMoreMyNotes,
      hasMoreDiscover: hasMoreDiscover ?? this.hasMoreDiscover,
      errorMessage: errorMessage ?? this.errorMessage,
      downloadingNoteId: downloadingNoteId, // Always take the new value (even if null)
      downloadSuccess: downloadSuccess,
      downloadError: downloadError,
    );
  }

  @override
  List<Object?> get props => [
        status,
        myNotes,
        discoverNotes,
        hasMoreMyNotes,
        hasMoreDiscover,
        errorMessage,
        downloadingNoteId,
        downloadSuccess,
        downloadError,
      ];
}