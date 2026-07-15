import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/share_link_response_dto.dart';
import '../dto/shared_creation_response_dto.dart';
import '../dto/generate_share_link_response_dto.dart';

part 'share_api.g.dart';

@RestApi()
abstract class ShareApi {
  factory ShareApi(Dio dio, {String baseUrl}) = _ShareApi;

  @POST('/share-links')
  Future<GenerateShareLinkResponseDto> generateShareLink(
    @Body() Map<String, dynamic> body,
  );

  @GET('/share-links')
  Future<List<ShareLinkResponseDto>> getShareLinks();

  @DELETE('/share-links/{shareId}')
  Future<void> deleteShareLink(
    @Path('shareId') String shareId,
  );

  @PATCH('/share-links/{shareId}/toggle')
  Future<void> toggleShareLink(
    @Path('shareId') String shareId,
  );

  @GET('/shared/{token}')
  Future<SharedCreationResponseDto> getSharedCreation(
    @Path('token') String token,
  );
}

