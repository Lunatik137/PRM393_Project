import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/profile_response_dto.dart';
import '../dto/user_post_response_dto.dart';
import '../../../../core/network/pagination.dart';

part 'profile_api.g.dart';

@RestApi()
abstract class ProfileApi {
  factory ProfileApi(Dio dio, {String baseUrl}) = _ProfileApi;

  @GET('/profile/me')
  Future<ProfileResponseDto> getMyProfile();

  @GET('/users/{userId}')
  Future<ProfileResponseDto> getUserProfile(
    @Path('userId') String userId,
  );

  @GET('/users/{userId}/posts')
  Future<Pagination<UserPostResponseDto>> getUserPosts(
    @Path('userId') String userId, {
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });
}

