import 'package:json_annotation/json_annotation.dart';

part 'search_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class SearchResponseDto {
  final List<SearchUserDto> users;
  final List<SearchPostDto> posts;
  final List<SearchHashtagDto> hashtags;

  SearchResponseDto({
    this.users = const [],
    this.posts = const [],
    this.hashtags = const [],
  });

  factory SearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchHashtagDto {
  final String name;
  final int postCount;

  SearchHashtagDto({
    required this.name,
    required this.postCount,
  });

  factory SearchHashtagDto.fromJson(Map<String, dynamic> json) =>
      _$SearchHashtagDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchUserDto {
  final String id;
  final String username;
  final String fullName;
  final String? avatarUrl;
  final int followersCount;

  SearchUserDto({
    required this.id,
    required this.username,
    required this.fullName,
    this.avatarUrl,
    required this.followersCount,
  });

  factory SearchUserDto.fromJson(Map<String, dynamic> json) =>
      _$SearchUserDtoFromJson(json);
}

@JsonSerializable(createToJson: false)
class SearchPostDto {
  final String id;
  final String description;
  final String? imageUrl;
  final String creatorId;
  final String creatorName;
  final int likeCount;

  SearchPostDto({
    required this.id,
    required this.description,
    this.imageUrl,
    required this.creatorId,
    required this.creatorName,
    required this.likeCount,
  });

  factory SearchPostDto.fromJson(Map<String, dynamic> json) =>
      _$SearchPostDtoFromJson(json);
}
