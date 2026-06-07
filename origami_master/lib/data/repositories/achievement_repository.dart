import '../models/achievement.dart';

abstract class AchievementRepository {
  Future<List<Achievement>> getAchievements();
}
