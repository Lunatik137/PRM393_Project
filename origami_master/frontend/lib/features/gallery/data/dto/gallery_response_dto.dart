import 'package:json_annotation/json_annotation.dart';

part 'gallery_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class GalleryResponseDto {
  final String id;
  @JsonKey(name: 'origamiModelId')
  final String? origamiModelId;
  @JsonKey(name: 'origamiModelName')
  final String? origamiModelName;
  final String imageUrl;
  final String? caption;
  final String? difficulty;
  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;
  final String? visibility;
  @JsonKey(name: 'isPublished')
  final bool? isPublished;
  final String creatorId;
  final String creatorName;
  final String? creatorAvatar;
  // Share link fields (only populated in detail endpoint)
  final String? shareLinkId;
  final String? shareToken;
  final bool? shareIsActive;
  final List<String>? hashtags;


  GalleryResponseDto({
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


  factory GalleryResponseDto.fromJson(Map<String, dynamic> json) => _$GalleryResponseDtoFromJson(json);
}
