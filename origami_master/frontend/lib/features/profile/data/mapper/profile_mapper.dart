import '../dto/profile_response_dto.dart';
import '../dto/user_post_response_dto.dart';
import '../../domain/entities/profile.dart';
import '../../../home/domain/entities/feed_post.dart';
import '../../../../core/network/pagination.dart';
import '../../../../core/utils/image_url_resolver.dart';

class ProfileMapper {
  static Profile mapToEntity(ProfileResponseDto dto) {
    return Profile(
      id: dto.id,
      username: dto.username,
      displayName: dto.displayName,
      avatarUrl: resolveImageUrl(dto.avatarUrl),
      bio: dto.bio,
      followersCount: dto.statistics.followers,
      followingCount: dto.statistics.following,
      completedFolds: dto.statistics.completedFolds,
      publicCreations: dto.statistics.publicPosts,
      isFollowing: dto.isFollowing ?? false,
    );
  }

  static FeedPost mapPostToEntity(UserPostResponseDto dto, String profileId) {
    return FeedPost(
      id: dto.id,
      creatorId: profileId,
      creatorName: '',
      creatorAvatar: '',
      imageUrl: resolveImageUrl(dto.imagePath),
      description: dto.caption ?? '',
      publishedAt: DateTime.now(), // Default
      likeCount: dto.likeCount,
      commentCount: dto.commentCount,
      isLiked: false,
    );
  }

  static Pagination<FeedPost> mapToPostPagination(Pagination<UserPostResponseDto> dto, String profileId) {
    return Pagination<FeedPost>(
      items: dto.items.map((e) => mapPostToEntity(e, profileId)).toList(),
      pageNumber: dto.pageNumber,
      pageSize: dto.pageSize,
      hasMore: dto.hasMore,
    );
  }
}

