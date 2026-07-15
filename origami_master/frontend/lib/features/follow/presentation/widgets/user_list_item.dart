import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../domain/entities/follow_user.dart';
import 'follow_button.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/navigation/route_names.dart';

class UserListItem extends StatelessWidget {
  final FollowUser user;

  const UserListItem({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.pushNamed(
          RouteNames.userProfile,
          pathParameters: {'userId': user.id},
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              radius: AppSpacing.avatarMedium / 2,
              backgroundColor: AppColors.surfaceMuted,
              backgroundImage: (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                  ? (user.avatarUrl!.startsWith('http')
                      ? CachedNetworkImageProvider(user.avatarUrl!)
                      : AssetImage(user.avatarUrl!) as ImageProvider)
                  : null,
              child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                  ? const Icon(Icons.person, color: AppColors.textDisabled)
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(user.username, style: AppTextStyles.labelLarge),
                  if (user.bio != null && user.bio!.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      user.bio!,
                      style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            FollowButton(
              userId: user.id,
              initialIsFollowing: user.isFollowing,
              width: 100,
              height: 36,
            ),
          ],
        ),
      ),
    );
  }
}
