import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class JoinGroupUseCase {
  final GroupsRepository repository;

  JoinGroupUseCase(this.repository);

  Future<void> call(String groupId) async {
    return await repository.joinGroup(groupId);
  }
}