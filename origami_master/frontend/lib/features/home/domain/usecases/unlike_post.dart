import 'package:injectable/injectable.dart';
import '../repositories/feed_repository.dart';

@injectable
class UnlikePostUseCase {
  final FeedRepository _repository;

  UnlikePostUseCase(this._repository);

  Future<void> call(String postId) {
    return _repository.unlikePost(postId);
  }
}
