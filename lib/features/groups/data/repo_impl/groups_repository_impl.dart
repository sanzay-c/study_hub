import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/data/datasource/groups_remote_datasource.dart';
import 'package:study_hub/features/groups/data/model/create_new_group.dart';
import 'package:study_hub/features/groups/domain/entities/create_new_group_entity.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_detail_entity.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/entities/groups_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@LazySingleton(as: GroupsRepository)
class GroupsRepositoryImpl implements GroupsRepository {
  final GroupsRemoteDataSource remoteDataSource;

  GroupsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<List<GroupsEntity>> getGroups() async {
    final models = await remoteDataSource.getGroups();
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<List<GetGroupsEntity>> getAllGroups({String? tab}) async {
    final models = await remoteDataSource.getAllGroups(tab: tab);
    return models.map((e) => e.toEntity()).toList();
  }

  @override
  Future<GetGroupsDetailEntity> getGroupDetails(String groupId) async {
    try {
      // 1. Data Source bata Model line
      final model = await remoteDataSource.getGroupDetails(groupId);
      
      // 2. Model lai Entity ma map garera return garne
      return model.toEntity();
    } catch (e) {
      // Error handling (Tapaiko existing pattern anusar exception throw garne)
      rethrow; 
    }
  }
@override
  Future<CreateNewGroupEntity> createGroup(CreateNewGroupEntity groupEntity, {XFile? image}) async {
    try {
      // 1. Entity lai Model (DTO) ma convert garne
      // Note: Model class ma fromEntity constructor chhaina bhane manual mapping garne
      final groupModel = CreateNewGroup(
        id: groupEntity.id,
        name: groupEntity.name,
        description: groupEntity.description,
        subject: groupEntity.subject,
        createdBy: groupEntity.createdBy,
        members: groupEntity.members,
        isPublic: groupEntity.isPublic,
        imagePath: groupEntity.imagePath,
        createdAt: groupEntity.createdAt,
        creatorName: groupEntity.creatorName,
        imageUrl: groupEntity.imageUrl,
      );

      // 2. Data Source lai JSON pathaune
      final resultModel = await remoteDataSource.createGroup(groupModel.toJson(), image: image);

      // 3. Result Model lai Entity ma map garera return garne
      return resultModel.toEntity();
    } catch (e) {
      // Error handle garne (jastai custom failure return garne or rethrow)
      rethrow;
    }
  }
}
