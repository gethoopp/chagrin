part of 'otp_cubit.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

final class OtpLoading extends OtpState {}

final class OtpSuccses extends OtpState {
  final dynamic data;

  const OtpSuccses(this.data);
}

final class OtpError extends OtpState {
  final String msg;

  const OtpError(this.msg);
}
