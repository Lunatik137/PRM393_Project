import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/search_response_dto.dart';

part 'search_api.g.dart';

@RestApi()
abstract class SearchApi {
  factory SearchApi(Dio dio, {String baseUrl}) = _SearchApi;

  @GET('/search')
  Future<SearchResponseDto> search(@Query('query') String query);
}
