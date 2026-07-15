import 'package:injectable/injectable.dart';
import '../repositories/feed_repository.dart';
import '../entities/feed_post.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetFeedUseCase {
  final FeedRepository _repository;

  GetFeedUseCase(this._repository);

  Future<Pagination<FeedPost>> call(int page, int pageSize) {
    return _repository.getFeed(page, pageSize);
  }
}
