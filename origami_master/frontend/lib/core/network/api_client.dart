// ignore_for_file: unused_field

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET('/categories')
  Future<String> getCategories();

  @GET('/categories/{id}')
  Future<String> getCategoryById(@Path('id') String id);

  @GET('/origami/search')
  Future<String> searchOrigami(
    @Query('keyword') String? keyword,
    @Query('categoryId') String? categoryId,
    @Query('difficulty') int? difficulty,
    @Query('pageNumber') int pageNumber,
    @Query('pageSize') int pageSize,
  );

  @GET('/origami')
  Future<String> getOrigamiModels(
    @Query('pageNumber') int pageNumber,
    @Query('pageSize') int pageSize,
  );

  @GET('/origami/{id}')
  Future<String> getOrigamiById(@Path('id') String id);

  @GET('/origami/category/{id}')
  Future<String> getOrigamiByCategory(
    @Path('id') String id,
    @Query('pageNumber') int pageNumber,
    @Query('pageSize') int pageSize,
  );

  @GET('/origami/popular')
  Future<String> getPopularOrigami(@Query('limit') int limit);

  @GET('/origami/latest')
  Future<String> getLatestOrigami(@Query('limit') int limit);
}
