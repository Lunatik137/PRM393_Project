// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shared_creation_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SharedCreationResponseDto _$SharedCreationResponseDtoFromJson(
  Map<String, dynamic> json,
) => SharedCreationResponseDto(
  imageUrl: json['imageUrl'] as String,
  origamiModelName: json['origamiModelName'] as String,
  creatorUsername: json['creatorUsername'] as String,
  completionDate: DateTime.parse(json['completionDate'] as String),
  visibility: json['visibility'] as String,
  description: json['description'] as String?,
);
