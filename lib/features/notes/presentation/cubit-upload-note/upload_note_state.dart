part of 'upload_note_cubit.dart';

abstract class UploadNoteState extends Equatable {
  const UploadNoteState();

  @override
  List<Object> get props => [];
}

class UploadNoteInitial extends UploadNoteState {}

class UploadNoteLoading extends UploadNoteState {}

class UploadNoteSuccess extends UploadNoteState {}

class UploadNoteError extends UploadNoteState {
  final String message;

  const UploadNoteError({required this.message});

  @override
  List<Object> get props => [message];
}
