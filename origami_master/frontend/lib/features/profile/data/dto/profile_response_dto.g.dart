// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileStatisticsDto _$ProfileStatisticsDtoFromJson(
  Map<String, dynamic> json,
) => ProfileStatisticsDto(
  completedFolds: (json['completedFolds'] as num).toInt(),
  publicPosts: (json['publicPosts'] as num).toInt(),
  followers: (json['followers'] as num).toInt(),
  following: (json['following'] as num).toInt(),
);

ProfileResponseDto _$ProfileResponseDtoFromJson(Map<String, dynamic> json) =>
    ProfileResponseDto(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      avatarUrl: json['avatarUrl'] as String?,
      bio: json['bio'] as String?,
      statistics: ProfileStatisticsDto.fromJson(
        json['statistics'] as Map<String, dynamic>,
      ),
      isFollowing: json['isFollowing'] as bool?,
    );
