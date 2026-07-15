import '../dto/gallery_response_dto.dart';
import '../../domain/entities/gallery_item.dart';
import '../../../../core/network/pagination.dart';
import '../../../../core/utils/image_url_resolver.dart';

class GalleryMapper {
  static GalleryItem mapToEntity(GalleryResponseDto dto) {
    return GalleryItem(
      id: dto.id,
      origamiModelId: dto.origamiModelId,
      origamiModelName: dto.origamiModelName,
      imageUrl: resolveImageUrl(dto.imageUrl),
      caption: dto.caption,
      difficulty: dto.difficulty,
      createdAt: dto.createdAt,
      visibility: dto.visibility,
      isPublished: dto.isPublished,
      creatorId: dto.creatorId,
      creatorName: dto.creatorName,
      creatorAvatar: resolveImageUrl(dto.creatorAvatar),
      shareLinkId: dto.shareLinkId,
      shareToken: dto.shareToken,
      shareIsActive: dto.shareIsActive,
      hashtags: dto.hashtags,
    );
  }

  static Pagination<GalleryItem> mapToPagination(Pagination<GalleryResponseDto> dto) {
    return Pagination<GalleryItem>(
      items: dto.items.map(mapToEntity).toList(),
      pageNumber: dto.pageNumber,
      pageSize: dto.pageSize,
      hasMore: dto.hasMore,
    );
  }
}
