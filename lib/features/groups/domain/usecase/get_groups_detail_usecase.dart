import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class GetGroupDetailsUseCase {
  final GroupsRepository repository;

  GetGroupDetailsUseCase(this.repository);

  Future<GetGroupsDetailEntity> call(String groupId) async {
    return await repository.getGroupDetails(groupId);
  }
}