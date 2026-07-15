import 'package:injectable/injectable.dart';
import '../api/follow_api.dart';
import '../dto/paged_user_response_dto.dart';
import '../../../../core/network/pagination.dart';

abstract class FollowRemoteDataSource {
  Future<void> followUser(String userId);
  Future<void> unfollowUser(String userId);
  Future<Pagination<FollowUserDto>> getFollowers(String userId, int page, int pageSize);
  Future<Pagination<FollowUserDto>> getFollowing(String userId, int page, int pageSize);
}

@LazySingleton(as: FollowRemoteDataSource)
class FollowRemoteDataSourceImpl implements FollowRemoteDataSource {
  final FollowApi _api;

  FollowRemoteDataSourceImpl(this._api);

  @override
  Future<void> followUser(String userId) async {
    await _api.followUser(userId);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await _api.unfollowUser(userId);
  }

  @override
  Future<Pagination<FollowUserDto>> getFollowers(String userId, int page, int pageSize) async {
    return await _api.getFollowers(userId, page: page, pageSize: pageSize);
  }

  @override
  Future<Pagination<FollowUserDto>> getFollowing(String userId, int page, int pageSize) async {
    return await _api.getFollowing(userId, page: page, pageSize: pageSize);
  }
}

