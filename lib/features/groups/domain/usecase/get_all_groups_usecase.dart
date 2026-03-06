import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class GetAllGroupsUsecase {
  final GroupsRepository repository;

  GetAllGroupsUsecase(this.repository);

  Future<List<GetGroupsEntity>> call({String? tab}) async {
    return await repository.getAllGroups(tab: tab);
  }
}