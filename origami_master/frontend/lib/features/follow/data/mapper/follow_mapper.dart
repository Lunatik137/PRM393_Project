import '../dto/paged_user_response_dto.dart';
import '../../domain/entities/follow_user.dart';
import '../../../../core/network/pagination.dart';

class FollowMapper {
  static FollowUser mapToEntity(FollowUserDto dto) {
    return FollowUser(
      id: dto.id,
      username: dto.username,
      avatarUrl: dto.avatarUrl,
      bio: dto.bio,
      followersCount: dto.followersCount,
      followingCount: dto.followingCount,
      isFollowing: dto.isFollowing,
    );
  }

  static Pagination<FollowUser> mapToPagination(Pagination<FollowUserDto> dto) {
    return Pagination<FollowUser>(
      items: dto.items.map((e) => mapToEntity(e)).toList(),
      pageNumber: dto.pageNumber,
      pageSize: dto.pageSize,
      hasMore: dto.hasMore,
    );
  }
}

