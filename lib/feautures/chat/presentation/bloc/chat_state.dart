import 'package:chat_app/core/models/message.dart';

abstract class ChatState {
  final List<Message> messages;

  ChatState({this.messages = const []});
}

class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}

class ChatConnected extends ChatState {
  ChatConnected({required super.messages});
}

class ChatDisconnected extends ChatState {}

class ChatError extends ChatState {
  final String message;

  ChatError(this.message, {super.messages});
}
