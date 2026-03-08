import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../core/network/api_endpoints.dart' show ApiEndpoints;

abstract class ChatRemoteDataSource {
  // WSS Methods
  Stream<dynamic> connectToDM(String userIdA, String userIdB, String token);
  Stream<dynamic> connectToGroup(String groupId, String token);
  void sendMessage(Map<String, dynamic> messageData);
  void close();

  // HTTP History Methods
  Future<List<dynamic>> getGroupHistory(String groupId);
  Future<List<dynamic>> getDMHistory(String otherUserId);
}


@LazySingleton(as: ChatRemoteDataSource)
class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  final Dio dio; 
  WebSocketChannel? _channel;

  ChatRemoteDataSourceImpl({required this.dio});

  @override
  Stream<dynamic> connectToDM(String userIdA, String userIdB, String token) {
    // Timro comment anusar: ?token=<access_token> thapne
    final url = "${ApiEndpoints.dmMessage(userIdA, userIdB)}?token=$token";
    _channel = WebSocketChannel.connect(Uri.parse(url));
    return _channel!.stream;
  }

  @override
  Stream<dynamic> connectToGroup(String groupId, String token) {
    final url = "${ApiEndpoints.messageGroup(groupId)}?token=$token";
    _channel = WebSocketChannel.connect(Uri.parse(url));
    return _channel!.stream;
  }

  @override
  void sendMessage(Map<String, dynamic> messageData) {
    if (_channel != null) {
      // Direct JSON object nai pathaine (Use Case bata filter bhayera aauchha)
      _channel!.sink.add(jsonEncode(messageData));
    }
  }

  @override
  Future<List<dynamic>> getGroupHistory(String groupId) async {
    final response = await dio.get(ApiEndpoints.groupHistoryMessage(groupId));
    return response.data as List;
  }

  @override
  Future<List<dynamic>> getDMHistory(String otherUserId) async {
    final response = await dio.get(ApiEndpoints.dmHistoryMessage(otherUserId));
    return response.data as List;
  }

  @override
  void close() {
    _channel?.sink.close();
    _channel = null;
  }
}