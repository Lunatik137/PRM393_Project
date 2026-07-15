import '../entities/feed_post.dart';
import '../../../../core/network/pagination.dart';

abstract class FeedRepository {
  Future<Pagination<FeedPost>> getFeed(int page, int pageSize);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
}
