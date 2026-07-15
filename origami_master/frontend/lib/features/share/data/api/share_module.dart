import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'share_api.dart';

@module
abstract class ShareModule {
  @lazySingleton
  ShareApi getShareApi(Dio dio) => ShareApi(dio);
}
