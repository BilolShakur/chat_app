import 'package:chat_app/core/models/message.dart';

abstract class ChatEvent {}

class ConnectEvent extends ChatEvent {
  final String url;

  ConnectEvent(this.url);
}

class DisconnectEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final Message message;

  SendMessageEvent(this.message);
}

class ReceiveMessageEvent extends ChatEvent {
  final Message message;

  ReceiveMessageEvent(this.message);
}
