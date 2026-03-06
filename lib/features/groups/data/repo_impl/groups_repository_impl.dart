import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/data/datasource/groups_remote_datasource.dart';
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
}
