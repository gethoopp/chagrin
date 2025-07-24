part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterLoading extends RegisterState {}

final class RegisterErr extends RegisterState {
  final String message;
  const RegisterErr(this.message);
}

final class RegisterSucces extends RegisterState {
  final dynamic data;
  const RegisterSucces(this.data);
}
