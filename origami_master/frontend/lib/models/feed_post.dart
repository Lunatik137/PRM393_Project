import 'package:flutter/foundation.dart';

@immutable
class FeedPost {
  final String id;
  final String creatorId;
  final String? imageUrl;
  final String description;
  final int likesCount;
  final int commentsCount;
  final DateTime createdAt;
  final bool isLiked;

  const FeedPost({
    required this.id,
    required this.creatorId,
    this.imageUrl,
    required this.description,
    required this.likesCount,
    required this.commentsCount,
    required this.createdAt,
    required this.isLiked,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedPost &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          creatorId == other.creatorId &&
          imageUrl == other.imageUrl &&
          description == other.description &&
          likesCount == other.likesCount &&
          commentsCount == other.commentsCount &&
          createdAt == other.createdAt &&
          isLiked == other.isLiked;

  @override
  int get hashCode =>
      id.hashCode ^
      creatorId.hashCode ^
      imageUrl.hashCode ^
      description.hashCode ^
      likesCount.hashCode ^
      commentsCount.hashCode ^
      createdAt.hashCode ^
      isLiked.hashCode;
}
