import 'package:akunku/model/Otp/otp_field_data.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_form_state.dart';

class OtpFormCubit extends Cubit<OtpFormState<OtpFieldData>> {
  OtpFormCubit() : super(OtpFormInitial(OtpFieldData()));
  void initialize(OtpFieldData otpFieldData) {
    emit(OtpFormSucces(otpFieldData));
  }

  void onChangeOtp(OtpFieldData latestFormData, String otp) {
    latestFormData = latestFormData.copyWith(otp: otp);
    emit(OtpFormSucces(latestFormData));
  }
}
