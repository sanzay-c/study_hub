import 'package:injectable/injectable.dart';
import 'package:study_hub/features/groups/domain/entities/pagination_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@injectable
class GetAllGroupsUsecase {
  final GroupsRepository repository;

  GetAllGroupsUsecase(this.repository);

  Future<PaginatedGroupsEntity> call({String? tab, int page = 1, int limit = 50}) async {
    return await repository.getAllGroups(tab: tab, page: page, limit: limit);
  }
}