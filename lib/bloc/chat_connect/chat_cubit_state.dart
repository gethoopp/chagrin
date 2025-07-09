part of 'chat_cubit_cubit.dart';

@immutable
sealed class ChatCubitState {}

final class ChatCubitLoading extends ChatCubitState {}

final class ChatCubitSubscribed extends ChatCubitState {
  final String message;

  ChatCubitSubscribed(this.message);
}

final class ChatCubitConnectMesssage extends ChatCubitState {
  final String message;

  ChatCubitConnectMesssage(this.message);
}

final class ChatCubitRecievedMessage extends ChatCubitState {
  final String message;

  ChatCubitRecievedMessage(this.message);
}

final class ChatCubitError extends ChatCubitState {
  final String message;

  ChatCubitError(this.message);
}
