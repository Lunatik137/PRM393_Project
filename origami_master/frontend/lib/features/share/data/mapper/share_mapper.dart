import '../dto/share_link_response_dto.dart';
import '../dto/shared_creation_response_dto.dart';
import '../../domain/entities/share_link.dart';
import '../../domain/entities/shared_creation.dart';

class ShareMapper {
  static ShareLink mapToEntity(ShareLinkResponseDto dto) {
    return ShareLink(
      id: dto.id,
      creationId: dto.creationId,
      creationName: dto.creationName,
      shareUrl: dto.shareUrl,
      token: dto.token,
      createdAt: dto.createdAt,
      isActive: dto.isActive,
    );
  }

  static SharedCreation mapCreationToEntity(SharedCreationResponseDto dto) {
    return SharedCreation(
      imageUrl: dto.imageUrl,
      origamiModelName: dto.origamiModelName,
      creatorUsername: dto.creatorUsername,
      completionDate: dto.completionDate,
      visibility: dto.visibility,
      description: dto.description,
    );
  }
}

