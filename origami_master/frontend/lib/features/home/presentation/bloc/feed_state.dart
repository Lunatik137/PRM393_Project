import 'package:equatable/equatable.dart';
import '../../domain/entities/feed_post.dart';

abstract class FeedState extends Equatable {
  const FeedState();
  @override
  List<Object?> get props => [];
}

class FeedInitial extends FeedState {}

class FeedLoading extends FeedState {}

class FeedLoaded extends FeedState {
  final List<FeedPost> posts;
  final int currentPage;
  final bool hasReachedMax;

  const FeedLoaded({
    required this.posts,
    required this.currentPage,
    required this.hasReachedMax,
  });

  FeedLoaded copyWith({
    List<FeedPost>? posts,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return FeedLoaded(
      posts: posts ?? this.posts,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [posts, currentPage, hasReachedMax];
}

class FeedLoadingMore extends FeedLoaded {
  const FeedLoadingMore({
    required super.posts,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class FeedRefreshing extends FeedLoaded {
  const FeedRefreshing({
    required super.posts,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class FeedEmpty extends FeedState {}

class FeedError extends FeedState {
  final String message;
  const FeedError(this.message);
  @override
  List<Object?> get props => [message];
}

class FeedErrorLoadingMore extends FeedLoaded {
  final String message;
  const FeedErrorLoadingMore({
    required super.posts,
    required super.currentPage,
    required super.hasReachedMax,
    required this.message,
  });

  @override
  List<Object?> get props => [posts, currentPage, hasReachedMax, message];
}
