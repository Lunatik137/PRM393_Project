// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gallery_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Map<String, dynamic> _$CreateGalleryRequestDtoToJson(
  CreateGalleryRequestDto instance,
) => <String, dynamic>{
  'origamiModelId': instance.foldModelId,
  'imageUrl': instance.imageUrl,
  'notes': instance.caption,
  'visibility': instance.visibility,
};

Map<String, dynamic> _$UpdateGalleryRequestDtoToJson(
  UpdateGalleryRequestDto instance,
) => <String, dynamic>{
  'notes': instance.caption,
  'visibility': instance.visibility,
  'imageUrl': instance.imageUrl,
  'origamiModelId': instance.foldModelId,
};

Map<String, dynamic> _$UpdateVisibilityRequestDtoToJson(
  UpdateVisibilityRequestDto instance,
) => <String, dynamic>{'visibility': instance.visibility};
