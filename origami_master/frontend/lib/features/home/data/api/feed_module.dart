import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'feed_api.dart';

@module
abstract class FeedModule {
  @lazySingleton
  FeedApi getFeedApi(Dio dio) => FeedApi(dio);
}
