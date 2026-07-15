import '../entities/profile.dart';
import '../../../home/domain/entities/feed_post.dart';
import '../../../../core/network/pagination.dart';

abstract class ProfileRepository {
  Future<Profile> getMyProfile();
  Future<Profile> getUserProfile(String userId);
  Future<Pagination<FeedPost>> getUserPosts(String userId, int page, int pageSize);
}
