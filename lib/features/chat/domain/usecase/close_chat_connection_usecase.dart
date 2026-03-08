import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';

@lazySingleton
class CloseChatConnectionUseCase {
  final ChatRepository repository;

  CloseChatConnectionUseCase(this.repository);

  void call() {
    repository.closeConnection();
  }
}