import 'package:json_annotation/json_annotation.dart';

part 'google_auth_request_dto.g.dart';

@JsonSerializable()
class GoogleAuthRequestDto {
  final String idToken;

  GoogleAuthRequestDto({required this.idToken});

  factory GoogleAuthRequestDto.fromJson(Map<String, dynamic> json) => _$GoogleAuthRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleAuthRequestDtoToJson(this);
}
