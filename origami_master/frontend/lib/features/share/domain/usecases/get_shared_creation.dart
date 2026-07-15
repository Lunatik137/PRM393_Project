import 'package:injectable/injectable.dart';
import '../entities/shared_creation.dart';
import '../repositories/share_repository.dart';

@injectable
class GetSharedCreationUseCase {
  final ShareRepository _repository;

  GetSharedCreationUseCase(this._repository);

  Future<SharedCreation> call(String token) {
    return _repository.getSharedCreation(token);
  }
}
