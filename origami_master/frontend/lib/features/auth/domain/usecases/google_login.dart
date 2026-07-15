import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_session.dart';

@injectable
class GoogleLoginUseCase {
  final AuthRepository _repository;

  GoogleLoginUseCase(this._repository);

  Future<AuthSession> call(String idToken) {
    return _repository.googleLogin(idToken: idToken);
  }
}
