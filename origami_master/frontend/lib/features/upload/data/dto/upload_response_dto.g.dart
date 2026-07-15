// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadResponseDto _$UploadResponseDtoFromJson(Map<String, dynamic> json) =>
    UploadResponseDto(
      imageUrl: json['imageUrl'] as String,
      fileName: json['fileName'] as String?,
      fileSize: (json['fileSize'] as num?)?.toInt(),
      contentType: json['contentType'] as String?,
    );
