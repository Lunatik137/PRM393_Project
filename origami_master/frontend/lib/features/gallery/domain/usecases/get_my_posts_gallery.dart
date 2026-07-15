import 'package:injectable/injectable.dart';
import '../repositories/gallery_repository.dart';
import '../entities/gallery_item.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetMyPostsGalleryUseCase {
  final GalleryRepository _repository;

  GetMyPostsGalleryUseCase(this._repository);

  Future<Pagination<GalleryItem>> call(int pageNumber, int pageSize) {
    return _repository.getMyPostsGallery(pageNumber, pageSize);
  }
}
