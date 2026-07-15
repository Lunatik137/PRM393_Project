import '../entities/gallery_item.dart';
import '../../data/dto/gallery_request_dto.dart';
import '../../../../core/network/pagination.dart';

abstract class GalleryRepository {
  Future<Pagination<GalleryItem>> getGallery(int pageNumber, int pageSize);
  Future<Pagination<GalleryItem>> getMyPostsGallery(int pageNumber, int pageSize);
  Future<GalleryItem> getGalleryDetail(String id);
  Future<GalleryItem> createGallery(CreateGalleryRequestDto request);
  Future<void> updateGallery(String id, UpdateGalleryRequestDto request);
  Future<void> deleteGallery(String id);
  Future<void> updateVisibility(String id, bool isPublic);
}
