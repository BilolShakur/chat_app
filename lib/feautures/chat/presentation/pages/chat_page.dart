import 'package:chat_app/core/models/message.dart';
import 'package:chat_app/core/models/user.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_event.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  late User currentUser;
  late User otherUser;

  @override
  void initState() {
    super.initState();

    currentUser = User(
      id: '1',
      name: 'You',
      imageUrl: 'assets/images/user1.jpg',
    );
    otherUser = User(
      id: '2',
      name: 'Nt n15',
      imageUrl: 'assets/images/user2.jpg',
    );

    context.read<ChatBloc>().add(
      ConnectEvent('ws://localhost:8080/ws'),
    ); // Replace with your WebSocket URL

    Future.delayed(Duration(milliseconds: 500), () {
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: otherUser.id,
            text: 'I will write from Japan',
            timestamp: DateTime.now().subtract(Duration(minutes: 10)),
            isSentByMe: false,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: 'Good bye!',
            timestamp: DateTime.now().subtract(Duration(minutes: 9)),
            isSentByMe: true,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: otherUser.id,
            text: 'Japan looks amazing!',
            timestamp: DateTime.now().subtract(Duration(minutes: 8)),
            isSentByMe: false,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: '',
            timestamp: DateTime.now().subtract(Duration(minutes: 7)),
            isSentByMe: true,
            type: MessageType.image,
            fileName: 'IMG_0475',
            fileSize: '2.4 MB',
            mediaUrl: 'test.png',
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: '',
            timestamp: DateTime.now().subtract(Duration(minutes: 6)),
            isSentByMe: true,
            type: MessageType.image,
            fileName: 'IMG_0481',
            fileSize: '2.8 MB',
            mediaUrl: 'test.png',
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: otherUser.id,
            text: 'Hey where are you now ?',
            timestamp: DateTime.now().subtract(Duration(minutes: 5)),
            isSentByMe: false,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: 'Good morning, In Chennai 😎',
            timestamp: DateTime.now().subtract(Duration(minutes: 4)),
            isSentByMe: true,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: otherUser.id,
            text: 'had breakfast? whats the special there',
            timestamp: DateTime.now().subtract(Duration(minutes: 3)),
            isSentByMe: false,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: otherUser.id,
            text: 'Rathna cafe ?',
            timestamp: DateTime.now().subtract(Duration(minutes: 2)),
            isSentByMe: false,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: 'Yeah as always 😂',
            timestamp: DateTime.now().subtract(Duration(minutes: 1)),
            isSentByMe: true,
            type: MessageType.text,
          ),
        ),
      );
      context.read<ChatBloc>().add(
        ReceiveMessageEvent(
          Message(
            senderId: currentUser.id,
            text: '3:45',
            timestamp: DateTime.now(),
            isSentByMe: true,
            type: MessageType.call,
          ),
        ),
      );
    });

    _messageController.addListener(() {
      setState(() {}); // Rebuild to show send icon when text is typed
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    context.read<ChatBloc>().add(DisconnectEvent());
    super.dispose();
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final message = Message(
        senderId: currentUser.id,
        text: _messageController.text.trim(),
        timestamp: DateTime.now(),
        isSentByMe: true,
        type: MessageType.text,
      );
      context.read<ChatBloc>().add(SendMessageEvent(message));
      _messageController.clear();
    }
  }

  Widget _buildMessageBubble(Message message) {
    final isSentByMe = message.isSentByMe;
    final color = isSentByMe ? const Color(0xFFDCF8C6) : Colors.white;
    final alignment = isSentByMe ? Alignment.centerRight : Alignment.centerLeft;
    final borderRadius = BorderRadius.only(
      topLeft: const Radius.circular(10.0),
      topRight: const Radius.circular(10.0),
      bottomLeft: isSentByMe
          ? const Radius.circular(10.0)
          : const Radius.circular(2.0),
      bottomRight: isSentByMe
          ? const Radius.circular(2.0)
          : const Radius.circular(10.0),
    );

    Widget messageContent;

    switch (message.type) {
      case MessageType.text:
        messageContent = Text(
          message.text,
          style: const TextStyle(fontSize: 16.0),
        );
        break;
      case MessageType.image:
        messageContent = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.insert_drive_file,
                  size: 20.0,
                  color: Colors.black54,
                ),
                const SizedBox(width: 8.0),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.fileName ?? 'IMG_XXXX',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                      ),
                    ),
                    Text(
                      '${message.fileSize ?? '0 MB'} • ${message.mediaUrl?.split('.').last.toUpperCase() ?? 'PNG'}',
                      style: const TextStyle(
                        fontSize: 12.0,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        );
        break;
      case MessageType.call:
        messageContent = Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(6.0),
              decoration: BoxDecoration(
                color: isSentByMe
                    ? Colors.green[700]
                    : Colors.red[700], // Green for outgoing, red for incoming
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Icon(
                isSentByMe ? Icons.call_made : Icons.call_received,
                size: 18.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Phone call',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
                Text(
                  message.text,
                  style: const TextStyle(fontSize: 12.0, color: Colors.black54),
                ),
              ],
            ),
          ],
        );
        break;
    }

    return Align(
      alignment: alignment,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        padding: const EdgeInsets.fromLTRB(
          12.0,
          8.0,
          12.0,
          8.0,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ), // Limit bubble width
        decoration: BoxDecoration(color: color, borderRadius: borderRadius),
        child: Column(
          crossAxisAlignment: isSentByMe
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start, // Corrected alignment
          children: [
            messageContent,
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  DateFormat('HH:mm').format(message.timestamp),
                  style: const TextStyle(fontSize: 10.0, color: Colors.black54),
                ),
                if (isSentByMe) ...[
                  const SizedBox(width: 4.0),
                  const Icon(
                    Icons.done_all,
                    size: 12.0,
                    color: Color(0xFF34B7F1),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          255,
          255,
          255,
        ), // Darker teal
        title: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Color.fromARGB(255, 0, 0, 0),
              ),
              onPressed: () {},
            ),
            CircleAvatar(backgroundImage: AssetImage(otherUser.imageUrl)),
            const SizedBox(width: 8.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  otherUser.name,
                  style: const TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
                ),
                const Text(
                  '18ta azo',
                  style: TextStyle(
                    color: Color.fromARGB(179, 0, 0, 0),
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.videocam,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.phone, color: Color.fromARGB(255, 0, 0, 0)),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Color.fromARGB(255, 0, 0, 0),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/images/background.jpg',
            ), // Replace with your image
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<ChatBloc, ChatState>(
                builder: (context, state) {
                  if (state is ChatConnected || state is ChatError) {
                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 10.0,
                      ),
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return _buildMessageBubble(message);
                      },
                    );
                  } else if (state is ChatLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ChatDisconnected) {
                    return const Center(child: Text('Disconnected from chat'));
                  }
                  return const Center(child: Text('Welcome to Chat'));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.add, color: Colors.grey),
                      onPressed: () {},
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type a message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor:
                            Colors.grey[200], // Background color of text field
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16.0,
                          vertical: 8.0,
                        ),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.attach_file,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.currency_rupee,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.camera_alt,
                                color: Colors.grey,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),
                      onSubmitted: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  FloatingActionButton(
                    onPressed: _sendMessage,
                    backgroundColor: const Color(0xFF128C7E), // WhatsApp green
                    child: _messageController.text.isEmpty
                        ? const Icon(Icons.mic, color: Colors.white)
                        : const Icon(Icons.send, color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
