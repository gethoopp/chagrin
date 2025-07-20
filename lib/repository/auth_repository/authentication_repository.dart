import 'package:akunku/constant/url.dart';
import 'package:akunku/repository/auth_repository/base_auth.dart';
import 'package:dio/dio.dart';

class AuthenticationBase implements AuthRepository {
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
  Future<dynamic> loginUser(
    String email,
    String password,
    String device,
  ) async {
    try {
      final response = await dio.post(
        Url.urlLogin,
        data: {'email': email, 'password': password, 'device_name': device},
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data["message"] ?? "Login gagal");
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Terjadi kesalahan koneksi",
      );
    } catch (e) {
      rethrow; // biarkan error diteruskan tanpa dibungkus ulang
    }
  }

  @override
  Future<dynamic> registerUser() async {}
}
