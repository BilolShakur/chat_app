import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/feautures/chat/data/datasources/chat_remote_data_source.dart';
import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';

class ChatRepositoryImpl implements ChatRepository {
  final ChatRemoteDataSource remoteDataSource;

  ChatRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<Message> getMessages() {
    return remoteDataSource.getMessages();
  }

  @override
  Future<void> sendMessage(Message message) async {
    remoteDataSource.sendMessage(message);
  }

  @override
  Future<void> connect(String url) async {
    remoteDataSource.connect(url);
  }

  @override
  Future<void> disconnect() async {
    remoteDataSource.disconnect();
  }
} 