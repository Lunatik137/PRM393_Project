import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';
import '../../data/dto/gallery_request_dto.dart';

@injectable
class UpdateGalleryUseCase {
  final GalleryRepository _repository;

  UpdateGalleryUseCase(this._repository);

  Future<void> call(String id, UpdateGalleryRequestDto request) {
    return _repository.updateGallery(id, request);
  }
}
