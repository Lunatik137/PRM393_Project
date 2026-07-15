import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'follow_api.dart';

@module
abstract class FollowModule {
  @lazySingleton
  FollowApi getFollowApi(Dio dio) => FollowApi(dio);
}
