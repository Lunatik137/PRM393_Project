import 'package:equatable/equatable.dart';

class GalleryItem extends Equatable {
  final String id;
  final String? origamiModelId;
  final String? origamiModelName;
  final String imageUrl;
  final String? caption;
  final String? difficulty;
  final DateTime? createdAt;
  final String? visibility;
  final bool? isPublished;
  final String creatorId;
  final String creatorName;
  final String? creatorAvatar;
  // Share link info
  final String? shareLinkId;
  final String? shareToken;
  final bool? shareIsActive;
  final List<String>? hashtags;


  const GalleryItem({
    required this.id,
    this.origamiModelId,
    this.origamiModelName,
    required this.imageUrl,
    this.caption,
    this.difficulty,
    this.createdAt,
    this.visibility,
    this.isPublished,
    required this.creatorId,
    required this.creatorName,
    this.creatorAvatar,
    this.shareLinkId,
    this.shareToken,
    this.shareIsActive,
    this.hashtags,
  });


  @override
  List<Object?> get props => [
        id,
        origamiModelId,
        origamiModelName,
        imageUrl,
        caption,
        difficulty,
        createdAt,
        visibility,
        isPublished,
        creatorId,
        creatorName,
        creatorAvatar,
        shareLinkId,
        shareToken,
        shareIsActive,
        hashtags,
      ];
}

