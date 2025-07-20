import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../repository/connect_repository/base_connect.dart';

part 'chat_cubit_state.dart';

class ChatCubitCubit extends Cubit<ChatCubitState> {
  final ConnectRepository connectRepository;
  ChatCubitCubit(this.connectRepository) : super(ChatCubitLoading());

  //cubit for connect to repository websocket
  Future<void> chatConnect() async {
    try {
      final controller = StreamController<String>();

      await connectRepository.connectSoketi(
        onMessage: (message) {
          controller.add(message);
        },
        onSubscribed: (message) {
          controller.add(message);
        },

        onConnect: (message) {
          controller.add(message);
        },
      );

      await for (final message in controller.stream) {
        emit(ChatCubitRecievedMessage(message));
      }
    } catch (e) {
      emit(ChatCubitError(e.toString()));
    }
  }
}
