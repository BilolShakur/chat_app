import 'dart:convert';

import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/feautures/chat/data/datasources/chat_remote_data_source.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatRemoteDataSourceImpl implements ChatRemoteDataSource {
  WebSocketChannel? _channel;

  @override
  Stream<Message> getMessages() {
    if (_channel == null) {
      throw Exception("WebSocket not connected");
    }
    return _channel!.stream.map((event) {
      final Map<String, dynamic> json = jsonDecode(event);
      return Message.fromJson(json);
    });
  }

  @override
  void sendMessage(Message message) {
    if (_channel == null) {
      throw Exception("WebSocket not connected");
    }
    _channel!.sink.add(jsonEncode(message.toJson()));
  }

  @override
  void connect(String url) {
    _channel = WebSocketChannel.connect(Uri.parse(url));
  }

  @override
  void disconnect() {
    _channel?.sink.close();
    _channel = null;
  }
} 