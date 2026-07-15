import '../entities/comment.dart';
import '../../../../core/network/pagination.dart';

abstract class CommentRepository {
  Future<Pagination<Comment>> getComments(String postId, int page, int pageSize);
  Future<void> addComment(String postId, String content);
  Future<void> deleteComment(String commentId);
}
