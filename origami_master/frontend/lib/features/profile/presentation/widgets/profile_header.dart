import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/navigation/route_names.dart';
import '../../domain/entities/profile.dart';
import 'profile_statistics.dart';
import '../../../follow/presentation/widgets/follow_button.dart';
import '../../../auth/presentation/bloc/auth_bloc.dart';
import '../../../auth/presentation/bloc/auth_event.dart';

class ProfileHeader extends StatelessWidget {
  final Profile profile;
  final bool isMyProfile;
  final bool isLoggingOut;

  const ProfileHeader({
    super.key,
    required this.profile,
    required this.isMyProfile,
    this.isLoggingOut = false,
  });

  Future<void> _showSettings(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Settings'),
        content: const Text('Settings are not available yet.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout?'),
        content: const Text('You will need to sign in again.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<AuthBloc>().add(LogoutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          CircleAvatar(
            radius: AppSpacing.avatarLarge / 2,
            backgroundColor: AppColors.surfaceMuted,
            backgroundImage: (profile.avatarUrl != null && profile.avatarUrl!.isNotEmpty)
                ? (profile.avatarUrl!.startsWith('http')
                    ? CachedNetworkImageProvider(profile.avatarUrl!)
                    : AssetImage(profile.avatarUrl!) as ImageProvider)
                : null,
            child: (profile.avatarUrl == null || profile.avatarUrl!.isEmpty)
                ? const Icon(Icons.person, size: 48, color: AppColors.textDisabled)
                : null,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(profile.displayName ?? profile.username, style: AppTextStyles.titleLarge),
          if (profile.displayName != null && profile.displayName!.isNotEmpty)
            Text('@${profile.username}', style: AppTextStyles.body.copyWith(color: AppColors.textSecondary)),
          if (profile.bio != null && profile.bio!.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(profile.bio!, textAlign: TextAlign.center, style: AppTextStyles.body),
          ],
          const SizedBox(height: AppSpacing.lg),
          ProfileStatisticsWidget(profile: profile),
          const SizedBox(height: AppSpacing.lg),
          if (isMyProfile)
            _buildMyProfileActions(context)
          else
            FollowButton(
              userId: profile.id,
              initialIsFollowing: profile.isFollowing,
            ),
        ],
      ),
    );
  }

  Widget _buildMyProfileActions(BuildContext context) {
    return Column(
      children: [
        _buildActionRow(
          icon: Icons.link,
          label: 'Shared Links',
          onTap: () {
            context.pushNamed(RouteNames.sharedLinks, queryParameters: {'source': RouteNames.profile});
          },
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildActionRow(
          icon: Icons.settings,
          label: 'Settings',
          onTap: () => _showSettings(context),
        ),
        const SizedBox(height: AppSpacing.sm),
        _buildActionRow(
          icon: Icons.logout,
          label: isLoggingOut ? 'Logging out...' : 'Logout',
          isDestructive: true,
          onTap: isLoggingOut ? null : () => _confirmLogout(context),
        ),
      ],
    );
  }

  Widget _buildActionRow({
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isDestructive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.button,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: AppRadius.button,
        ),
        child: Row(
          children: [
            Icon(icon, color: isDestructive ? AppColors.danger : AppColors.textPrimary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.button.copyWith(color: isDestructive ? AppColors.danger : AppColors.textPrimary),
              ),
            ),
            Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}
