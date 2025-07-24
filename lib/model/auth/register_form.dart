import 'package:akunku/model/common.dart';

class RegisterData extends BaseModel {
  final String? username;
  final String? email;
  final String? password;
  final String? checkPassword;
  final String? prefixNumber;
  final String? numberPhone;

  RegisterData({
    this.username,
    this.email,
    this.password,
    this.checkPassword,
    this.prefixNumber,
    this.numberPhone,
  });

  @override
  copyWith({
    String? username,
    String? email,
    String? password,
    String? checkPassword,
    String? prefixNumber,
    String? numberPhone,
  }) {
    return RegisterData(
      username: username ?? this.username,
      email: email ?? this.email,
      password: password ?? this.password,
      checkPassword: checkPassword ?? this.checkPassword,
      prefixNumber: prefixNumber ?? this.prefixNumber,
      numberPhone: numberPhone ?? this.numberPhone,
    );
  }

  @override
  List<Object?> get props => [
    username,
    email,
    password,
    checkPassword,
    numberPhone,
    prefixNumber,
  ];
}
