import '../models/achievement.dart';
import '../repositories/achievement_repository.dart';

class MockAchievementRepository implements AchievementRepository {
  @override
  Future<List<Achievement>> getAchievements() async {
    return [
      Achievement(
        id: 'a1',
        title: 'Beginner',
        description: 'Fold your first model.',
        xpReward: 100,
        progressPercent: 1.0,
        isUnlocked: true,
        iconPath: '',
      ),
    ];
  }
}
