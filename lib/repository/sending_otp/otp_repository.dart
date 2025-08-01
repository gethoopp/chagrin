import 'package:akunku/constant/constant.dart';
import 'package:akunku/repository/sending_otp/otp.dart';
import 'package:dio/dio.dart';

class OtpRepository implements BaseSendsOtp {
  final dio = Dio(
    BaseOptions(
      baseUrl: Url.baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      validateStatus: (status) => true,
    ),
  );
  @override
  Future sendOtp(String email, String otp) async {
    try {
      final result = await dio.post(
        Url.sendOtpEmail,
        data: {"email": email, "otp": otp},
      );

      if (result.statusCode == 200) {
        return result.data['message'];
      } else {
        throw Exception(result.data["message"] ?? "Login gagal");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Terjadi kesalahan koneksi",
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future resendsOtp(String email, String otp) async {
    try {
      // final result =
    } catch (e) {}
  }
}
