import 'package:akunku/repository/sending_otp/base_sends_otp.dart';
import 'package:akunku/repository/sending_otp/otp_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_state.dart';

class OtpCubit extends Cubit<OtpState> {
  final BaseSendsOtp baseSendsOtp;
  OtpCubit(this.baseSendsOtp) : super(OtpInitial());

  void sendsOtp(String email, String otp) async {
    try {
      emit(OtpLoading());
      final result = await baseSendsOtp.sendOtp(email, otp);

      emit(OtpSuccses(result));
    } catch (e) {
      emit(OtpError(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
