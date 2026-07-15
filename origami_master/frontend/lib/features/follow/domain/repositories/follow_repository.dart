import '../entities/follow_user.dart';
import '../../../../core/network/pagination.dart';

abstract class FollowRepository {
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<Pagination<FollowUser>> getFollowers(String userId, int page, int pageSize);
  Future<Pagination<FollowUser>> getFollowing(String userId, int page, int pageSize);
}
