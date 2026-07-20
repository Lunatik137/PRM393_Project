import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'feed_event.dart';
import 'feed_state.dart';
import '../../domain/usecases/get_feed.dart';
import '../../domain/usecases/like_post.dart';
import '../../domain/usecases/unlike_post.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../domain/entities/feed_post.dart';

const int _backendBatchSize = 20;

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedUseCase _getFeed;
  final LikePostUseCase _likePost;
  final UnlikePostUseCase _unlikePost;

  List<FeedPost> _allFetchedPosts = [];
  int _backendPage = 1;
  bool _backendHasMore = true;
  int _scrollStep = 0;
  int _visibleCount = 1;

  FeedBloc(this._getFeed, this._likePost, this._unlikePost) : super(FeedInitial()) {
    on<LoadFeed>(_onLoadFeed);
    on<RefreshFeed>(_onRefreshFeed);
    on<LoadMoreFeed>(_onLoadMoreFeed);
    on<LikePost>(_onLikePost);
    on<UnlikePost>(_onUnlikePost);
  }

  int _getIncrement(int step) {
    if (step <= 1) return 1;
    return 1 << (step - 1);
  }

  Future<void> _onLoadFeed(LoadFeed event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      _backendPage = 1;
      _scrollStep = 0;
      _visibleCount = 1;
      final pagination = await _getFeed(_backendPage, _backendBatchSize);
      _allFetchedPosts = List.from(pagination.items);
      _backendHasMore = pagination.hasMore;

      if (_allFetchedPosts.isEmpty) {
        emit(FeedEmpty());
      } else {
        final visible = _allFetchedPosts.take(_visibleCount).toList();
        final reachedMax = _visibleCount >= _allFetchedPosts.length && !_backendHasMore;
        emit(FeedLoaded(
          posts: visible,
          currentPage: _scrollStep + 1,
          hasReachedMax: reachedMax,
        ));
      }
    } on AppException catch (e) {
      emit(FeedError(e.message));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onRefreshFeed(RefreshFeed event, Emitter<FeedState> emit) async {
    try {
      _backendPage = 1;
      _scrollStep = 0;
      _visibleCount = 1;
      final pagination = await _getFeed(_backendPage, _backendBatchSize);
      _allFetchedPosts = List.from(pagination.items);
      _backendHasMore = pagination.hasMore;

      if (_allFetchedPosts.isEmpty) {
        emit(FeedEmpty());
      } else {
        final visible = _allFetchedPosts.take(_visibleCount).toList();
        final reachedMax = _visibleCount >= _allFetchedPosts.length && !_backendHasMore;
        emit(FeedLoaded(
          posts: visible,
          currentPage: _scrollStep + 1,
          hasReachedMax: reachedMax,
        ));
      }
    } on AppException catch (e) {
      emit(FeedError(e.message));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onLoadMoreFeed(LoadMoreFeed event, Emitter<FeedState> emit) async {
    if (state is FeedLoadingMore || state is FeedRefreshing || state is FeedErrorLoadingMore) {
      if (state is! FeedErrorLoadingMore) return;
    }

    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      if (currentState.hasReachedMax) return;

      _scrollStep++;
      _visibleCount += _getIncrement(_scrollStep);

      if (_visibleCount > _allFetchedPosts.length && _backendHasMore) {
        emit(FeedLoadingMore(
          posts: currentState.posts,
          currentPage: currentState.currentPage,
          hasReachedMax: currentState.hasReachedMax,
        ));

        try {
          final nextPage = _backendPage + 1;
          final pagination = await _getFeed(nextPage, _backendBatchSize);
          _backendPage = nextPage;
          if (pagination.items.isNotEmpty) {
            _allFetchedPosts.addAll(pagination.items);
          }
          _backendHasMore = pagination.hasMore;
        } catch (e) {
          // Keep fetched items on network error
        }
      }

      final visible = _allFetchedPosts.take(_visibleCount).toList();
      final reachedMax = _visibleCount >= _allFetchedPosts.length && !_backendHasMore;

      emit(FeedLoaded(
        posts: visible,
        currentPage: _scrollStep + 1,
        hasReachedMax: reachedMax,
      ));
    }
  }

  Future<void> _onLikePost(LikePost event, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      
      FeedPost? targetPost;
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          targetPost = post;
          return post.copyWith(isLiked: true, likeCount: post.likeCount + 1);
        }
        return post;
      }).toList();

      if (targetPost == null) return;
      emit(currentState.copyWith(posts: updatedPosts));

      try {
        await _likePost(event.postId);
      } catch (_) {
        final revertedPosts = currentState.posts.map((post) {
          if (post.id == event.postId) {
            return targetPost!;
          }
          return post;
        }).toList();
        emit(currentState.copyWith(posts: revertedPosts));
      }
    }
  }

  Future<void> _onUnlikePost(UnlikePost event, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      
      FeedPost? targetPost;
      final updatedPosts = currentState.posts.map((post) {
        if (post.id == event.postId) {
          targetPost = post;
          return post.copyWith(isLiked: false, likeCount: post.likeCount - 1);
        }
        return post;
      }).toList();

      if (targetPost == null) return;
      emit(currentState.copyWith(posts: updatedPosts));

      try {
        await _unlikePost(event.postId);
      } catch (_) {
        final revertedPosts = currentState.posts.map((post) {
          if (post.id == event.postId) {
            return targetPost!;
          }
          return post;
        }).toList();
        emit(currentState.copyWith(posts: revertedPosts));
      }
    }
  }
}
