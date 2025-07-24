import 'package:akunku/repository/auth_repository/base_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthRepository authRepository;
  RegisterCubit(this.authRepository) : super(RegisterInitial());

  void RegisterUser(
    String usename,
    String email,
    String password,
    String passwordConfirm,
    String prefixNumber,
    String number,
  ) async {
    try {
      final result = await authRepository.registerUser(
        usename,
        email,
        password,
        passwordConfirm,
        prefixNumber,
        number,
      );

      emit(RegisterSucces(result));
    } catch (e) {
      emit(RegisterErr(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
