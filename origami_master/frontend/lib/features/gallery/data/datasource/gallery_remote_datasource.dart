import 'package:injectable/injectable.dart';
import '../api/gallery_api.dart';
import '../dto/gallery_request_dto.dart';
import '../dto/gallery_response_dto.dart';
import '../../../../core/network/pagination.dart';

abstract class GalleryRemoteDataSource {
  Future<Pagination<GalleryResponseDto>> getGallery(int page, int pageSize);
  Future<Pagination<GalleryResponseDto>> getMyPostsGallery(int page, int pageSize);
  Future<GalleryResponseDto> getGalleryDetail(String id);
  Future<GalleryResponseDto> createGallery(CreateGalleryRequestDto request);
  Future<void> updateGallery(String id, UpdateGalleryRequestDto request);
  Future<void> deleteGallery(String id);
  Future<void> updateVisibility(String id, bool isPublic);
}

@LazySingleton(as: GalleryRemoteDataSource)
class GalleryRemoteDataSourceImpl implements GalleryRemoteDataSource {
  final GalleryApi _api;

  GalleryRemoteDataSourceImpl(this._api);

  @override
  Future<Pagination<GalleryResponseDto>> getGallery(int page, int pageSize) async {
    return await _api.getGallery(page: page, pageSize: pageSize);
  }

  @override
  Future<Pagination<GalleryResponseDto>> getMyPostsGallery(int page, int pageSize) async {
    return await _api.getMyPostsGallery(page: page, pageSize: pageSize);
  }

  @override
  Future<GalleryResponseDto> getGalleryDetail(String id) async {
    return await _api.getGalleryDetail(id);
  }

  @override
  Future<GalleryResponseDto> createGallery(CreateGalleryRequestDto request) async {
    return await _api.createGallery(request);
  }

  @override
  Future<void> updateGallery(String id, UpdateGalleryRequestDto request) async {
    await _api.updateGallery(id, request);
  }

  @override
  Future<void> deleteGallery(String id) async {
    await _api.deleteGallery(id);
  }

  @override
  Future<void> updateVisibility(String id, bool isPublic) async {
    await _api.updateVisibility(id, UpdateVisibilityRequestDto(visibility: isPublic ? 'Public' : 'Private'));
  }
}

