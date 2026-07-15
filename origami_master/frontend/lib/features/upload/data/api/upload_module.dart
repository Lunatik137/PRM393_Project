import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'upload_api.dart';

@module
abstract class UploadModule {
  @lazySingleton
  UploadApi getUploadApi(Dio dio) => UploadApi(dio);
}
