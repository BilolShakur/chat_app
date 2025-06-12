import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';

class SendMessage {
  final ChatRepository repository;

  SendMessage(this.repository);

  Future<void> call(Message message) async {
    await repository.sendMessage(message);
  }
} 