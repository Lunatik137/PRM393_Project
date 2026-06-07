import '../models/shared_link.dart';

abstract class ShareLinkRepository {
  Future<SharedLink> generateLink(String creationId);
  Future<List<SharedLink>> getSharedLinks();
}
