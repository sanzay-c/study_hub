import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

class CreateGroupUseCase {
  final GroupsRepository repository;

  CreateGroupUseCase(this.repository);

  Future<CreateNewGroupEntity> call(CreateNewGroupEntity group) {
    return repository.createGroup(group);
  }
}