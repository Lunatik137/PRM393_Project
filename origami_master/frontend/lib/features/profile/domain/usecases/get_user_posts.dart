import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import '../../../home/domain/entities/feed_post.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetUserPostsUseCase {
  final ProfileRepository _repository;

  GetUserPostsUseCase(this._repository);

  Future<Pagination<FeedPost>> call(String userId, int page, int pageSize) {
    return _repository.getUserPosts(userId, page, pageSize);
  }
}
