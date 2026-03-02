import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';

abstract class GroupsRepository {
  Future<List<GroupsEntity>> getGroups();
}
