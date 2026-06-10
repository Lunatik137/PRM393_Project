import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_radius.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class VisibilityBadge extends StatelessWidget {
  final bool isPublic;

  const VisibilityBadge({super.key, required this.isPublic});

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isPublic
        ? AppColors.publicBadgeBackground
        : AppColors.privateBadgeBackground;
    final foregroundColor = isPublic
        ? AppColors.publicBadgeForeground
        : AppColors.privateBadgeForeground;
    final text = isPublic ? 'Public' : 'Private';
    final icon = isPublic ? Icons.public : Icons.lock;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: AppRadius.badge,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: foregroundColor),
          const SizedBox(width: AppSpacing.xs),
          Text(
            text,
            style: AppTextStyles.caption.copyWith(
              color: foregroundColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
