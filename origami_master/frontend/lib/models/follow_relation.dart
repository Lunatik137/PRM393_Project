import 'package:flutter/foundation.dart';

@immutable
class FollowRelation {
  final String followerId;
  final String followingId;

  const FollowRelation({required this.followerId, required this.followingId});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FollowRelation &&
          runtimeType == other.runtimeType &&
          followerId == other.followerId &&
          followingId == other.followingId;

  @override
  int get hashCode => followerId.hashCode ^ followingId.hashCode;
}
