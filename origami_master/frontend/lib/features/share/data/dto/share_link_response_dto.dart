import 'package:json_annotation/json_annotation.dart';
import '../../../../core/config/app_config.dart';

part 'share_link_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class ShareLinkResponseDto {
  final String id;
  final String creationId;
  final String creationName;
  final String token;
  final DateTime createdAt;
  final bool isActive;

  ShareLinkResponseDto({
    required this.id,
    required this.creationId,
    required this.creationName,
    required this.token,
    required this.createdAt,
    required this.isActive,
  });

  String get shareUrl => '${AppConfig.mediaBaseUrl}/share/$token';

  factory ShareLinkResponseDto.fromJson(Map<String, dynamic> json) => _$ShareLinkResponseDtoFromJson(json);
}
