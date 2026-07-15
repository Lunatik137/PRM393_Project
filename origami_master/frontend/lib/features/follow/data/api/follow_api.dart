import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/paged_user_response_dto.dart';
import '../../../../core/network/pagination.dart';

part 'follow_api.g.dart';

@RestApi()
abstract class FollowApi {
  factory FollowApi(Dio dio, {String baseUrl}) = _FollowApi;

  @POST('/users/{userId}/follow')
  Future<void> followUser(
    @Path('userId') String userId,
  );

  @DELETE('/users/{userId}/follow')
  Future<void> unfollowUser(
    @Path('userId') String userId,
  );

  @GET('/users/{userId}/followers')
  Future<Pagination<FollowUserDto>> getFollowers(
    @Path('userId') String userId, {
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });

  @GET('/users/{userId}/following')
  Future<Pagination<FollowUserDto>> getFollowing(
    @Path('userId') String userId, {
    @Query('page') required int page,
    @Query('pageSize') required int pageSize,
  });
}

