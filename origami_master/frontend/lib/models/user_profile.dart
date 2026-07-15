import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String avatarPath;
  final int completedFoldsCount;
  final int publicCreationsCount;
  final int followersCount;
  final int followingCount;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarPath,
    required this.completedFoldsCount,
    required this.publicCreationsCount,
    this.followersCount = 0,
    this.followingCount = 0,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserProfile &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          email == other.email &&
          avatarPath == other.avatarPath &&
          completedFoldsCount == other.completedFoldsCount &&
          publicCreationsCount == other.publicCreationsCount &&
          followersCount == other.followersCount &&
          followingCount == other.followingCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatarPath.hashCode ^
      completedFoldsCount.hashCode ^
      publicCreationsCount.hashCode ^
      followersCount.hashCode ^
      followingCount.hashCode;
}
