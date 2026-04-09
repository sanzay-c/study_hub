import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart';
import 'package:study_hub/features/groups/domain/repo/groups_repository.dart';

@lazySingleton
class GetUnifiedChatListUseCase {
  final GroupsRepository groupsRepository;
  final ChatRepository chatRepository;

  GetUnifiedChatListUseCase({
    required this.groupsRepository,
    required this.chatRepository,
  });

  Future<List<GetGroupsEntity>> call() async {
    try {
      // Fetch both Groups and DMs in parallel for efficiency
      final results = await Future.wait([
        groupsRepository.getAllGroups(tab: 'joined'),
        chatRepository.getRecentDMs(),
      ]);

      final List<GetGroupsEntity> groups = results[0];
      final List<GetGroupsEntity> dms = results[1];

      // Combine both lists
      final List<GetGroupsEntity> unifiedList = [...groups, ...dms];

      // Sort by the latest message time (descending)
      // If a chat has no last message yet, fall back to the creation time
      unifiedList.sort((a, b) {
        final timeA = a.lastMessageTime ?? a.createdAt;
        final timeB = b.lastMessageTime ?? b.createdAt;
        return timeB.compareTo(timeA);
      });

      return unifiedList;
    } catch (e) {
      rethrow;
    }
  }
}
