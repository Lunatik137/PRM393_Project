import 'package:json_annotation/json_annotation.dart';
part 'user_dto.g.dart';

@JsonSerializable(createToJson: false)
class UserDto {
  final String id;
  final String username;
  final String? email;
  final String? profilePictureUrl;

  UserDto({
    required this.id,
    required this.username,
    this.email,
    this.profilePictureUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
}
