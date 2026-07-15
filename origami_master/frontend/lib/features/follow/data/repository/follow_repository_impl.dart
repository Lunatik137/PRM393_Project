import 'package:injectable/injectable.dart';
import '../../domain/repositories/follow_repository.dart';
import '../../domain/entities/follow_user.dart';
import '../datasource/follow_remote_datasource.dart';
import '../mapper/follow_mapper.dart';
import '../../../../core/network/pagination.dart';

@LazySingleton(as: FollowRepository)
class FollowRepositoryImpl implements FollowRepository {
  final FollowRemoteDataSource _remoteDataSource;

  FollowRepositoryImpl(this._remoteDataSource);

  @override
  Future<void> followUser(String userId) async {
    await _remoteDataSource.followUser(userId);
  }

  @override
  Future<void> unfollowUser(String userId) async {
    await _remoteDataSource.unfollowUser(userId);
  }

  @override
  Future<Pagination<FollowUser>> getFollowers(String userId, int page, int pageSize) async {
    final dto = await _remoteDataSource.getFollowers(userId, page, pageSize);
    return FollowMapper.mapToPagination(dto);
  }

  @override
  Future<Pagination<FollowUser>> getFollowing(String userId, int page, int pageSize) async {
    final dto = await _remoteDataSource.getFollowing(userId, page, pageSize);
    return FollowMapper.mapToPagination(dto);
  }
}
