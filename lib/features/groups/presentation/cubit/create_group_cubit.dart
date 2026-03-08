import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';
import 'package:study_hub/features/groups/domain/usecase/update_group_usecase.dart';
import 'create_group_state.dart';

@injectable
class CreateGroupCubit extends Cubit<CreateGroupState> {
  final GroupsRepository _repository;
  final UpdateGroupUseCase _updateGroupUseCase; 

  CreateGroupCubit(
    this._repository,
    this._updateGroupUseCase, 
  ) : super(const CreateGroupState());

  void initializeForUpdate({
    required String groupId,
    required String name,
    required String description,
    required bool isPublic,
  }) {
    emit(state.copyWith(
      groupId: groupId,
      name: name,
      description: description,
      isPublic: isPublic,
    ));
  }

  void onNameChanged(String value) => emit(state.copyWith(name: value));
  
  void onDescriptionChanged(String value) => emit(state.copyWith(description: value));
  
  void onVisibilityChanged(bool isPublic) => emit(state.copyWith(isPublic: isPublic));

  void onImagePicked(XFile? image) => emit(state.copyWith(image: image));

  Future<void> submitGroup() async {
    if (state.name.isEmpty) {
      emit(state.copyWith(error: "Group name cannot be empty"));
      return;
    }

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final entity = CreateNewGroupEntity(
        id: state.groupId ?? '', 
        name: state.name,
        description: state.description,
        subject: null,
        createdBy: '',
        members: const [],
        isPublic: state.isPublic,
        imagePath: '',
        createdAt: DateTime.now(),
        creatorName: '',
        imageUrl: '',
      );

      if (state.groupId != null) {
        await _updateGroupUseCase(state.groupId!, entity, image: state.image);
      } else {
        await _repository.createGroup(entity, image: state.image);
      }
      
      emit(state.copyWith(isLoading: false, isSuccess: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}