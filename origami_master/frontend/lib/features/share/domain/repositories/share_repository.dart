import '../entities/share_link.dart';
import '../entities/shared_creation.dart';

abstract class ShareRepository {
  Future<ShareLink> generateShareLink(String galleryId);
  Future<List<ShareLink>> getShareLinks();
  Future<void> deleteShareLink(String shareId);
  Future<void> toggleShareLink(String shareId);
  Future<SharedCreation> getSharedCreation(String token);
}
