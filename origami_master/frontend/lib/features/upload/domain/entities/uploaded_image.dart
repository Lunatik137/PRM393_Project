import 'package:equatable/equatable.dart';

class UploadedImage extends Equatable {
  final String imageUrl;
  final String fileName;
  final int fileSize;
  final String contentType;

  const UploadedImage({
    required this.imageUrl,
    required this.fileName,
    required this.fileSize,
    required this.contentType,
  });

  @override
  List<Object?> get props => [imageUrl, fileName, fileSize, contentType];
}
