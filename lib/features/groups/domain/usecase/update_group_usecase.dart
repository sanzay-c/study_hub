import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@lazySingleton
class UpdateGroupUseCase {
  final GroupsRepository repository;

  UpdateGroupUseCase(this.repository);

  Future<CreateNewGroupEntity> call(String groupId, CreateNewGroupEntity group, {XFile? image}) async {
    return await repository.updateGroup(groupId, group, image: image);
  }
}