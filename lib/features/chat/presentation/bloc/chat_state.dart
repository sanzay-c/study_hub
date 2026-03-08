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

  const ChatState({
    this.status = ChatStatus.initial,
    this.messages = const [],
    this.errorMessage,
    this.isConnectionActive = false,
    this.isSending = false,
  });

  ChatState copyWith({
    ChatStatus? status,
    List<ChatMessageEntity>? messages,
    String? errorMessage,
    bool? isConnectionActive,
    bool? isSending,
  }) {
    return ChatState(
      status: status ?? this.status,
      messages: messages ?? this.messages,
      errorMessage: errorMessage ?? this.errorMessage,
      isConnectionActive: isConnectionActive ?? this.isConnectionActive,
      isSending: isSending ?? this.isSending,
    );
  }

  @override
  List<Object?> get props => [
        status,
        messages,
        errorMessage,
        isConnectionActive,
        isSending,
      ];
}