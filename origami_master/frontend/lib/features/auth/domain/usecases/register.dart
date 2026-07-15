import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';

@injectable
class RegisterUseCase {
  final AuthRepository _repository;

  RegisterUseCase(this._repository);

  Future<void> call({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) {
    return _repository.register(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    );
  }
}
