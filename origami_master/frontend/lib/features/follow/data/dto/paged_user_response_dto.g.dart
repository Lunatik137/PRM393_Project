// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_user_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FollowUserDto _$FollowUserDtoFromJson(Map<String, dynamic> json) =>
    FollowUserDto(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      followersCount: (json['followersCount'] as num).toInt(),
      followingCount: (json['followingCount'] as num).toInt(),
      isFollowing: json['isFollowing'] as bool,
    );
