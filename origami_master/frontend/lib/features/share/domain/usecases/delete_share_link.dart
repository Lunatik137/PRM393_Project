import 'package:injectable/injectable.dart';
import '../repositories/share_repository.dart';

@injectable
class DeleteShareLinkUseCase {
  final ShareRepository _repository;

  DeleteShareLinkUseCase(this._repository);

  Future<void> call(String shareId) {
    return _repository.deleteShareLink(shareId);
  }
}
