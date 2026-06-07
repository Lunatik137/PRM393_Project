class UserCreation {
  final String id;
  final String origamiId;
  final String title;
  final String imagePath;
  final DateTime completedAt;
  final int xpEarned;

  UserCreation({
    required this.id,
    required this.origamiId,
    required this.title,
    required this.imagePath,
    required this.completedAt,
    required this.xpEarned,
  });
}
