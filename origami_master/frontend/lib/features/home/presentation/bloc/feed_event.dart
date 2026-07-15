import 'package:equatable/equatable.dart';

abstract class FeedEvent extends Equatable {
  const FeedEvent();
  @override
  List<Object?> get props => [];
}

class LoadFeed extends FeedEvent {}

class RefreshFeed extends FeedEvent {}

class LoadMoreFeed extends FeedEvent {}

class LikePost extends FeedEvent {
  final String postId;
  const LikePost(this.postId);
  @override
  List<Object?> get props => [postId];
}

class UnlikePost extends FeedEvent {
  final String postId;
  const UnlikePost(this.postId);
  @override
  List<Object?> get props => [postId];
}
