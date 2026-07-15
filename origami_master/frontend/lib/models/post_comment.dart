import 'package:flutter/foundation.dart';

@immutable
class PostComment {
  final String id;
  final String postId;
  final String userId;
  final String content;
  final DateTime createdAt;

  const PostComment({
    required this.id,
    required this.postId,
    required this.userId,
    required this.content,
    required this.createdAt,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PostComment &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          postId == other.postId &&
          userId == other.userId &&
          content == other.content &&
          createdAt == other.createdAt;

  @override
  int get hashCode =>
      id.hashCode ^
      postId.hashCode ^
      userId.hashCode ^
      content.hashCode ^
      createdAt.hashCode;
}
