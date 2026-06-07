import '../models/community_creation.dart';
import '../models/user_creation.dart';

abstract class CreationRepository {
  Future<List<CommunityCreation>> getCommunityCreationsByOrigamiId(
    String origamiId,
  );
  Future<List<UserCreation>> getUserCreations();
  Future<UserCreation?> getUserCreationById(String id);
}
