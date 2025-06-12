import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';

class DisconnectFromChat {
  final ChatRepository repository;

  DisconnectFromChat(this.repository);

  Future<void> call() async {
    await repository.disconnect();
  }
}
