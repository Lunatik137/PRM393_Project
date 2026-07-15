import 'package:injectable/injectable.dart';
import '../repositories/share_repository.dart';

@injectable
class ToggleShareLinkUseCase {
  final ShareRepository _repository;

  ToggleShareLinkUseCase(this._repository);

  Future<void> call(String shareId) {
    return _repository.toggleShareLink(shareId);
  }
}
