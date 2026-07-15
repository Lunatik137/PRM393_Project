import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'gallery_api.dart';

@module
abstract class GalleryModule {
  @lazySingleton
  GalleryApi getGalleryApi(Dio dio) => GalleryApi(dio);
}
