class Achievement {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final double progressPercent;
  final bool isUnlocked;
  final String iconPath;

  Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.progressPercent,
    required this.isUnlocked,
    required this.iconPath,
  });
}
