import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'comment_event.dart';
import 'comment_state.dart';
import '../../domain/usecases/get_comments.dart';
import '../../domain/usecases/add_comment.dart';
import '../../domain/usecases/delete_comment.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../domain/entities/comment.dart';

const int _pageSize = 20;

@injectable
class CommentBloc extends Bloc<CommentEvent, CommentState> {
  final GetCommentsUseCase _getComments;
  final AddCommentUseCase _addComment;
  final DeleteCommentUseCase _deleteComment;

  CommentBloc(
    this._getComments,
    this._addComment,
    this._deleteComment,
  ) : super(CommentInitial()) {
    on<LoadComments>(_onLoadComments);
    on<RefreshComments>(_onRefreshComments);
    on<LoadMoreComments>(_onLoadMoreComments);
    on<AddComment>(_onAddComment);
    on<DeleteComment>(_onDeleteComment);
  }

  List<Comment> _mergeLocalImages(List<Comment> oldComments, List<Comment> newComments) {
    Map<String, String> localImages = {};
    for (final c in oldComments) {
      if (c.localImagePath != null && c.isOwner) {
        localImages[c.content] = c.localImagePath!;
      }
    }
    return newComments.map((c) {
      if (c.isOwner && localImages.containsKey(c.content)) {
        return c.copyWith(localImagePath: localImages[c.content]);
      }
      return c;
    }).toList();
  }

  Future<void> _onLoadComments(LoadComments event, Emitter<CommentState> emit) async {
    emit(CommentLoading());
    try {
      final pagination = await _getComments(event.postId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(CommentEmpty());
      } else {
        emit(CommentLoaded(
          comments: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(CommentError(e.message));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> _onRefreshComments(RefreshComments event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      emit(CommentRefreshing(
        comments: currentState.comments,
        currentPage: currentState.currentPage,
        hasReachedMax: currentState.hasReachedMax,
      ));
    } else {
      emit(CommentLoading());
    }

    try {
      final pagination = await _getComments(event.postId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(CommentEmpty());
      } else {
        final mergedComments = _mergeLocalImages(
          (state is CommentLoaded) ? (state as CommentLoaded).comments : [],
          pagination.items,
        );
        emit(CommentLoaded(
          comments: mergedComments,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(CommentError(e.message));
    } catch (e) {
      emit(CommentError(e.toString()));
    }
  }

  Future<void> _onLoadMoreComments(LoadMoreComments event, Emitter<CommentState> emit) async {
    if (state is CommentLoadingMore || state is CommentRefreshing || state is CommentErrorLoadingMore) {
      if (state is! CommentErrorLoadingMore) return;
    }
    
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      if (currentState.hasReachedMax) return;

      final nextPage = currentState.currentPage + 1;
      emit(CommentLoadingMore(
        comments: currentState.comments,
        currentPage: currentState.currentPage,
        hasReachedMax: currentState.hasReachedMax,
      ));

      try {
        final pagination = await _getComments(event.postId, nextPage, _pageSize);
        final mergedComments = _mergeLocalImages(currentState.comments, pagination.items);
        emit(CommentLoaded(
          comments: List.of(currentState.comments)..addAll(mergedComments),
          currentPage: nextPage,
          hasReachedMax: !pagination.hasMore,
        ));
      } catch (e) {
        emit(CommentErrorLoadingMore(
          comments: currentState.comments,
          currentPage: currentState.currentPage,
          hasReachedMax: currentState.hasReachedMax,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
    }
  }

  Future<void> _onAddComment(AddComment event, Emitter<CommentState> emit) async {
    List<Comment> currentComments = [];
    int currentPg = 1;
    bool reachedMax = true;

    if (state is CommentLoaded) {
      final st = state as CommentLoaded;
      currentComments = st.comments;
      currentPg = st.currentPage;
      reachedMax = st.hasReachedMax;
    } else if (state is CommentEmpty) {
      currentComments = [];
      currentPg = 1;
      reachedMax = true;
    }

    final newComment = Comment(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      postId: event.postId,
      authorId: 'me',
      authorName: 'You', 
      authorAvatar: null,
      content: event.content,
      createdAt: DateTime.now(),
      isOwner: true,
      localImagePath: event.localImagePath,
    );

    emit(CommentLoaded(
      comments: [newComment, ...currentComments],
      currentPage: currentPg,
      hasReachedMax: reachedMax,
    ));

    if (event.content.trim().isNotEmpty) {
      try {
        await _addComment(event.postId, event.content);
      } catch (_) {}
    }
  }

  Future<void> _onDeleteComment(DeleteComment event, Emitter<CommentState> emit) async {
    if (state is CommentLoaded) {
      final currentState = state as CommentLoaded;
      
      Comment? targetComment;
      int? targetIndex;
      for (int i = 0; i < currentState.comments.length; i++) {
        if (currentState.comments[i].id == event.commentId) {
          targetComment = currentState.comments[i];
          targetIndex = i;
          break;
        }
      }

      if (targetComment == null || targetIndex == null) return;
      
      final optimisticComments = List<Comment>.from(currentState.comments)..removeAt(targetIndex);

      emit(CommentDeleting(
        comments: optimisticComments,
        currentPage: currentState.currentPage,
        hasReachedMax: currentState.hasReachedMax,
      ));

      try {
        await _deleteComment(event.commentId);
        
        if (optimisticComments.isEmpty) {
          emit(CommentEmpty());
        } else {
          emit(CommentLoaded(
            comments: optimisticComments,
            currentPage: currentState.currentPage,
            hasReachedMax: currentState.hasReachedMax,
          ));
        }
      } catch (_) {
        final revertedComments = List<Comment>.from(optimisticComments);
        revertedComments.insert(targetIndex, targetComment);
        emit(CommentLoaded(
          comments: revertedComments,
          currentPage: currentState.currentPage,
          hasReachedMax: currentState.hasReachedMax,
        ));
      }
    }
  }
}

