import 'package:akunku/model/basemodel.dart';

class OtpFieldData extends BaseModel {
  final String? otp;

  OtpFieldData({this.otp});

  @override
  copyWith({String? otp}) {
    return OtpFieldData(otp: otp ?? this.otp);
  }

  @override
  List<Object?> get props => [otp];
}
