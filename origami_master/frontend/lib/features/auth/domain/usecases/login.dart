import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_session.dart';

@injectable
class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<AuthSession> call(String email, String password) {
    return _repository.login(email: email, password: password);
  }
}
