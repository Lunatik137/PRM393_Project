import 'package:json_annotation/json_annotation.dart';
import 'user_dto.dart';
part 'login_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class LoginResponseDto {
  final String accessToken;
  final String refreshToken;
  final UserDto user;

  LoginResponseDto({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
  });

  factory LoginResponseDto.fromJson(Map<String, dynamic> json) => _$LoginResponseDtoFromJson(json);
}
