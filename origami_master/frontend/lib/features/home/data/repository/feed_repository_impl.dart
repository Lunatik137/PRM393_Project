import 'package:injectable/injectable.dart';
import '../../domain/repositories/feed_repository.dart';
import '../../domain/entities/feed_post.dart';
import '../datasource/feed_remote_datasource.dart';
import '../mapper/feed_mapper.dart';
import '../../../../core/network/pagination.dart';

@LazySingleton(as: FeedRepository)
class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDataSource _remoteDataSource;

  FeedRepositoryImpl(this._remoteDataSource);

  @override
  Future<Pagination<FeedPost>> getFeed(int page, int pageSize) async {
    final dto = await _remoteDataSource.getFeed(page, pageSize);
    return FeedMapper.mapToPagination(dto);
  }

  @override
  Future<void> likePost(String postId) async {
    await _remoteDataSource.likePost(postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    await _remoteDataSource.unlikePost(postId);
  }
}
