import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/feautures/chat/domain/usecases/connect_to_chat.dart';
import 'package:chat_app/feautures/chat/domain/usecases/disconnect_from_chat.dart';
import 'package:chat_app/feautures/chat/domain/usecases/get_messages.dart';
import 'package:chat_app/feautures/chat/domain/usecases/send_message.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ConnectToChat connectToChat;
  final DisconnectFromChat disconnectFromChat;
  final GetMessages getMessages;
  final SendMessage sendMessage;

  StreamSubscription? _messagesSubscription;

  ChatBloc({
    required this.connectToChat,
    required this.disconnectFromChat,
    required this.getMessages,
    required this.sendMessage,
  }) : super(ChatInitial()) {
    on<ConnectEvent>(_onConnectEvent);
    on<DisconnectEvent>(_onDisconnectEvent);
    on<SendMessageEvent>(_onSendMessageEvent);
    on<ReceiveMessageEvent>(_onReceiveMessageEvent);
  }

  Future<void> _onConnectEvent(
    ConnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    emit(ChatLoading());
    try {
      await connectToChat(event.url);
      _messagesSubscription = getMessages().listen(
        (message) => add(ReceiveMessageEvent(message)),
        onError: (error) =>
            emit(ChatError(error.toString(), messages: state.messages)),
      );
      emit(ChatConnected(messages: state.messages));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> _onDisconnectEvent(
    DisconnectEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await disconnectFromChat();
      await _messagesSubscription?.cancel();
      emit(ChatDisconnected());
    } catch (e) {
      emit(ChatError(e.toString(), messages: state.messages));
    }
  }

  Future<void> _onSendMessageEvent(
    SendMessageEvent event,
    Emitter<ChatState> emit,
  ) async {
    try {
      await sendMessage(event.message);
      // Optimistically add the message to the UI
      final updatedMessages = List<Message>.from(state.messages)
        ..add(event.message);
      emit(ChatConnected(messages: updatedMessages));
    } catch (e) {
      emit(ChatError(e.toString(), messages: state.messages));
    }
  }

  void _onReceiveMessageEvent(
    ReceiveMessageEvent event,
    Emitter<ChatState> emit,
  ) {
    final updatedMessages = List<Message>.from(state.messages)
      ..add(event.message);
    emit(ChatConnected(messages: updatedMessages));
  }

  @override
  Future<void> close() {
    _messagesSubscription?.cancel();
    disconnectFromChat();
    return super.close();
  }
}
