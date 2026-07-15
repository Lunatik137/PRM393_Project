import 'dart:io';
import 'package:injectable/injectable.dart';
import '../api/upload_api.dart';
import '../dto/upload_response_dto.dart';

abstract class UploadRemoteDataSource {
  Future<UploadResponseDto> uploadImage(File file);
}

@LazySingleton(as: UploadRemoteDataSource)
class UploadRemoteDataSourceImpl implements UploadRemoteDataSource {
  final UploadApi _api;

  UploadRemoteDataSourceImpl(this._api);

  @override
  Future<UploadResponseDto> uploadImage(File file) async {
    return await _api.uploadImage(file);
  }
}

