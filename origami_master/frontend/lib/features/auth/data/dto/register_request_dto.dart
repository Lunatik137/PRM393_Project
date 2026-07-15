import 'package:json_annotation/json_annotation.dart';
part 'register_request_dto.g.dart';

@JsonSerializable(createFactory: false)
class RegisterRequestDto {
  final String username;
  final String email;
  final String password;
  final String confirmPassword;

  RegisterRequestDto({
    required this.username,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toJson() => _$RegisterRequestDtoToJson(this);
}
