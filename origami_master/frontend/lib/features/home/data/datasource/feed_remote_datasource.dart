import 'package:injectable/injectable.dart';
import '../api/feed_api.dart';
import '../dto/paged_feed_response_dto.dart';

abstract class FeedRemoteDataSource {
  Future<PagedFeedResponseDto> getFeed(int page, int pageSize);
  Future<void> likePost(String postId);
  Future<void> unlikePost(String postId);
}

@LazySingleton(as: FeedRemoteDataSource)
class FeedRemoteDataSourceImpl implements FeedRemoteDataSource {
  final FeedApi _api;

  FeedRemoteDataSourceImpl(this._api);

  @override
  Future<PagedFeedResponseDto> getFeed(int page, int pageSize) async {
    return await _api.getFeed(page: page, pageSize: pageSize);
  }

  @override
  Future<void> likePost(String postId) async {
    await _api.likePost(postId);
  }

  @override
  Future<void> unlikePost(String postId) async {
    await _api.unlikePost(postId);
  }
}

