import 'package:injectable/injectable.dart';
import '../repositories/auth_repository.dart';
import '../entities/auth_session.dart';

@injectable
class CheckSessionUseCase {
  final AuthRepository _repository;

  CheckSessionUseCase(this._repository);

  Future<AuthSession?> call() {
    return _repository.getValidSession();
  }
}
