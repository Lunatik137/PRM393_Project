import 'package:json_annotation/json_annotation.dart';

part 'upload_response_dto.g.dart';

@JsonSerializable(createToJson: false)
class UploadResponseDto {
  final String imageUrl;
  final String? fileName;
  final int? fileSize;
  final String? contentType;

  UploadResponseDto({
    required this.imageUrl,
    this.fileName,
    this.fileSize,
    this.contentType,
  });

  factory UploadResponseDto.fromJson(Map<String, dynamic> json) => _$UploadResponseDtoFromJson(json);
}
