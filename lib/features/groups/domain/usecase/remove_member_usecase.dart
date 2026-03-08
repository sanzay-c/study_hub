import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@lazySingleton
class RemoveMemberUseCase {
  final GroupsRepository repository;

  RemoveMemberUseCase(this.repository);
  
  Future<void> call(String groupId, String userId) async {
    return await repository.removeMember(groupId, userId);
  }
}