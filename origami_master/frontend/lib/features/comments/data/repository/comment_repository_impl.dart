import 'package:injectable/injectable.dart';
import '../../domain/repositories/comment_repository.dart';
import '../../domain/entities/comment.dart';
import '../datasource/comment_remote_datasource.dart';
import '../mapper/comment_mapper.dart';
import '../../../../core/network/pagination.dart';

@LazySingleton(as: CommentRepository)
class CommentRepositoryImpl implements CommentRepository {
  final CommentRemoteDataSource _remoteDataSource;

  CommentRepositoryImpl(this._remoteDataSource);

  @override
  Future<Pagination<Comment>> getComments(String postId, int page, int pageSize) async {
    final dto = await _remoteDataSource.getComments(postId, page, pageSize);
    return CommentMapper.mapToPagination(dto);
  }

  @override
  Future<void> addComment(String postId, String content) async {
    try {
      await _remoteDataSource.addComment(postId, content);
    } catch (e) {
      throw Exception('Failed to add comment: $e');
    }
  }

  @override
  Future<void> deleteComment(String commentId) async {
    await _remoteDataSource.deleteComment(commentId);
  }
}
