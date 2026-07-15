import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_radius.dart';

class FeedPostCard extends StatelessWidget {
  final String creatorAvatarPath;
  final String creatorName;
  final bool isFollowing;
  final String creationImagePath;
  final String foldName;
  final int likesCount;
  final int commentsCount;
  final bool isLiked;
  final List<String>? hashtags;
  final VoidCallback? onFollowTapped;
  final VoidCallback? onLikeTapped;
  final VoidCallback? onCommentTapped;
  final VoidCallback? onShareTapped;
  final VoidCallback? onCardTapped;
  final VoidCallback? onCreatorTapped;

  const FeedPostCard({
    super.key,
    required this.creatorAvatarPath,
    required this.creatorName,
    this.isFollowing = false,
    required this.creationImagePath,
    required this.foldName,
    required this.likesCount,
    required this.commentsCount,
    this.isLiked = false,
    this.hashtags,
    this.onFollowTapped,
    this.onLikeTapped,
    this.onCommentTapped,
    this.onShareTapped,
    this.onCardTapped,
    this.onCreatorTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.sm,
      ),
      child: InkWell(
        onTap: onCardTapped,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: onCreatorTapped,
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
                      onTap: onCreatorTapped,
                      child: Text(
                        creatorName,
                        style: AppTextStyles.labelLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  if (onFollowTapped != null)
                    TextButton(
                      onPressed: onFollowTapped,
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                        ),
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        isFollowing ? 'Following' : 'Follow',
                        style: AppTextStyles.buttonSecondary.copyWith(
                          color: isFollowing
                              ? AppColors.textSecondary
                              : AppColors.primary,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            if (creationImagePath.isNotEmpty)
              AspectRatio(
                aspectRatio: 1.0,
                child: creationImagePath.startsWith('http')
                    ? CachedNetworkImage(
                        imageUrl: creationImagePath,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: AppColors.surfaceMuted,
                          child: const Center(child: CircularProgressIndicator()),
                        ),
                        errorWidget: (context, url, error) => Container(
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
                    : Image.asset(
                        creationImagePath,
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
                      ),
              ),

            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          foldName, // Note: we'll pass description to this in the caller
                          style: AppTextStyles.body,
                        ),
                      ),
                    ],
                  ),
                  if (hashtags != null && hashtags!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xs),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: hashtags!.map((tag) => Text(
                        tag,
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      )).toList(),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      _buildActionButton(
                        icon: isLiked ? Icons.favorite : Icons.favorite_border,
                        color: isLiked
                            ? AppColors.danger
                            : AppColors.textPrimary,
                        count: likesCount,
                        onTap: onLikeTapped,
                      ),
                      const SizedBox(width: AppSpacing.lg),
                      _buildActionButton(
                        icon: Icons.chat_bubble_outline,
                        color: AppColors.textPrimary,
                        count: commentsCount,
                        onTap: onCommentTapped,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required int count,
    VoidCallback? onTap,
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
