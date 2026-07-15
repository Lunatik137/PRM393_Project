import 'package:equatable/equatable.dart';

abstract class CommentEvent extends Equatable {
  const CommentEvent();
  @override
  List<Object?> get props => [];
}

class LoadComments extends CommentEvent {
  final String postId;
  const LoadComments(this.postId);
  @override
  List<Object?> get props => [postId];
}

class RefreshComments extends CommentEvent {
  final String postId;
  const RefreshComments(this.postId);
  @override
  List<Object?> get props => [postId];
}

class LoadMoreComments extends CommentEvent {
  final String postId;
  const LoadMoreComments(this.postId);
  @override
  List<Object?> get props => [postId];
}

class AddComment extends CommentEvent {
  final String postId;
  final String content;
  const AddComment({required this.postId, required this.content});
  @override
  List<Object?> get props => [postId, content];
}

class DeleteComment extends CommentEvent {
  final String commentId;
  const DeleteComment(this.commentId);
  @override
  List<Object?> get props => [commentId];
}
