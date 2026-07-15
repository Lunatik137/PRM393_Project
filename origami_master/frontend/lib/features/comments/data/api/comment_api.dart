import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/comment_response_dto.dart';
import '../dto/comment_request_dto.dart';
import '../../../../core/network/pagination.dart';

part 'comment_api.g.dart';

@RestApi()
abstract class CommentApi {
  factory CommentApi(Dio dio, {String baseUrl}) = _CommentApi;

  @GET('/posts/{postId}/comments')
  Future<Pagination<CommentResponseDto>> getComments(
    @Path('postId') String postId, {
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @POST('/posts/{postId}/comments')
  Future<dynamic> addComment(
    @Path('postId') String postId,
    @Body() CommentRequestDto request,
  );

  @DELETE('/comments/{commentId}')
  Future<void> deleteComment(
    @Path('commentId') String commentId,
  );
}

