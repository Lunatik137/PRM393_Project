import 'package:equatable/equatable.dart';

class FeedPost extends Equatable {
  final String id;
  final String creatorId;
  final String creatorName;
  final String? creatorAvatar;
  final String? imageUrl;
  final String description;
  final DateTime publishedAt;
  final int likeCount;
  final int commentCount;
  final bool isLiked;
  final List<String> hashtags;

  const FeedPost({
    required this.id,
    required this.creatorId,
    required this.creatorName,
    this.creatorAvatar,
    this.imageUrl,
    required this.description,
    required this.publishedAt,
    required this.likeCount,
    required this.commentCount,
    required this.isLiked,
    this.hashtags = const [],
  });

  FeedPost copyWith({
    String? id,
    String? creatorId,
    String? creatorName,
    String? creatorAvatar,
    String? imageUrl,
    String? description,
    DateTime? publishedAt,
    int? likeCount,
    int? commentCount,
    bool? isLiked,
    List<String>? hashtags,
  }) {
    return FeedPost(
      id: id ?? this.id,
      creatorId: creatorId ?? this.creatorId,
      creatorName: creatorName ?? this.creatorName,
      creatorAvatar: creatorAvatar ?? this.creatorAvatar,
      imageUrl: imageUrl ?? this.imageUrl,
      description: description ?? this.description,
      publishedAt: publishedAt ?? this.publishedAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      isLiked: isLiked ?? this.isLiked,
      hashtags: hashtags ?? this.hashtags,
    );
  }

  @override
  List<Object?> get props => [
        id,
        creatorId,
        creatorName,
        creatorAvatar,
        imageUrl,
        description,
        publishedAt,
        likeCount,
        commentCount,
        isLiked,
        hashtags,
      ];
}
