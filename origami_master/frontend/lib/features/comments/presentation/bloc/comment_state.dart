import 'package:equatable/equatable.dart';
import '../../domain/entities/comment.dart';

abstract class CommentState extends Equatable {
  const CommentState();
  @override
  List<Object?> get props => [];
}

class CommentInitial extends CommentState {}

class CommentLoading extends CommentState {}

class CommentLoaded extends CommentState {
  final List<Comment> comments;
  final int currentPage;
  final bool hasReachedMax;

  const CommentLoaded({
    required this.comments,
    required this.currentPage,
    required this.hasReachedMax,
  });

  CommentLoaded copyWith({
    List<Comment>? comments,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return CommentLoaded(
      comments: comments ?? this.comments,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [comments, currentPage, hasReachedMax];
}

class CommentLoadingMore extends CommentLoaded {
  const CommentLoadingMore({
    required super.comments,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class CommentRefreshing extends CommentLoaded {
  const CommentRefreshing({
    required super.comments,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class CommentPosting extends CommentLoaded {
  const CommentPosting({
    required super.comments,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class CommentDeleting extends CommentLoaded {
  const CommentDeleting({
    required super.comments,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class CommentEmpty extends CommentState {}

class CommentError extends CommentState {
  final String message;
  const CommentError(this.message);
  @override
  List<Object?> get props => [message];
}

class CommentErrorLoadingMore extends CommentLoaded {
  final String message;
  const CommentErrorLoadingMore({
    required super.comments,
    required super.currentPage,
    required super.hasReachedMax,
    required this.message,
  });

  @override
  List<Object?> get props => [comments, currentPage, hasReachedMax, message];
}
