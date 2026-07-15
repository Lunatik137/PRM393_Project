import '../dto/comment_response_dto.dart';
import '../../domain/entities/comment.dart';
import '../../../../core/network/pagination.dart';

class CommentMapper {
  static Comment mapToEntity(CommentResponseDto dto) {
    return Comment(
      id: dto.id,
      postId: dto.postId,
      authorId: dto.authorId,
      authorName: dto.authorName ?? 'Unknown User',
      authorAvatar: dto.authorAvatar,
      content: dto.content ?? '',
      createdAt: dto.createdAt,
      isOwner: dto.isOwner,
    );
  }

  static Pagination<Comment> mapToPagination(Pagination<CommentResponseDto> dto) {
    return Pagination<Comment>(
      items: dto.items.map((e) => mapToEntity(e)).toList(),
      pageNumber: dto.pageNumber,
      pageSize: dto.pageSize,
      hasMore: dto.hasMore,
    );
  }
}

