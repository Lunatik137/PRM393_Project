import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'search_api.dart';

@module
abstract class SearchModule {
  @lazySingleton
  SearchApi getSearchApi(Dio dio) => SearchApi(dio);
}
