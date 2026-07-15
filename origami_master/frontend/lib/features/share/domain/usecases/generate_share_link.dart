import 'package:injectable/injectable.dart';
import '../entities/share_link.dart';
import '../repositories/share_repository.dart';

@injectable
class GenerateShareLinkUseCase {
  final ShareRepository _repository;

  GenerateShareLinkUseCase(this._repository);

  Future<ShareLink> call(String galleryId) {
    return _repository.generateShareLink(galleryId);
  }
}
