import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';

class ConnectToChat {
  final ChatRepository repository;

  ConnectToChat(this.repository);

  Future<void> call(String url) async {
    await repository.connect(url);
  }
}
