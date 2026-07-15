import 'package:json_annotation/json_annotation.dart';

part 'follow_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class FollowResponseDto {
  final bool success;

  FollowResponseDto({required this.success});

  factory FollowResponseDto.fromJson(Map<String, dynamic> json) => _$FollowResponseDtoFromJson(json);
}
