import 'dart:io';
import '../entities/uploaded_image.dart';

abstract class UploadRepository {
  Future<UploadedImage> uploadImage(File file);
}
