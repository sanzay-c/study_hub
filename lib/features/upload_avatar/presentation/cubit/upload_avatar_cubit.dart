import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/auth/domain/repo/auth_repo.dart';

import 'upload_avatar_state.dart';

@injectable
class UploadAvatarCubit extends Cubit<UploadAvatarState> {
  final AuthRepo _authRepo;
  final ImagePicker _picker = ImagePicker();

  UploadAvatarCubit(this._authRepo) : super(UploadAvatarInitial());

  Future<void> pickAndUploadImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 1000,
        maxHeight: 1000,
        imageQuality: 85,
      );

      if (pickedFile == null) return; // User cancelled

      await uploadImage(pickedFile.path);
    } catch (e) {
      emit(UploadAvatarError("Failed to pick image"));
    }
  }

  Future<void> uploadImage(String filePath) async {
    emit(UploadAvatarLoading());
    try {
      final updatedUser = await _authRepo.updateAvatar(filePath);
      emit(UploadAvatarSuccess(updatedUser));
    } catch (e) {
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(UploadAvatarError(errorMessage));
    }
  }
}