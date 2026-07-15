// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'share_link_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShareLinkResponseDto _$ShareLinkResponseDtoFromJson(
  Map<String, dynamic> json,
) => ShareLinkResponseDto(
  id: json['id'] as String,
  creationId: json['creationId'] as String,
  creationName: json['creationName'] as String,
  token: json['token'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  isActive: json['isActive'] as bool,
);
