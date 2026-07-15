// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GalleryResponseDto _$GalleryResponseDtoFromJson(Map<String, dynamic> json) =>
    GalleryResponseDto(
      id: json['id'] as String,
      origamiModelId: json['origamiModelId'] as String?,
      origamiModelName: json['origamiModelName'] as String?,
      imageUrl: json['imageUrl'] as String,
      caption: json['caption'] as String?,
      difficulty: json['difficulty'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      visibility: json['visibility'] as String?,
      isPublished: json['isPublished'] as bool?,
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String,
      creatorAvatar: json['creatorAvatar'] as String?,
      shareLinkId: json['shareLinkId'] as String?,
      shareToken: json['shareToken'] as String?,
      shareIsActive: json['shareIsActive'] as bool?,
      hashtags: (json['hashtags'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );
