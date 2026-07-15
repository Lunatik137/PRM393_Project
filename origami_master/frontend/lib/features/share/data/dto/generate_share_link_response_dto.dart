import 'package:json_annotation/json_annotation.dart';

part 'generate_share_link_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class GenerateShareLinkResponseDto {
  final String shareLinkId;
  final String url;

  GenerateShareLinkResponseDto({
    required this.shareLinkId,
    required this.url,
  });

  factory GenerateShareLinkResponseDto.fromJson(Map<String, dynamic> json) => _$GenerateShareLinkResponseDtoFromJson(json);
}
