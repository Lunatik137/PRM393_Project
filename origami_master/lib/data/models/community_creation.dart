class CommunityCreation {
  final String id;
  final String origamiId;
  final String creatorName;
  final String creatorAvatarPath;
  final String imagePath;
  final DateTime completedAt;

  CommunityCreation({
    required this.id,
    required this.origamiId,
    required this.creatorName,
    required this.creatorAvatarPath,
    required this.imagePath,
    required this.completedAt,
  });
}
