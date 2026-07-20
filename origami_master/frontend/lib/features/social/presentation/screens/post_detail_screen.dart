import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../features/home/domain/entities/feed_post.dart';
import '../../../../features/home/data/dto/feed_response_dto.dart';
import '../../../../models/post_comment.dart';
import '../../../../features/home/data/mapper/feed_mapper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';
import '../../../../features/home/data/api/feed_api.dart';
import '../../../../core/di/injection.dart';

import '../../../../features/comments/data/api/comment_api.dart';

class PostDetailScreen extends StatefulWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  State<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends State<PostDetailScreen> {
  FeedPost? _post;
  List<PostComment>? _comments;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final feedApi = getIt<FeedApi>();
      final itemResponse = await feedApi.getPost(widget.postId);
      final dto = FeedResponseDto.fromJson(itemResponse);
      final post = FeedMapper.mapToEntity(dto);

      final commentApi = getIt<CommentApi>();
      final commentsResponse = await commentApi.getComments(widget.postId, page: 1, pageSize: 2);
      final comments = commentsResponse.items.map((c) => PostComment(
        id: c.id,
        postId: c.postId,
        userId: c.authorName ?? 'Unknown',
        content: c.content ?? '',
        createdAt: c.createdAt,
      )).toList();

      if (mounted) {
        setState(() {
          _post = post;
          _comments = comments;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load post')),
        );
      }
    }
  }

  Future<void> _deletePost() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Post'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        final feedApi = getIt<FeedApi>();
        await feedApi.deletePost(widget.postId);
        if (mounted) {
          context.pop(true);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to delete post')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        appBar: AppHeader(title: 'Post'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_post == null) {
      return const Scaffold(
        appBar: AppHeader(title: 'Post'),
        body: Center(child: Text('Post not found.')),
      );
    }

    final creatorNickname = _post!.creatorName;
    final creatorAvatarPath = _post!.creatorAvatar ?? '';
    final imagePath = _post!.imageUrl ?? '';

    final authState = context.read<AuthBloc>().state;
    final bool isCreator = (authState is Authenticated) && (authState.session.user.id == _post!.creatorId);

    return Scaffold(
      appBar: AppHeader(
        title: 'Post',
        actions: isCreator
            ? [
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') {
                      context.pushNamed(
                        RouteNames.editPost,
                        pathParameters: {'postId': _post!.id},
                      ).then((value) {
                        if (value == true) {
                          _loadData();
                        }
                      });
                    } else if (value == 'delete') {
                      _deletePost();
                    }
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete', style: TextStyle(color: AppColors.danger)),
                    ),
                  ],
                ),
              ]
            : null,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: AppSpacing.xxl),
          children: [
            // Creator Info
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      RouteNames.userProfile,
                      pathParameters: {'userId': _post!.creatorId},
                    ),
                    child: CircleAvatar(
                      radius: AppSpacing.avatarSmall / 2,
                      backgroundColor: AppColors.surfaceMuted,
                      backgroundImage: creatorAvatarPath.isNotEmpty 
                          ? (creatorAvatarPath.startsWith('http') 
                              ? CachedNetworkImageProvider(creatorAvatarPath) 
                              : AssetImage(creatorAvatarPath)) as ImageProvider
                          : null,
                      onBackgroundImageError: creatorAvatarPath.isNotEmpty ? (exception, stackTrace) {} : null,
                      child: creatorAvatarPath.isEmpty
                          ? const Icon(
                              Icons.person,
                              color: AppColors.textDisabled,
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => context.pushNamed(
                        RouteNames.userProfile,
                        pathParameters: {'userId': _post!.creatorId},
                      ),
                      child: Text(
                        creatorNickname,
                        style: AppTextStyles.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),

                ],
              ),
            ),

            // Image
            AspectRatio(
              aspectRatio: 1.0,
              child: imagePath.isNotEmpty
                  ? Image.network(
                      imagePath,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: AppColors.surfaceMuted,
                        child: const Center(
                          child: Icon(
                            Icons.image_not_supported,
                            color: AppColors.textDisabled,
                            size: 48,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      color: AppColors.surfaceMuted,
                      child: const Center(
                        child: Icon(
                          Icons.image,
                          color: AppColors.textDisabled,
                          size: 48,
                        ),
                      ),
                    ),
            ),

            // Post Details
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(_post!.description, style: AppTextStyles.body),
                  if (_post!.hashtags.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.sm),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: _post!.hashtags.map((tag) => Text(
                        tag,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      )).toList(),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),

                  // Actions
                  Row(
                    children: [
                      _buildActionButton(
                        icon: _post!.isLiked
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: _post!.isLiked
                            ? AppColors.danger
                            : AppColors.textPrimary,
                        count: _post!.likeCount,
                        onTap: () {},
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      _buildActionButton(
                        icon: Icons.chat_bubble_outline,
                        color: AppColors.textPrimary,
                        count: _post!.commentCount,
                        onTap: _navigateToComments,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(color: AppColors.divider),

            // Comment Preview
            if (_comments != null && _comments!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Comments', style: AppTextStyles.sectionTitle),
                    const SizedBox(height: AppSpacing.md),
                    ..._comments!
                        .take(2)
                        .map(
                          (comment) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: AppSpacing.md,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CircleAvatar(
                                  radius: 16,
                                  backgroundColor: AppColors.surfaceMuted,
                                  child: Icon(
                                    Icons.person,
                                    size: 16,
                                    color: AppColors.textDisabled,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.sm),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comment.userId,
                                        style: AppTextStyles.label,
                                      ),
                                      const SizedBox(height: AppSpacing.xxs),
                                      Text(
                                        comment.content,
                                        style: AppTextStyles.body,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                    if (_comments!.length > 2)
                      TextButton(
                        onPressed: _navigateToComments,
                        child: Text(
                          'View all ${_post!.commentCount} comments',
                          style: AppTextStyles.buttonSecondary,
                        ),
                      ),
                  ],
                ),
              )
            else
              const Padding(
                padding: EdgeInsets.all(AppSpacing.lg),
                child: Center(
                  child: Text('No comments yet.', style: AppTextStyles.body),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _navigateToComments() {
    context.pushNamed(
      RouteNames.comments,
      pathParameters: {'postId': widget.postId},
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required int count,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.button,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.xs,
          horizontal: AppSpacing.xxs,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: AppSpacing.iconMedium),
            const SizedBox(width: AppSpacing.xs),
            Text(
              count.toString(),
              style: AppTextStyles.labelLarge.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
