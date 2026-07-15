import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';

@injectable
class UpdateVisibilityUseCase {
  final GalleryRepository _repository;

  UpdateVisibilityUseCase(this._repository);

  Future<void> call(String id, bool isPublic) {
    return _repository.updateVisibility(id, isPublic);
  }
}
