class FeedResponseDto {
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

  FeedResponseDto({
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

  factory FeedResponseDto.fromJson(Map<String, dynamic> json) {
    final author = json['author'] as Map<String, dynamic>? ?? {};
    
    var tags = <String>[];
    if (json['hashtags'] is List) {
      tags = (json['hashtags'] as List).map((e) => e.toString()).toList();
    }

    return FeedResponseDto(
      id: json['id']?.toString() ?? '',
      creatorId: author['id']?.toString() ?? '',
      creatorName: author['username']?.toString() ?? 'Unknown User',
      creatorAvatar: author['avatarUrl']?.toString(),
      imageUrl: json['imageUrl']?.toString(),
      description: json['description']?.toString() ?? '',
      publishedAt: json['publishedAt'] != null 
          ? DateTime.tryParse(json['publishedAt'].toString()) ?? DateTime.now() 
          : DateTime.now(),
      likeCount: json['likeCount'] as int? ?? 0,
      commentCount: json['commentCount'] as int? ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
      hashtags: tags,
    );
  }
}
