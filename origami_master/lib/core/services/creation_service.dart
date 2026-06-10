import '../../data/mock/mock_data.dart';
import '../../models/user_creation.dart';

class CreationService {
  CreationService._();
  static final CreationService instance = CreationService._();

  final List<UserCreation> _creations = List.from(MockData.userGallery);

  void reset() {
    _creations.clear();
    _creations.addAll(MockData.userGallery);
  }

  Future<List<UserCreation>> getCreations() async {
    return List.unmodifiable(_creations);
  }

  Future<void> saveCreation(UserCreation creation) async {
    final index = _creations.indexWhere((c) => c.id == creation.id);
    if (index != -1) {
      _creations[index] = creation;
    } else {
      _creations.add(creation);
    }
  }

  Future<UserCreation?> getCreationById(String id) async {
    try {
      return _creations.firstWhere((c) => c.id == id);
    } catch (_) {
      try {
        return MockData.communityCreations.firstWhere((c) => c.id == id);
      } catch (_) {
        return null;
      }
    }
  }

  Future<void> deleteCreation(String id) async {
    _creations.removeWhere((c) => c.id == id);
  }

  Future<void> updateVisibility(String id, bool isPublic) async {
    final index = _creations.indexWhere((c) => c.id == id);
    if (index != -1) {
      final old = _creations[index];
      _creations[index] = UserCreation(
        id: old.id,
        origamiId: old.origamiId,
        foldName: old.foldName,
        imagePath: old.imagePath,
        creatorId: old.creatorId,
        creatorNickname: old.creatorNickname,
        creatorAvatarPath: old.creatorAvatarPath,
        completedAt: old.completedAt,
        isPublic: isPublic,
        description: old.description,
      );
    }
  }
}
