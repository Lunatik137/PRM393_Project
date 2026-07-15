import 'package:json_annotation/json_annotation.dart';

part 'user_post_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class UserPostResponseDto {
  final String id;
  @JsonKey(name: 'imageUrl')
  final String? imagePath;
  @JsonKey(name: 'description')
  final String? caption;
  final int likeCount;
  final int commentCount;

  UserPostResponseDto({
    required this.id,
    this.imagePath,
    this.caption,
    required this.likeCount,
    required this.commentCount,
  });

  factory UserPostResponseDto.fromJson(Map<String, dynamic> json) => _$UserPostResponseDtoFromJson(json);
}
