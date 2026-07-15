import 'package:injectable/injectable.dart';
import '../../domain/repositories/gallery_repository.dart';
import '../../domain/entities/gallery_item.dart';
import '../dto/gallery_request_dto.dart';
import '../datasource/gallery_remote_datasource.dart';
import '../mapper/gallery_mapper.dart';
import '../../../../core/network/pagination.dart';

@LazySingleton(as: GalleryRepository)
class GalleryRepositoryImpl implements GalleryRepository {
  final GalleryRemoteDataSource _remoteDataSource;

  GalleryRepositoryImpl(this._remoteDataSource);

  @override
  Future<Pagination<GalleryItem>> getGallery(int page, int pageSize) async {
    final dto = await _remoteDataSource.getGallery(page, pageSize);
    return GalleryMapper.mapToPagination(dto);
  }

  @override
  Future<Pagination<GalleryItem>> getMyPostsGallery(int page, int pageSize) async {
    final dto = await _remoteDataSource.getMyPostsGallery(page, pageSize);
    return GalleryMapper.mapToPagination(dto);
  }

  @override
  Future<GalleryItem> getGalleryDetail(String id) async {
    final dto = await _remoteDataSource.getGalleryDetail(id);
    return GalleryMapper.mapToEntity(dto);
  }

  @override
  Future<GalleryItem> createGallery(CreateGalleryRequestDto request) async {
    final dto = await _remoteDataSource.createGallery(request);
    return GalleryMapper.mapToEntity(dto);
  }

  @override
  Future<void> updateGallery(String id, UpdateGalleryRequestDto request) async {
    await _remoteDataSource.updateGallery(id, request);
  }

  @override
  Future<void> deleteGallery(String id) {
    return _remoteDataSource.deleteGallery(id);
  }

  @override
  Future<void> updateVisibility(String id, bool isPublic) {
    return _remoteDataSource.updateVisibility(id, isPublic);
  }
}
