import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/gallery_request_dto.dart';
import '../dto/gallery_response_dto.dart';
import '../../../../core/network/pagination.dart';

part 'gallery_api.g.dart';

@RestApi()
abstract class GalleryApi {
  factory GalleryApi(Dio dio, {String baseUrl}) = _GalleryApi;

  @GET('/gallery/public')
  Future<Pagination<GalleryResponseDto>> getPublicGallery({
    @Query('origamiModelId') String? origamiModelId,
    @Query('pageNumber') required int pageNumber,
    @Query('pageSize') required int pageSize,
  });

  @GET('/gallery')
  Future<Pagination<GalleryResponseDto>> getGallery({
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @GET('/gallery/posts')
  Future<Pagination<GalleryResponseDto>> getMyPostsGallery({
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @GET('/gallery/{id}')
  Future<GalleryResponseDto> getGalleryDetail(
    @Path('id') String id,
  );

  @POST('/gallery')
  Future<GalleryResponseDto> createGallery(
    @Body() CreateGalleryRequestDto request,
  );

  @PUT('/gallery/{id}')
  Future<void> updateGallery(
    @Path('id') String id,
    @Body() UpdateGalleryRequestDto request,
  );

  @DELETE('/gallery/{id}')
  Future<void> deleteGallery(
    @Path('id') String id,
  );

  @PATCH('/gallery/{id}/visibility')
  Future<void> updateVisibility(
    @Path('id') String id,
    @Body() UpdateVisibilityRequestDto request,
  );
}

