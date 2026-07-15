import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'feed_event.dart';
import 'feed_state.dart';
import '../../domain/usecases/get_feed.dart';
import '../../domain/usecases/like_post.dart';
import '../../domain/usecases/unlike_post.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../domain/entities/feed_post.dart';

const int _pageSize = 20;

@injectable
class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final GetFeedUseCase _getFeed;
  final LikePostUseCase _likePost;
  final UnlikePostUseCase _unlikePost;

  FeedBloc(this._getFeed, this._likePost, this._unlikePost) : super(FeedInitial()) {
    on<LoadFeed>(_onLoadFeed);
    on<RefreshFeed>(_onRefreshFeed);
    on<LoadMoreFeed>(_onLoadMoreFeed);
    on<LikePost>(_onLikePost);
    on<UnlikePost>(_onUnlikePost);
  }

  Future<void> _onLoadFeed(LoadFeed event, Emitter<FeedState> emit) async {
    emit(FeedLoading());
    try {
      final pagination = await _getFeed(1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FeedEmpty());
      } else {
        emit(FeedLoaded(
          posts: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(FeedError(e.message));
    } catch (e) {
      emit(FeedError(e.toString()));
    }
  }

  Future<void> _onRefreshFeed(RefreshFeed event, Emitter<FeedState> emit) async {
    if (state is FeedLoaded) {
      final currentState = state as FeedLoaded;
      emit(FeedRefreshing(
        posts: currentState.posts,
        currentPage: currentState.currentPage,
        hasReachedMax: currentState.hasReachedMax,
      ));
    } else {
      emit(FeedLoading());
    }

    try {
      final pagination = await _getFeed(1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FeedEmpty());
      } else {
        emit(FeedLoaded(
          posts: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
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

      final nextPage = currentState.currentPage + 1;
      emit(FeedLoadingMore(
        posts: currentState.posts,
        currentPage: currentState.currentPage,
        hasReachedMax: currentState.hasReachedMax,
      ));

      try {
        final pagination = await _getFeed(nextPage, _pageSize);
        emit(FeedLoaded(
          posts: List.of(currentState.posts)..addAll(pagination.items),
          currentPage: nextPage,
          hasReachedMax: !pagination.hasMore,
        ));
      } catch (e) {
        emit(FeedErrorLoadingMore(
          posts: currentState.posts,
          currentPage: currentState.currentPage,
          hasReachedMax: currentState.hasReachedMax,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
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

