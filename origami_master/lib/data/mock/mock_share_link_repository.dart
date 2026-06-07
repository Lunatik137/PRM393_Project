import '../models/shared_link.dart';
import '../repositories/share_link_repository.dart';

class MockShareLinkRepository implements ShareLinkRepository {
  @override
  Future<SharedLink> generateLink(String creationId) async {
    return SharedLink(
      id: 'l1',
      creationId: creationId,
      token: 'abc',
      url: 'https://origami.master/share/abc',
      createdAt: DateTime.now(),
      isActive: true,
    );
  }

  @override
  Future<List<SharedLink>> getSharedLinks() async {
    return [await generateLink('u1')];
  }
}
