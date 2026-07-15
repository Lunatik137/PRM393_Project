import 'package:json_annotation/json_annotation.dart';

part 'profile_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class ProfileStatisticsDto {
  final int completedFolds;
  @JsonKey(name: 'publicPosts')
  final int publicPosts;
  final int followers;
  final int following;

  ProfileStatisticsDto({
    required this.completedFolds,
    required this.publicPosts,
    required this.followers,
    required this.following,
  });

  factory ProfileStatisticsDto.fromJson(Map<String, dynamic> json) => _$ProfileStatisticsDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class ProfileResponseDto {
  final String id;
  final String username;
  final String? email;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final ProfileStatisticsDto statistics;
  final bool? isFollowing;

  ProfileResponseDto({
    required this.id,
    required this.username,
    this.email,
    this.displayName,
    this.avatarUrl,
    this.bio,
    required this.statistics,
    this.isFollowing,
  });

  factory ProfileResponseDto.fromJson(Map<String, dynamic> json) => _$ProfileResponseDtoFromJson(json);
}
