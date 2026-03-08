part of 'chat_bloc.dart';


abstract class ChatEvent extends Equatable {
  const ChatEvent();
  @override
  List<Object?> get props => [];
}

class LoadChatHistoryEvent extends ChatEvent {
  final String id;
  final bool isGroup;
  final String currentUserId;
  final String token;
  final String? otherUserId;

  const LoadChatHistoryEvent({
    required this.id,
    required this.isGroup,
    required this.currentUserId,
    required this.token,
    this.otherUserId,
  });
}

class OnMessageReceivedEvent extends ChatEvent {
  final dynamic data;
  final String currentUserId;

  const OnMessageReceivedEvent(this.data, this.currentUserId);
}

class SendMessageEvent extends ChatEvent {
  final String message;
  final String senderId;
  final String? receiverId;
  final bool isGroup;

  const SendMessageEvent({
    required this.message,
    required this.senderId,
    this.receiverId,
    this.isGroup = false,
  });
}