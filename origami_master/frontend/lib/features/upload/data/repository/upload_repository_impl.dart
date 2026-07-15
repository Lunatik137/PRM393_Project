import 'dart:io';
import 'package:injectable/injectable.dart';
import '../datasource/upload_remote_datasource.dart';
import '../mapper/upload_mapper.dart';
import '../../domain/entities/uploaded_image.dart';
import '../../domain/repositories/upload_repository.dart';

@Injectable(as: UploadRepository)
class UploadRepositoryImpl implements UploadRepository {
  final UploadRemoteDataSource _remoteDataSource;

  UploadRepositoryImpl(this._remoteDataSource);

  @override
  Future<UploadedImage> uploadImage(File file) async {
    final dto = await _remoteDataSource.uploadImage(file);
    return UploadMapper.mapToEntity(dto, file);
  }
}
