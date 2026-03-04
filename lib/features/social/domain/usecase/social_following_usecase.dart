import 'package:injectable/injectable.dart';
import 'package:study_hub/features/social/domain/entities/social_entity.dart';
import 'package:study_hub/features/social/domain/repo/social_repo.dart';

@injectable
class SocialFollowingUsecase {
  final SocialRepo repository;

  SocialFollowingUsecase(this.repository);

  Future<List<SocialEntity>> call({String? search}) {
    return repository.getSocialFollowing(search: search);
  }
}
