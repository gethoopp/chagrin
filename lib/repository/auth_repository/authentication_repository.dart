import 'package:akunku/constant/constant.dart';
import 'package:akunku/model/common.dart';
import 'package:akunku/repository/auth_repository/auth.dart';
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
  Future<ProfieUser> loginUser(
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
        return ProfieUser.fromJson(response.data);
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
  Future<dynamic> registerUser(
    String usename,
    String email,
    String password,
    String passwordConfirm,
    String prefixNumber,
    String number,
  ) async {
    try {
      final response = await dio.post(
        Url.urlRegister,
        data: {
          "name": usename,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirm,
          "prefix_whatsapp_number": prefixNumber,
          "phone_num": number,
        },
      );

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception(response.data);
      }
    } on DioException catch (e) {
      throw Exception(
        e.response?.data["message"] ?? "Terjadi kesalahan koneksi",
      );
    } catch (e) {
      rethrow;
    }
  }
}
