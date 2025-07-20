part of 'auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

class AuthError extends AuthState {
  final String message;
  final DateTime timestamp;

  AuthError(this.message) : timestamp = DateTime.now();

  @override
  List<Object> get props => [message, timestamp];
}

final class AuthLoading extends AuthState {}

final class AuthSucces extends AuthState {
  final dynamic data;
  const AuthSucces(this.data);
}
