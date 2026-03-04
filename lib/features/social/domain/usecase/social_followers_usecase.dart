import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@injectable
class SocialFollowersUsecase {
  final SocialRepo repository;

  SocialFollowersUsecase(this.repository);

  Future<List<SocialEntity>> call({String? search}) {
    return repository.getSocialFollowers(search: search);
  }
}
