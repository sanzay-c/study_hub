import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';

@lazySingleton
class ConnectChatUseCase {
  final ChatRepository repository;
  ConnectChatUseCase(this.repository);

  Stream<dynamic> call({
    required String token,
    String? otherUserId,
    String? groupId,
    required bool isGroup,
    required String myId,
  }) {
    if (isGroup) {
      return repository.connectToGroup(groupId!, token);
    } else {
      return repository.connectToDM(myId, otherUserId!, token);
    }
  }
}