import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class GetGroupsUseCase {
  final GroupsRepository repository;

  GetGroupsUseCase({required this.repository});

  Future<List<GroupsEntity>> call() async {
    return await repository.getGroups();
  }
}
