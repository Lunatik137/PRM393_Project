import 'package:injectable/injectable.dart';
import '../repositories/comment_repository.dart';
import '../entities/comment.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetCommentsUseCase {
  final CommentRepository _repository;

  GetCommentsUseCase(this._repository);

  Future<Pagination<Comment>> call(String postId, int page, int pageSize) {
    return _repository.getComments(postId, page, pageSize);
  }
}
