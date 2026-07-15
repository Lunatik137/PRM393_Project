import 'package:flutter/material.dart';
import '../theme/app_radius.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class SharedLinkCard extends StatelessWidget {
  final String foldName;
  final String imagePath;
  final String url;
  final bool isActive;
  final DateTime createdAt;
  final VoidCallback? onTap;
  final VoidCallback? onCopy;
  final VoidCallback? onDelete;

  const SharedLinkCard({
    super.key,
    required this.foldName,
    this.imagePath = '',
    required this.url,
    required this.isActive,
    required this.createdAt,
    this.onTap,
    required this.onCopy,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: isActive ? onTap : null,
        borderRadius: AppRadius.card,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: AppRadius.input,
                    child: Image.asset(
                      imagePath,
                      width: 64,
                      height: 64,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 64,
                        height: 64,
                        color: AppColors.surfaceMuted,
                        child: const Icon(
                          Icons.image,
                          color: AppColors.textDisabled,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          foldName,
                          style: AppTextStyles.cardTitle,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: AppSpacing.xs),
                        Text(
                          'Created on ${createdAt.day}/${createdAt.month}/${createdAt.year}',
                          style: AppTextStyles.caption,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.successBackground
                          : AppColors.dangerBackground,
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      isActive ? 'Active' : 'Disabled',
                      style: AppTextStyles.caption.copyWith(
                        color: isActive ? AppColors.success : AppColors.danger,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                url,
                style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.primary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    icon: const Icon(Icons.copy, size: 20),
                    onPressed: isActive ? onCopy : null,
                    color: isActive
                        ? AppColors.primary
                        : AppColors.textDisabled,
                    tooltip: 'Copy Link',
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: onDelete,
                    color: onDelete == null
                        ? AppColors.textDisabled
                        : AppColors.danger,
                    tooltip: 'Delete Link',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
