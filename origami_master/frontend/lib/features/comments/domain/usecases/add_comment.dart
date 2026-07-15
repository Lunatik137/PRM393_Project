import 'package:injectable/injectable.dart';
import '../repositories/comment_repository.dart';

@injectable
class AddCommentUseCase {
  final CommentRepository _repository;

  AddCommentUseCase(this._repository);

  Future<void> call(String postId, String content) {
    return _repository.addComment(postId, content);
  }
}
