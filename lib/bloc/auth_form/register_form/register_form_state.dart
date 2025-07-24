part of 'register_form_cubit.dart';

sealed class RegisterFormState<T> extends Equatable {
  final T? data;
  const RegisterFormState({this.data});

  @override
  List<Object?> get props => [data];
}

final class RegisterFormInitial<T> extends RegisterFormState<T> {
  const RegisterFormInitial(T? data) : super(data: data);
  @override
  List<Object?> get props => [data];
}

final class RegisterFormError extends RegisterFormState {}

final class RegisterFormSucces<T> extends RegisterFormState<T> {
  const RegisterFormSucces(T? data) : super(data: data);

  @override
  List<Object?> get props => [data];
}
