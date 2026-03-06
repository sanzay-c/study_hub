import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';

abstract class GroupsRepository {
  Future<List<GroupsEntity>> getGroups();
  Future<List<GetGroupsEntity>> getAllGroups({String? tab}); // groups like discover, joined. created
}
