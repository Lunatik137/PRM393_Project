import '../../domain/repositories/social_repository.dart';
import '../../../../models/feed_post.dart';
import '../../../../models/post_comment.dart';
import '../../../../models/user_profile.dart';
import '../../../../models/user_creation.dart';

class SocialRepositoryImpl implements SocialRepository {
  @override
  Future<List<FeedPost>> getFeedPosts() async {
    return [];
  }

  @override
  Future<FeedPost?> getPost(String postId) async {
    return FeedPost(
      id: postId,
      creatorId: 'user_002',
      imageUrl: 'https://via.placeholder.com/150',
      description: 'Check out my new crane!',
      likesCount: 12,
      commentsCount: 2,
      createdAt: DateTime.now().subtract(const Duration(hours: 2)),
      isLiked: false,
    );
  }

  @override
  Future<List<PostComment>> getComments(String postId) async {
    return [];
  }

  @override
  Future<void> addComment(String postId, String content) async {}

  @override
  Future<void> likePost(String postId) async {}

  @override
  Future<void> unlikePost(String postId) async {}

  @override
  Future<void> followUser(String userId) async {}

  @override
  Future<void> unfollowUser(String userId) async {}

  @override
  Future<UserProfile> getUserProfile(String userId) async {
    return UserProfile(
      id: userId,
      name: 'User',
      email: 'user@origami.app',
      avatarPath: 'assets/images/avatars/default_avatar.png',
      completedFoldsCount: 0,
      publicCreationsCount: 0,
      followersCount: 0,
      followingCount: 0,
    );
  }

  @override
  Future<List<UserCreation>> getUserCreations(String userId) async {
    return [];
  }
}
