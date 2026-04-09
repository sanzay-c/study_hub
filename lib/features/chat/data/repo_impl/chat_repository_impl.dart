import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/data/datasource/chat_remote_datasource.dart';
import 'package:study_hub/features/chat/data/model/message_model.dart';
import 'package:study_hub/features/chat/data/model/recent_dm_model.dart'; // New Import
import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';
import 'package:study_hub/features/chat/domain/repo/chat_repository.dart';
import 'package:study_hub/features/groups/domain/entities/get_groups_entity.dart'; // Entity Import

@LazySingleton(as: ChatRepository)
class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;
  // Note: Timile user ID nikalna LocalDataSource use gareko chau bhane teslai pani inject gara
  // final AuthLocalDataSource localDataSource; 

  ChatRepositoryImpl({required this.remoteDataSource});

  // --- Real-time WebSocket Methods ---

  @override
  Stream<dynamic> connectToDM(String userIdA, String userIdB, String token) {
    return remoteDataSource.connectToDM(userIdA, userIdB, token);
  }

  @override
  Stream<dynamic> connectToGroup(String groupId, String token) {
    return remoteDataSource.connectToGroup(groupId, token);
  }

  @override
  void sendMessage(Map<String, dynamic> messageData) {
    remoteDataSource.sendMessage(messageData);
  }

  @override
  void closeConnection() {
    remoteDataSource.close();
  }

  // --- HTTP History Methods with Mapping ---

  @override
  Future<List<ChatMessageEntity>> getDMHistory(String otherUserId, String currentUserId) async {
    try {
      final List<dynamic> data = await remoteDataSource.getDMHistory(otherUserId);
      
      // JSON -> Model -> Entity (passing currentUserId for isMe logic)
      return data.map((json) => 
        ChatMessageModel.fromJson(json).toEntity(currentUserId)
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<ChatMessageEntity>> getGroupHistory(String groupId, String currentUserId) async {
    try {
      final List<dynamic> data = await remoteDataSource.getGroupHistory(groupId);
      
      return data.map((json) => 
        ChatMessageModel.fromJson(json).toEntity(currentUserId)
      ).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GetGroupsEntity>> getRecentDMs() async {
    try {
      final List<dynamic> data = await remoteDataSource.getRecentDMs();
      return data.map((json) => RecentDmModel.fromJson(json).toEntity()).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> markAsRead(String id, {required bool isGroup}) async {
    await remoteDataSource.markAsRead(id, isGroup: isGroup);
  }
}