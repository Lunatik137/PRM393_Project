import 'package:injectable/injectable.dart';
import '../../domain/repositories/profile_repository.dart';
import '../../domain/entities/profile.dart';
import '../../../home/domain/entities/feed_post.dart';
import '../datasource/profile_remote_datasource.dart';
import '../mapper/profile_mapper.dart';
import '../../../../core/network/pagination.dart';

@LazySingleton(as: ProfileRepository)
class ProfileRepositoryImpl implements ProfileRepository {
  final ProfileRemoteDataSource _remoteDataSource;

  ProfileRepositoryImpl(this._remoteDataSource);

  @override
  Future<Profile> getMyProfile() async {
    final dto = await _remoteDataSource.getMyProfile();
    return ProfileMapper.mapToEntity(dto);
  }

  @override
  Future<Profile> getUserProfile(String userId) async {
    final dto = await _remoteDataSource.getUserProfile(userId);
    return ProfileMapper.mapToEntity(dto);
  }

  @override
  Future<Pagination<FeedPost>> getUserPosts(String userId, int page, int pageSize) async {
    final dto = await _remoteDataSource.getUserPosts(userId, page, pageSize);
    return ProfileMapper.mapToPostPagination(dto, userId);
  }
}
