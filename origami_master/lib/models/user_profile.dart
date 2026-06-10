import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String id;
  final String name;
  final String email;
  final String avatarPath;
  final int completedFoldsCount;
  final int publicCreationsCount;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarPath,
    required this.completedFoldsCount,
    required this.publicCreationsCount,
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
          publicCreationsCount == other.publicCreationsCount;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      email.hashCode ^
      avatarPath.hashCode ^
      completedFoldsCount.hashCode ^
      publicCreationsCount.hashCode;
}
