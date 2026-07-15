// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResponseDto _$SearchResponseDtoFromJson(Map<String, dynamic> json) =>
    SearchResponseDto(
      users:
          (json['users'] as List<dynamic>?)
              ?.map((e) => SearchUserDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      posts:
          (json['posts'] as List<dynamic>?)
              ?.map((e) => SearchPostDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      hashtags:
          (json['hashtags'] as List<dynamic>?)
              ?.map((e) => SearchHashtagDto.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

SearchHashtagDto _$SearchHashtagDtoFromJson(Map<String, dynamic> json) =>
    SearchHashtagDto(
      name: json['name'] as String,
      postCount: (json['postCount'] as num).toInt(),
    );

SearchUserDto _$SearchUserDtoFromJson(Map<String, dynamic> json) =>
    SearchUserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      fullName: json['fullName'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      followersCount: (json['followersCount'] as num).toInt(),
    );

SearchPostDto _$SearchPostDtoFromJson(Map<String, dynamic> json) =>
    SearchPostDto(
      id: json['id'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      creatorId: json['creatorId'] as String,
      creatorName: json['creatorName'] as String,
      likeCount: (json['likeCount'] as num).toInt(),
    );
