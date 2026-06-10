import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';
import 'visibility_badge.dart';

class CreationCard extends StatelessWidget {
  final String foldName;
  final String imagePath;
  final bool isPublic;
  final DateTime completedAt;
  final VoidCallback onTap;

  const CreationCard({
    super.key,
    required this.foldName,
    required this.imagePath,
    required this.isPublic,
    required this.completedAt,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Image.asset(
                    imagePath,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceMuted,
                      child: const Center(
                        child: Icon(
                          Icons.photo,
                          color: AppColors.textDisabled,
                          size: 40,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: AppSpacing.sm,
                    right: AppSpacing.sm,
                    child: VisibilityBadge(isPublic: isPublic),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    foldName,
                    style: AppTextStyles.cardTitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    '${completedAt.day}/${completedAt.month}/${completedAt.year}',
                    style: AppTextStyles.caption,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
