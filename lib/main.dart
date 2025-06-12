import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:chat_app/di.dart' as di;
import 'package:chat_app/feautures/chat/presentation/bloc/chat_bloc.dart';
import 'package:chat_app/feautures/chat/presentation/pages/chat_page.dart';

void main() {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<ChatBloc>(),
      child: MaterialApp(
        title: 'WhatsApp Chat',
        theme: ThemeData(primarySwatch: Colors.teal),
        home: ChatPage(),
      ),
    );
  }
}
