import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<AuthSession> login({required String email, required String password});
  Future<AuthSession> googleLogin({required String idToken});
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  });
  Future<void> logout();
  Future<AuthSession> refresh();
  Future<bool> isLoggedIn();
  Future<AuthSession?> getValidSession();
}
