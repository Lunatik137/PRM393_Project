import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';
import '../entities/gallery_item.dart';
import '../../data/dto/gallery_request_dto.dart';

@injectable
class CreateGalleryUseCase {
  final GalleryRepository _repository;

  CreateGalleryUseCase(this._repository);

  Future<GalleryItem> call(CreateGalleryRequestDto request) {
    return _repository.createGallery(request);
  }
}
