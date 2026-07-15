import 'package:json_annotation/json_annotation.dart';

part 'shared_creation_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class SharedCreationResponseDto {
  final String imageUrl;
  final String origamiModelName;
  final String creatorUsername;
  final DateTime completionDate;
  final String visibility;
  final String? description;

  SharedCreationResponseDto({
    required this.imageUrl,
    required this.origamiModelName,
    required this.creatorUsername,
    required this.completionDate,
    required this.visibility,
    this.description,
  });

  factory SharedCreationResponseDto.fromJson(Map<String, dynamic> json) => _$SharedCreationResponseDtoFromJson(json);
}
