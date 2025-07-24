import 'package:akunku/model/profile/profile_user.dart';

abstract class AuthRepository {
  Future<ProfieUser> loginUser(String email, String password, String device);
  Future<dynamic> registerUser(
    String usename,
    String email,
    String password,
    String passwordConfirm,
    String prefixNumber,
    String number,
  );
}
