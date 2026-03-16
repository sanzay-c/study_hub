import 'package:equatable/equatable.dart';
import 'package:study_hub/features/chat/domain/entities/chat_message_entity.dart';

enum ChatStatus { initial, loading, success, error }

class ChatState extends Equatable {
  final ChatStatus status;
  final List<ChatMessageEntity> messages;
  final String? errorMessage;
  
  // Connection status (WSS active chha ki chhaina)
  final bool isConnectionActive;
  
  // Message send garda loading dekhauna (Optional)
  final bool isSending;

  final Set<String> sendingMessageIds;

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.errorMessage,
    this.isConnectionActive = false,
    this.isSending = false,
    this.sendingMessageIds = const {},
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessageEntity>? messages,
    String? errorMessage,
    bool? isConnectionActive,
    bool? isSending,
    Set<String>? sendingMessageIds,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      isConnectionActive: isConnectionActive ?? this.isConnectionActive,
      isSending: isSending ?? this.isSending,
      sendingMessageIds: sendingMessageIds ?? this.sendingMessageIds,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messages,
        errorMessage,
        isConnectionActive,
        isSending,
        sendingMessageIds,
      ];
}