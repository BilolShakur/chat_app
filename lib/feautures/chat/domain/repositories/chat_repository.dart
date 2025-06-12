import 'package:chat_app/core/models/message.dart';

abstract class ChatRepository {
  Stream<Message> getMessages();
  Future<void> sendMessage(Message message);
  Future<void> connect(String url);
  Future<void> disconnect();
}
