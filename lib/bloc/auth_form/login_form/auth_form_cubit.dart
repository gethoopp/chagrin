import 'package:akunku/model/common.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_form_state.dart';

class AuthFormCubit extends Cubit<AuthFormState<LoginFormData>> {
  AuthFormCubit() : super(AuthFormInitial(LoginFormData()));

  void initialize(LoginFormData loginFormData) {
    emit(AuthFormSuccess(loginFormData));
  }

  void onChangeUsername(LoginFormData latestFormData, String username) {
    latestFormData = latestFormData.copyWith(username: username);
    emit(AuthFormSuccess(latestFormData));
  }

  void onChangePassword(LoginFormData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(password: password);
    emit(AuthFormSuccess(latestFormData));
  }

  void onTapShowPassword(LoginFormData latestFormData, bool isShow) {
    latestFormData = latestFormData.copyWith(securePassword: !isShow);
    emit(AuthFormSuccess(latestFormData));
  }
}
