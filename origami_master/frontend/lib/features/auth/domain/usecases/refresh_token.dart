import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_session.dart';

@injectable
class RefreshTokenUseCase {
  final AuthRepository _repository;

  RefreshTokenUseCase(this._repository);

  Future<AuthSession> call() {
    return _repository.refresh();
  }
}
