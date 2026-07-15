import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/paged_feed_response_dto.dart';

part 'feed_api.g.dart';

@RestApi()
abstract class FeedApi {
  factory FeedApi(Dio dio, {String baseUrl}) = _FeedApi;

  @GET('/feed')
  Future<PagedFeedResponseDto> getFeed({
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @POST('/feed/publish')
  Future<void> publishPost(@Body() Map<String, dynamic> body);

  @GET('/feed/{id}')
  Future<dynamic> getPost(@Path('id') String postId);

  @POST('/feed/{id}/like')
  Future<void> likePost(@Path('id') String postId);

  @DELETE('/feed/{id}/like')
  Future<void> unlikePost(@Path('id') String postId);

  @PUT('/feed/{id}')
  Future<void> updatePost(@Path('id') String postId, @Body() Map<String, dynamic> body);

  @DELETE('/feed/{id}')
  Future<void> deletePost(@Path('id') String postId);
}

