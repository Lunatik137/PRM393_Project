import 'package:flutter/material.dart';
import '../../domain/entities/gallery_item.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/visibility_badge.dart';

class GalleryCard extends StatelessWidget {
  final GalleryItem item;
  final VoidCallback onTap;
  final bool showCreatorName;
  final bool isPost;

  const GalleryCard({
    super.key,
    required this.item,
    required this.onTap,
    this.showCreatorName = false,
    this.isPost = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.md),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: item.imageUrl.isNotEmpty
                      ? Image.network(
                          item.imageUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: AppColors.surfaceMuted,
                              child: const Icon(Icons.image, color: AppColors.textDisabled, size: 40),
                            );
                          },
                        )
                      : Container(
                          color: AppColors.surfaceMuted,
                          child: const Icon(Icons.image, color: AppColors.textDisabled, size: 40),
                        ),
                ),
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        showCreatorName
                            ? item.creatorName
                            : (item.caption ?? item.origamiModelName ?? 'Creation'),
                        style: AppTextStyles.labelLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (item.hashtags != null && item.hashtags!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          item.hashtags!.take(3).join(' '),
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.primary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (item.createdAt != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          '${item.createdAt!.day}/${item.createdAt!.month}/${item.createdAt!.year}',
                          style: AppTextStyles.caption.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            if (!isPost)
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: VisibilityBadge(isPublished: item.visibility == 'Public'),
              ),
          ],
        ),
      ),
    );
  }
}
