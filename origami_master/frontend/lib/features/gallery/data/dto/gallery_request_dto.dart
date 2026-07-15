import 'package:json_annotation/json_annotation.dart';

part 'gallery_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class CreateGalleryRequestDto {
  @JsonKey(name: 'origamiModelId')
  final String? foldModelId;
  @JsonKey(name: 'imageUrl')
  final String imageUrl;
  @JsonKey(name: 'notes')
  final String? caption;
  @JsonKey(name: 'visibility')
  final String visibility;

  CreateGalleryRequestDto({
    this.foldModelId,
    required this.imageUrl,
    this.caption,
    required this.visibility,
  });

  Map<String, dynamic> toJson() => _$CreateGalleryRequestDtoToJson(this);
}

@JsonSerializable(createFactory: false)
class UpdateGalleryRequestDto {
  @JsonKey(name: 'notes')
  final String? caption;
  final String? visibility;
  final String? imageUrl;
  @JsonKey(name: 'origamiModelId')
  final String? foldModelId;

  UpdateGalleryRequestDto({
    this.caption,
    this.visibility,
    this.imageUrl,
    this.foldModelId,
  });

  Map<String, dynamic> toJson() => _$UpdateGalleryRequestDtoToJson(this);
}

@JsonSerializable(createFactory: false)
class UpdateVisibilityRequestDto {
  final String visibility;

  UpdateVisibilityRequestDto({required this.visibility});

  Map<String, dynamic> toJson() => _$UpdateVisibilityRequestDtoToJson(this);
}
