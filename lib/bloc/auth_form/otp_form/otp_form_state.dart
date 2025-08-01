part of 'otp_form_cubit.dart';

sealed class OtpFormState<T> extends Equatable {
  final T? data;
  const OtpFormState({this.data});

  @override
  List<Object> get props => [];
}

final class OtpFormInitial<T> extends OtpFormState<T> {
  @override
  final T? data;

  const OtpFormInitial(this.data) : super(data: data);

  @override
  List<Object> get props => [?data];
}

final class OtpFormSucces<T> extends OtpFormState<T> {
  @override
  final T? data;

  const OtpFormSucces(this.data) : super(data: data);

  @override
  List<Object> get props => [?data];
}
