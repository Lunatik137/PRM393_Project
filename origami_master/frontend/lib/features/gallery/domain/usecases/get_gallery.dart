import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';
import '../entities/gallery_item.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetGalleryUseCase {
  final GalleryRepository _repository;

  GetGalleryUseCase(this._repository);

  Future<Pagination<GalleryItem>> call(int page, int pageSize) {
    return _repository.getGallery(page, pageSize);
  }

  Future<GalleryItem> detail(String id) {
    return _repository.getGalleryDetail(id);
  }
}
