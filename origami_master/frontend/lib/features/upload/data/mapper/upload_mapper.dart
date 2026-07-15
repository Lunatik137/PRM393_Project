import 'dart:io';
import '../dto/upload_response_dto.dart';
import '../../domain/entities/uploaded_image.dart';

class UploadMapper {
  static UploadedImage mapToEntity(UploadResponseDto dto, File originalFile) {
    return UploadedImage(
      imageUrl: dto.imageUrl,
      fileName: dto.fileName ?? originalFile.path.split('/').last,
      fileSize: dto.fileSize ?? originalFile.lengthSync(),
      contentType: dto.contentType ?? 'image/jpeg',
    );
  }
}

