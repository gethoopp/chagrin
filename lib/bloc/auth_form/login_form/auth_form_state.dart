part of 'auth_form_cubit.dart';

sealed class AuthFormState<T> extends Equatable {
  final T? data;

  const AuthFormState({this.data});

  @override
  List<Object?> get props => [data];
}

final class AuthFormInitial<T> extends AuthFormState<T> {
  @override
  final T data;

  const AuthFormInitial(this.data) : super(data: data);

  @override
  List<Object?> get props => [data];
}

final class AuthErrorState<T> extends AuthFormState<T> {
  final String message;

  const AuthErrorState({required this.message, super.data});

  @override
  List<Object?> get props => [message, data];
}

final class AuthFormSuccess<T> extends AuthFormState<T> {
  const AuthFormSuccess(T? data) : super(data: data);

  @override
  List<Object?> get props => [data];
}
