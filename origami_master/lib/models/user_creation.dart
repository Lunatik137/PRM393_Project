import 'package:flutter/foundation.dart';

@immutable
class UserCreation {
  final String id;
  final String origamiId;
  final String foldName;
  final String imagePath;
  final String creatorId;
  final String creatorNickname;
  final String creatorAvatarPath;
  final DateTime completedAt;
  final bool isPublic;
  final String? description;

  const UserCreation({
    required this.id,
    required this.origamiId,
    required this.foldName,
    required this.imagePath,
    required this.creatorId,
    required this.creatorNickname,
    required this.creatorAvatarPath,
    required this.completedAt,
    this.isPublic = false,
    this.description,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCreation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          origamiId == other.origamiId &&
          foldName == other.foldName &&
          imagePath == other.imagePath &&
          creatorId == other.creatorId &&
          creatorNickname == other.creatorNickname &&
          creatorAvatarPath == other.creatorAvatarPath &&
          completedAt == other.completedAt &&
          isPublic == other.isPublic &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      origamiId.hashCode ^
      foldName.hashCode ^
      imagePath.hashCode ^
      creatorId.hashCode ^
      creatorNickname.hashCode ^
      creatorAvatarPath.hashCode ^
      completedAt.hashCode ^
      isPublic.hashCode ^
      description.hashCode;
}
