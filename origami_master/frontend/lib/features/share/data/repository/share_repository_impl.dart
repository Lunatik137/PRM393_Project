import 'package:injectable/injectable.dart';
import '../datasource/share_remote_datasource.dart';
import '../mapper/share_mapper.dart';
import '../../domain/entities/share_link.dart';
import '../../domain/entities/shared_creation.dart';
import '../../domain/repositories/share_repository.dart';

@Injectable(as: ShareRepository)
class ShareRepositoryImpl implements ShareRepository {
  final ShareRemoteDataSource _remoteDataSource;

  ShareRepositoryImpl(this._remoteDataSource);

  @override
  Future<ShareLink> generateShareLink(String galleryId) async {
    final dto = await _remoteDataSource.generateShareLink(galleryId);
    return ShareLink(
      id: dto.shareLinkId,
      creationId: galleryId,
      creationName: '',
      shareUrl: dto.url,
      token: '',
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  @override
  Future<List<ShareLink>> getShareLinks() async {
    final dtos = await _remoteDataSource.getShareLinks();
    return dtos.map((dto) => ShareMapper.mapToEntity(dto)).toList();
  }

  @override
  Future<void> deleteShareLink(String shareId) {
    return _remoteDataSource.deleteShareLink(shareId);
  }

  @override
  Future<void> toggleShareLink(String shareId) {
    return _remoteDataSource.toggleShareLink(shareId);
  }

  @override
  Future<SharedCreation> getSharedCreation(String token) async {
    final dto = await _remoteDataSource.getSharedCreation(token);
    return ShareMapper.mapCreationToEntity(dto);
  }
}
