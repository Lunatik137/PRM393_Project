import '../../../../models/feed_post.dart';
import '../../../../models/post_comment.dart';
import '../../../../models/user_profile.dart';
import '../../../../models/user_creation.dart';

abstract class SocialRepository {
  Future<List<FeedPost>> getFeedPosts();
  Future<FeedPost?> getPost(String postId);
  Future<List<PostComment>> getComments(String postId);
  Future<void> addComment(String postId, String content);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<UserProfile> getUserProfile(String userId);
  Future<List<UserCreation>> getUserCreations(String userId);
}
