import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/info_card.dart';
import '../../../../core/widgets/profile_menu_button.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../models/user_creation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<UserCreation> _creations = const [];
  bool _isLoading = true;
  bool _isLoggingOut = false;

  @override
  void initState() {
    super.initState();
    _loadStats();
  }

  Future<void> _loadStats() async {
    final creations = await CreationService.instance.getCreations();

    if (!mounted) return;

    setState(() {
      _creations = creations
          .where((creation) => creation.creatorId == MockData.currentUserId)
          .toList(growable: false);
      _isLoading = false;
    });
  }

  int get _completedFoldsCount => _creations.length;

  int get _publicCreationsCount =>
      _creations.where((creation) => creation.isPublic).length;

  Future<void> _showSettings() async {
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

  Future<void> _confirmLogout() async {
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

    if (confirmed != true) return;

    setState(() {
      _isLoggingOut = true;
    });

    await AuthService.instance.logout();

    if (!mounted) return;

    context.goNamed(RouteNames.login);
  }

  @override
  Widget build(BuildContext context) {
    final profile = MockData.currentUserProfile;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                children: [
                  Center(
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.surfaceMuted,
                          backgroundImage: AssetImage(profile.avatarPath),
                          onBackgroundImageError: (_, _) {},
                          child: const Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(profile.name, style: AppTextStyles.pageTitle),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: 'Completed Folds',
                          value: '$_completedFoldsCount',
                          icon: Icons.check_circle_outline,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: InfoCard(
                          title: 'Public Creations',
                          value: '$_publicCreationsCount',
                          icon: Icons.public,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xxl),
                  Card(
                    color: AppColors.surfaceWhite,
                    shape: const RoundedRectangleBorder(
                      borderRadius: AppRadius.card,
                    ),
                    child: Column(
                      children: [
                        ProfileMenuButton(
                          label: 'My Shared Links',
                          icon: Icons.link,
                          onTap: () => context.pushNamed(
                            RouteNames.sharedLinks,
                            queryParameters: {'source': RouteNames.profile},
                          ),
                        ),
                        const Divider(height: 1),
                        ProfileMenuButton(
                          label: 'Settings',
                          icon: Icons.settings_outlined,
                          onTap: _showSettings,
                        ),
                        const Divider(height: 1),
                        ProfileMenuButton(
                          label: _isLoggingOut ? 'Logging out...' : 'Logout',
                          icon: Icons.logout,
                          onTap: _isLoggingOut ? () {} : _confirmLogout,
                          isDestructive: true,
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
