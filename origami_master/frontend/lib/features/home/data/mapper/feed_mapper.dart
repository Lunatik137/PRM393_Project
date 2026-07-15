import '../dto/feed_response_dto.dart';
import '../dto/paged_feed_response_dto.dart';
import '../../domain/entities/feed_post.dart';
import '../../../../core/network/pagination.dart';
import '../../../../core/utils/image_url_resolver.dart';

class FeedMapper {
  static FeedPost mapToEntity(FeedResponseDto dto) {
    return FeedPost(
      id: dto.id,
      creatorId: dto.creatorId,
      creatorName: dto.creatorName,
      creatorAvatar: resolveImageUrl(dto.creatorAvatar),
      imageUrl: resolveImageUrl(dto.imageUrl),
      description: dto.description,
      publishedAt: dto.publishedAt,
      likeCount: dto.likeCount,
      commentCount: dto.commentCount,
      isLiked: dto.isLiked,
      hashtags: dto.hashtags,
    );
  }

  static Pagination<FeedPost> mapToPagination(PagedFeedResponseDto dto) {
    return Pagination<FeedPost>(
      items: dto.items.map((e) => mapToEntity(e)).toList(),
      pageNumber: dto.pageNumber,
      pageSize: dto.pageSize,
      hasMore: dto.hasMore,
    );
  }
}
