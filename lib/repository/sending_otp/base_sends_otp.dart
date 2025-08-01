abstract class BaseSendsOtp {
  Future<dynamic> sendOtp(String email, String otp);
  Future<dynamic> resendsOtp(String email, String otp);
}
