import '../models/user_profile.dart';
import '../repositories/user_repository.dart';

class MockUserRepository implements UserRepository {
  @override
  Future<UserProfile> getUserProfile() async {
    return UserProfile(
      id: 'usr1',
      name: 'John Doe',
      email: 'john@example.com',
      avatarPath: '',
      rank: 'Novice',
      totalXp: 150,
      completedFolds: 3,
    );
  }
}
