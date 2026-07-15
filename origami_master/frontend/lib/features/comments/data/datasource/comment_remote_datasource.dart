import 'package:injectable/injectable.dart';
import '../api/comment_api.dart';
import '../dto/comment_response_dto.dart';
import '../dto/comment_request_dto.dart';
import '../../../../core/network/pagination.dart';

abstract class CommentRemoteDataSource {
  Future<Pagination<CommentResponseDto>> getComments(String postId, int page, int pageSize);
  Future<dynamic> addComment(String postId, String content);
  Future<void> deleteComment(String commentId);
}

@LazySingleton(as: CommentRemoteDataSource)
class CommentRemoteDataSourceImpl implements CommentRemoteDataSource {
  final CommentApi _api;

  CommentRemoteDataSourceImpl(this._api);

  @override
  Future<Pagination<CommentResponseDto>> getComments(String postId, int page, int pageSize) async {
    return await _api.getComments(postId, page: page, pageSize: pageSize);
  }

  @override
  Future<dynamic> addComment(String postId, String content) async {
    final request = CommentRequestDto(content: content);
    return await _api.addComment(postId, request);
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _api.deleteComment(commentId);
  }
}

