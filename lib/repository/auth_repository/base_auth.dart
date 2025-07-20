abstract class AuthRepository {
  Future<dynamic> loginUser(String email, String password, String device);
  Future<dynamic> registerUser();
}
