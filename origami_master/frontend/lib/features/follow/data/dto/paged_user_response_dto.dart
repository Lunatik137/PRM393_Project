import 'package:json_annotation/json_annotation.dart';

part 'paged_user_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class FollowUserDto {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;

  FollowUserDto({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
  });

  factory FollowUserDto.fromJson(Map<String, dynamic> json) => _$FollowUserDtoFromJson(json);
}
