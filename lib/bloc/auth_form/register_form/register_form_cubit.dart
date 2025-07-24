import 'package:akunku/model/auth/register_form.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'register_form_state.dart';

class RegisterFormCubit extends Cubit<RegisterFormState<RegisterData>> {
  RegisterFormCubit() : super(RegisterFormInitial(RegisterData()));

  void initialize(RegisterData registerFormData) {
    emit(RegisterFormSucces(registerFormData));
  }

  void onChangeUsername(RegisterData latestFormData, String username) {
    latestFormData = latestFormData.copyWith(username: username);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeEmail(RegisterData latestFormData, String email) {
    latestFormData = latestFormData.copyWith(email: email);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangePassword(RegisterData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(password: password);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangePasswordCheck(RegisterData latestFormData, String password) {
    latestFormData = latestFormData.copyWith(checkPassword: password);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeNumberPhone(RegisterData latestFormData, String phone) {
    latestFormData = latestFormData.copyWith(numberPhone: phone);
    emit(RegisterFormSucces(latestFormData));
  }

  void onChangeNumberPhonePrefix(RegisterData latestFormData, String phone) {
    latestFormData = latestFormData.copyWith(prefixNumber: phone);
    emit(RegisterFormSucces(latestFormData));
  }
}
