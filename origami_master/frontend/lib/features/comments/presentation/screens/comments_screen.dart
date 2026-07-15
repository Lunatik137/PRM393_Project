import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_header.dart';
import '../../../../../core/di/injection.dart';
import '../bloc/comment_bloc.dart';
import '../bloc/comment_event.dart';
import '../bloc/comment_state.dart';
import '../widgets/comment_item.dart';
import '../widgets/comment_input.dart';

class CommentsScreen extends StatelessWidget {
  final String postId;

  const CommentsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<CommentBloc>()..add(LoadComments(postId)),
      child: CommentsView(postId: postId),
    );
  }
}

class CommentsView extends StatefulWidget {
  final String postId;

  const CommentsView({super.key, required this.postId});

  @override
  State<CommentsView> createState() => _CommentsViewState();
}

class _CommentsViewState extends State<CommentsView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<CommentBloc>().add(LoadMoreComments(widget.postId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onRefresh() async {
    context.read<CommentBloc>().add(RefreshComments(widget.postId));
  }

  void _deleteComment(BuildContext context, String commentId) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Comment'),
          content: const Text('Are you sure you want to delete this comment?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
                context.read<CommentBloc>().add(DeleteComment(commentId));
              },
              child: const Text('Delete', style: TextStyle(color: AppColors.danger)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Comments'),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocConsumer<CommentBloc, CommentState>(
                listener: (context, state) {
                  if (state is CommentErrorLoadingMore) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to load more: ${state.message}')),
                    );
                  } else if (state is CommentError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error: ${state.message}')),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CommentInitial || state is CommentLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CommentError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(state.message),
                          const SizedBox(height: AppSpacing.md),
                          ElevatedButton(
                            onPressed: () => context.read<CommentBloc>().add(LoadComments(widget.postId)),
                            child: const Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CommentEmpty) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: const CustomScrollView(
                        slivers: [
                          SliverFillRemaining(
                            child: Center(
                              child: Text(
                                'Be the first to comment on this creation.',
                                style: AppTextStyles.body,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else if (state is CommentLoaded) {
                    return RefreshIndicator(
                      onRefresh: _onRefresh,
                      child: ListView.separated(
                        controller: _scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        itemCount: state.hasReachedMax ? state.comments.length : state.comments.length + 1,
                        separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.lg),
                        itemBuilder: (context, index) {
                          if (index >= state.comments.length) {
                            return const Center(
                              child: Padding(
                                padding: EdgeInsets.all(AppSpacing.md),
                                child: CircularProgressIndicator(),
                              ),
                            );
                          }

                          final comment = state.comments[index];
                          return CommentItem(
                            comment: comment,
                            onDelete: comment.isOwner ? () => _deleteComment(context, comment.id) : null,
                          );
                        },
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
            BlocBuilder<CommentBloc, CommentState>(
              builder: (context, state) {
                final isSending = state is CommentPosting;
                return CommentInput(
                  isSending: isSending,
                  onSend: (content) {
                    context.read<CommentBloc>().add(AddComment(
                      postId: widget.postId,
                      content: content,
                    ));
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
