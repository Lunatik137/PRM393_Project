class UserProfile {
  final String id;
  final String name;
  final String email;
  final String avatarPath;
  final String rank;
  final int totalXp;
  final int completedFolds;

  UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarPath,
    required this.rank,
    required this.totalXp,
    required this.completedFolds,
  });
}
