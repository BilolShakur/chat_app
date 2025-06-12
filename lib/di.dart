import 'package:chat_app/feautures/chat/data/datasources/chat_remote_data_source.dart';
import 'package:chat_app/feautures/chat/data/datasources/chat_remote_data_source_impl.dart';
import 'package:chat_app/feautures/chat/data/repositories/chat_repository_impl.dart';
import 'package:chat_app/feautures/chat/domain/repositories/chat_repository.dart';
import 'package:chat_app/feautures/chat/domain/usecases/connect_to_chat.dart';
import 'package:chat_app/feautures/chat/domain/usecases/disconnect_from_chat.dart';
import 'package:chat_app/feautures/chat/domain/usecases/get_messages.dart';
import 'package:chat_app/feautures/chat/domain/usecases/send_message.dart';
import 'package:chat_app/feautures/chat/presentation/bloc/chat_bloc.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

void init() {
  // Bloc
  sl.registerFactory(
    () => ChatBloc(
      connectToChat: sl(),
      disconnectFromChat: sl(),
      getMessages: sl(),
      sendMessage: sl(),
    ),
  );

  // Use cases
  sl.registerLazySingleton(() => ConnectToChat(sl()));
  sl.registerLazySingleton(() => DisconnectFromChat(sl()));
  sl.registerLazySingleton(() => GetMessages(sl()));
  sl.registerLazySingleton(() => SendMessage(sl()));

  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<ChatRemoteDataSource>(
    () => ChatRemoteDataSourceImpl(),
  );
}
