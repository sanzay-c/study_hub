import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class LeaveGroupUseCase {
  final GroupsRepository repository;

  LeaveGroupUseCase(this.repository);

  Future<void> call(String groupId) async {
    return await repository.leaveGroup(groupId);
  }
}