import 'package:injectable/injectable.dart';
import '../repositories/feed_repository.dart';

@injectable
class LikePostUseCase {
  final FeedRepository _repository;

  LikePostUseCase(this._repository);

  Future<void> call(String postId) {
    return _repository.likePost(postId);
  }
}
