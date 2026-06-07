class OrigamiModel {
  final String id;
  final String title;
  final String category;
  final String difficulty;
  final int durationMinutes;
  final int xpReward;
  final String imagePath;

  OrigamiModel({
    required this.id,
    required this.title,
    required this.category,
    required this.difficulty,
    required this.durationMinutes,
    required this.xpReward,
    required this.imagePath,
  });
}
