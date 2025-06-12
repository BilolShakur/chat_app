import 'package:chat_app/core/models/message.dart';

abstract class ChatRemoteDataSource {
  Stream<Message> getMessages();
  void sendMessage(Message message);
  void connect(String url);
  void disconnect();
}
