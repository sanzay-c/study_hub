import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/profile/domain/usecase/update_full_name_usecase.dart';
import 'package:study_hub/features/profile/presentation/cubit/profile_state.dart';

@injectable
class ProfileCubit extends Cubit<ProfileState> {
  final UpdateFullNameUseCase _updateFullNameUseCase;

  ProfileCubit(this._updateFullNameUseCase) : super(const ProfileState());

  Future<void> updateFullName(String fullName) async {
    if (fullName.trim().isEmpty) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: "Full name cannot be empty",
      ));
      return;
    }

    emit(state.copyWith(status: ProfileStatus.loading));

    try {
      final updatedUser = await _updateFullNameUseCase(fullName);
      emit(state.copyWith(
        status: ProfileStatus.success,
        user: updatedUser,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProfileStatus.error,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      ));
    }
  }

  void resetStatus() {
    emit(state.copyWith(status: ProfileStatus.initial));
  }
}
