import '../models/community_creation.dart';
import '../models/user_creation.dart';
import '../repositories/creation_repository.dart';

class MockCreationRepository implements CreationRepository {
  @override
  Future<List<CommunityCreation>> getCommunityCreationsByOrigamiId(
    String origamiId,
  ) async {
    return [
      CommunityCreation(
        id: 'c1',
        origamiId: origamiId,
        creatorName: 'Alice',
        creatorAvatarPath: '',
        imagePath: '',
        completedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<UserCreation>> getUserCreations() async {
    return [
      UserCreation(
        id: 'u1',
        origamiId: '1',
        title: 'My First Crane',
        imagePath: '',
        completedAt: DateTime.now(),
        xpEarned: 50,
      ),
    ];
  }

  @override
  Future<UserCreation?> getUserCreationById(String id) async {
    return (await getUserCreations()).first;
  }
}
