import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@lazySingleton
class DeleteGroupUseCase {
  final GroupsRepository repository;

  DeleteGroupUseCase(this.repository);

  Future<void> call(String groupId) async {
    return await repository.deleteGroup(groupId);
  }
}