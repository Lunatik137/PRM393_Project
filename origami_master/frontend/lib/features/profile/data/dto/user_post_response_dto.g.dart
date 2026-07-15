// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_post_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPostResponseDto _$UserPostResponseDtoFromJson(Map<String, dynamic> json) =>
    UserPostResponseDto(
      id: json['id'] as String,
      imagePath: json['imageUrl'] as String?,
      caption: json['description'] as String?,
      likeCount: (json['likeCount'] as num).toInt(),
      commentCount: (json['commentCount'] as num).toInt(),
    );
