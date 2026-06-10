import 'package:flutter/material.dart';

import '../../../../core/services/creation_service.dart';
import '../../../../core/services/share_link_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../models/share_link.dart';
import '../../../../models/user_creation.dart';

class SharedCreationScreen extends StatefulWidget {
  final String token;

  const SharedCreationScreen({super.key, required this.token});

  @override
  State<SharedCreationScreen> createState() => _SharedCreationScreenState();
}

class _SharedCreationScreenState extends State<SharedCreationScreen> {
  ShareLink? _link;
  UserCreation? _creation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSharedCreation();
  }

  Future<void> _loadSharedCreation() async {
    final link = await ShareLinkService.instance.getShareLinkByToken(
      widget.token,
    );

    UserCreation? creation;
    if (link != null && link.isActive) {
      creation = await CreationService.instance.getCreationById(
        link.creationId,
      );
    }

    if (!mounted) return;

    setState(() {
      _link = link;
      _creation = creation;
      _isLoading = false;
    });
  }

  bool get _hasValidCreation => _link?.isActive == true && _creation != null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _hasValidCreation
            ? _buildValidContent(_creation!)
            : _buildUnavailableState(),
      ),
    );
  }

  Widget _buildValidContent(UserCreation creation) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        const Text('Origami Master', style: AppTextStyles.pageTitle),
        const SizedBox(height: AppSpacing.lg),
        Container(
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: AppColors.infoBackground,
            borderRadius: AppRadius.input,
            border: Border.all(color: AppColors.border),
          ),
          child: const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.visibility_outlined, color: AppColors.primary),
              SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  'Read-only shared creation. Editing is not available from this link.',
                  style: AppTextStyles.body,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        ClipRRect(
          borderRadius: AppRadius.card,
          child: Image.asset(
            creation.imagePath,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Container(
              height: 260,
              color: AppColors.surfaceMuted,
              child: const Icon(
                Icons.image,
                color: AppColors.textDisabled,
                size: 56,
              ),
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text(creation.foldName, style: AppTextStyles.pageTitle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          'Created by ${creation.creatorNickname}',
          style: AppTextStyles.bodyLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          'Completed on ${_formatDate(creation.completedAt)}',
          style: AppTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildUnavailableState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.link_off, size: 72, color: AppColors.textDisabled),
            const SizedBox(height: AppSpacing.lg),
            const Text(
              'Link Expired / Not Found',
              style: AppTextStyles.sectionTitle,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This shared link is unavailable.',
              style: AppTextStyles.body.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
