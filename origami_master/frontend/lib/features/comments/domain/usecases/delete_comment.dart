import 'package:injectable/injectable.dart';
import '../repositories/comment_repository.dart';

@injectable
class DeleteCommentUseCase {
  final CommentRepository _repository;

  DeleteCommentUseCase(this._repository);

  Future<void> call(String commentId) {
    return _repository.deleteComment(commentId);
  }
}
