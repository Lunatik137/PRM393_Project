import 'package:injectable/injectable.dart';
import '../api/share_api.dart';
import '../dto/share_link_response_dto.dart';
import '../dto/shared_creation_response_dto.dart';
import '../dto/generate_share_link_response_dto.dart';

abstract class ShareRemoteDataSource {
  Future<GenerateShareLinkResponseDto> generateShareLink(String galleryId);
  Future<List<ShareLinkResponseDto>> getShareLinks();
  Future<void> deleteShareLink(String shareId);
  Future<void> toggleShareLink(String shareId);
  Future<SharedCreationResponseDto> getSharedCreation(String token);
}

@Injectable(as: ShareRemoteDataSource)
class ShareRemoteDataSourceImpl implements ShareRemoteDataSource {
  final ShareApi _api;

  ShareRemoteDataSourceImpl(this._api);

  @override
  Future<GenerateShareLinkResponseDto> generateShareLink(String galleryId) async {
    return await _api.generateShareLink({'creationId': galleryId});
  }

  @override
  Future<List<ShareLinkResponseDto>> getShareLinks() async {
    return await _api.getShareLinks();
  }

  @override
  Future<void> deleteShareLink(String shareId) async {
    await _api.deleteShareLink(shareId);
  }

  @override
  Future<void> toggleShareLink(String shareId) async {
    await _api.toggleShareLink(shareId);
  }

  @override
  Future<SharedCreationResponseDto> getSharedCreation(String token) async {
    return await _api.getSharedCreation(token);
  }
}

