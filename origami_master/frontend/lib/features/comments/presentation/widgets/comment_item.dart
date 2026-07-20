import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/comment.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentItem extends StatelessWidget {
  final Comment comment;
  final VoidCallback? onDelete;

  const CommentItem({super.key, required this.comment, this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: AppSpacing.avatarSmall / 2,
          backgroundColor: AppColors.surfaceMuted,
          backgroundImage: (comment.authorAvatar != null && comment.authorAvatar!.isNotEmpty)
              ? (comment.authorAvatar!.startsWith('http')
                  ? CachedNetworkImageProvider(comment.authorAvatar!)
                  : AssetImage(comment.authorAvatar!) as ImageProvider)
              : null,
          child: (comment.authorAvatar == null || comment.authorAvatar!.isEmpty)
              ? const Icon(
                  Icons.person,
                  size: 16,
                  color: AppColors.textDisabled,
                )
              : null,
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    comment.authorName,
                    style: AppTextStyles.labelLarge,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    timeago.format(comment.createdAt, locale: 'en_short'),
                    style: AppTextStyles.caption.copyWith(color: AppColors.textDisabled),
                  ),
                  if (comment.isOwner && onDelete != null) ...[
                    const Spacer(),
                    GestureDetector(
                      onTap: onDelete,
                      child: const Icon(Icons.delete_outline, size: 16, color: AppColors.danger),
                    ),
                  ],
                ],
              ),
              if (comment.content.trim().isNotEmpty) ...[
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  comment.content,
                  style: AppTextStyles.body,
                ),
              ],
              if (comment.localImagePath != null) ...[
                const SizedBox(height: AppSpacing.sm),
                ClipRRect(
                  borderRadius: BorderRadius.circular(AppSpacing.sm),
                  child: Image.file(
                    File(comment.localImagePath!),
                    height: 150,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
