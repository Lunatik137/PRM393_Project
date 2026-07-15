import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';

@injectable
class DeleteGalleryUseCase {
  final GalleryRepository _repository;

  DeleteGalleryUseCase(this._repository);

  Future<void> call(String id) {
    return _repository.deleteGallery(id);
  }
}
