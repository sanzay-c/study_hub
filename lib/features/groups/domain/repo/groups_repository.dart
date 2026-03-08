import 'package:image_picker/image_picker.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';

abstract class GroupsRepository {
  Future<List<GroupsEntity>> getGroups();
  Future<List<GetGroupsEntity>> getAllGroups({String? tab}); // groups like discover, joined. created
  Future<GetGroupsDetailEntity> getGroupDetails(String groupId);
  Future<CreateNewGroupEntity> createGroup(CreateNewGroupEntity groupEntity, {XFile? image});
  Future<void> joinGroup(String groupId);
  Future<void> leaveGroup(String groupId);
  Future<CreateNewGroupEntity> updateGroup(String groupId, CreateNewGroupEntity groupEntity, {XFile? image});
  Future<void> deleteGroup(String groupId);
}
