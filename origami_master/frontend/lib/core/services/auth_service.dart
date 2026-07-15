import 'dart:async';

class AuthService {
  // Singleton pattern for simplicity in this phase
  AuthService._();
  static final AuthService instance = AuthService._();

  bool _isLoggedIn = false;
  Duration _delay = const Duration(seconds: 2);

  bool get isLoggedIn => _isLoggedIn;

  Future<bool> checkSession() async {
    // Simulate network or local storage delay
    await Future.delayed(_delay);
    return _isLoggedIn;
  }

  Future<bool> login(String email, String password) async {
    await Future.delayed(_delay);
    if (email == 'demo@origami.com' && password == 'password123') {
      _isLoggedIn = true;
      return true;
    }
    return false;
  }

  Future<bool> loginWithGoogle() async {
    await Future.delayed(_delay);
    _isLoggedIn = true;
    return true;
  }

  Future<void> logout() async {
    await Future.delayed(
      _delay == Duration.zero
          ? Duration.zero
          : const Duration(milliseconds: 500),
    );
    _isLoggedIn = false;
  }

  // Helper for testing
  void setLoggedIn(bool value) {
    _isLoggedIn = value;
  }

  void setDelay(Duration delay) {
    _delay = delay;
  }
}
