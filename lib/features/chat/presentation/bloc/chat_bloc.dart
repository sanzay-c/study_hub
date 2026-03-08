import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:study_hub/features/chat/data/model/message_model.dart';
import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';
import 'package:study_hub/features/chat/domain/usecase/close_chat_connection_usecase.dart';
import 'package:study_hub/features/chat/domain/usecase/connect_chat_usecase.dart';
import 'package:study_hub/features/chat/domain/usecase/get_chat_history_usecase.dart';
import 'package:study_hub/features/chat/domain/usecase/send_message_usecase.dart';
import 'package:study_hub/features/chat/presentation/bloc/chat_state.dart';

part 'chat_event.dart';

@injectable
class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final GetChatHistoryUseCase _getHistory;
  final ConnectChatUseCase _connectChat;
  final SendChatMessageUseCase _sendMessage;
final CloseChatConnectionUseCase _closeChatConnection;

  StreamSubscription? _chatSubscription;

  ChatBloc(
    this._getHistory,
    this._connectChat,
    this._sendMessage,
    this._closeChatConnection,
  ) : super(const ChatState()) {
    
    // 1. History load garne ra WebSocket connect garne
    on<LoadChatHistoryEvent>((event, emit) async {
      emit(state.copyWith(status: ChatStatus.loading));
      try {
        // History Fetch
        final history = await _getHistory(
          id: event.id, 
          isGroup: event.isGroup, 
          currentUserId: event.currentUserId
        );
        emit(state.copyWith(status: ChatStatus.success, messages: history));

        // Stream Connection
        _chatSubscription?.cancel();
        _chatSubscription = _connectChat(
          token: event.token,
          myId: event.currentUserId,
          otherUserId: event.otherUserId,
          groupId: event.isGroup ? event.id : null,
          isGroup: event.isGroup,
        ).listen((data) {
          add(OnMessageReceivedEvent(data, event.currentUserId));
        });

        emit(state.copyWith(isConnectionActive: true));
      } catch (e) {
        emit(state.copyWith(status: ChatStatus.error, errorMessage: e.toString()));
      }
    });

    // 2. Real-time message list ma thapne
    on<OnMessageReceivedEvent>((event, emit) {
      try {
        final json = jsonDecode(event.data);
        final model = ChatMessageModel.fromJson(json);
        final entity = model.toEntity(event.currentUserId);

        final updatedMessages = List<ChatMessageEntity>.from(state.messages)..add(entity);
        emit(state.copyWith(messages: updatedMessages));
      } catch (e) {
        // Parsing error
      }
    });

    // 3. Message pathaune
    on<SendMessageEvent>((event, emit) {
      _sendMessage(
        message: event.message,
        senderId: event.senderId,
        receiverId: event.receiverId,
        isGroup: event.isGroup,
      );
    });
  }

 @override
  Future<void> close() {
    _chatSubscription?.cancel();
    _closeChatConnection(); // Use Case call gareko (call() method trigger hunchha)
    return super.close();
  }
}
