import 'dart:io';
import 'package:injectable/injectable.dart';
import '../entities/uploaded_image.dart';
import '../repositories/upload_repository.dart';

@injectable
class UploadImageUseCase {
  final UploadRepository _repository;

  UploadImageUseCase(this._repository);

  Future<UploadedImage> call(File file) {
    return _repository.uploadImage(file);
  }
}
