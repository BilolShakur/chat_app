import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';

class GetMessages {
  final ChatRepository repository;

  GetMessages(this.repository);

  Stream<Message> call() {
    return repository.getMessages();
  }
}
