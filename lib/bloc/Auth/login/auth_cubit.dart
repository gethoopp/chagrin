import 'package:akunku/model/common.dart';
import 'package:akunku/repository/auth_repository/base_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  void loginUser(String email, String password, String device) async {
    try {
      emit(AuthLoading());
      final result = await authRepository.loginUser(email, password, device);
      emit(AuthSucces(result));
    } catch (e) {
      emit(AuthError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
