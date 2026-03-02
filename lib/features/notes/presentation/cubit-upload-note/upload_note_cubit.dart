import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/notes/domain/usecase/upload_note_usecase.dart';

part 'upload_note_state.dart';

@injectable
class UploadNoteCubit extends Cubit<UploadNoteState> {
  final UploadNoteUseCase uploadNoteUseCase;

  UploadNoteCubit({required this.uploadNoteUseCase}) : super(UploadNoteInitial());

  Future<void> uploadNote({required String groupId, required String filePath}) async {
    emit(UploadNoteLoading());
    try {
      await uploadNoteUseCase(groupId: groupId, filePath: filePath);
      emit(UploadNoteSuccess());
    } catch (e) {
      emit(UploadNoteError(message: e.toString()));
    }
  }
}
