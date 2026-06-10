import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../models/origami_model.dart';
import '../../../../models/user_creation.dart';

class CompletionResultScreen extends StatefulWidget {
  final String creationId;

  const CompletionResultScreen({super.key, required this.creationId});

  @override
  State<CompletionResultScreen> createState() => _CompletionResultScreenState();
}

class _CompletionResultScreenState extends State<CompletionResultScreen> {
  late OrigamiModel _origami;
  bool _isPublic = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadOrigami();
  }

  void _loadOrigami() {
    String origamiId = '';
    if (widget.creationId.startsWith('new_creation_')) {
      origamiId = widget.creationId.replaceFirst('new_creation_', '');
    } else {
      // If it's an existing creation, we'd load it from service.
      // For this simplified logic, we'll try to find which origami it belongs to.
      // But based on user flow, we usually come here from a tutorial.
      origamiId = 'origami_crane'; // Fallback
    }

    _origami = MockData.origamiModels.firstWhere(
      (m) => m.id == origamiId,
      orElse: () => MockData.origamiModels.first,
    );
  }

  Future<UserCreation> _createCreationObject() async {
    return UserCreation(
      id: widget.creationId,
      origamiId: _origami.id,
      foldName: _origami.name,
      imagePath: _origami
          .imagePath, // In a real app, this would be a local file path of a photo
      creatorId: MockData.currentUserId,
      creatorNickname: MockData.currentUserProfile.name,
      creatorAvatarPath: MockData.currentUserProfile.avatarPath,
      completedAt: DateTime.now(),
      isPublic: _isPublic,
    );
  }

  Future<void> _handleSave() async {
    setState(() => _isSaving = true);
    final creation = await _createCreationObject();
    await CreationService.instance.saveCreation(creation);
    if (mounted) {
      context.goNamed(RouteNames.gallery);
    }
  }

  Future<void> _handleGenerateLink() async {
    setState(() => _isSaving = true);
    final creation = await _createCreationObject();
    await CreationService.instance.saveCreation(creation);
    if (mounted) {
      context.pushNamed(
        RouteNames.generateShareLink,
        pathParameters: {'creationId': widget.creationId},
      );
    }
    setState(() => _isSaving = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Icon(
                Icons.stars_rounded,
                color: AppColors.warning,
                size: 64,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Masterpiece Completed!',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Completed Fold Image
              ClipRRect(
                borderRadius: AppRadius.large,
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.asset(
                    _origami.imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceMuted,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: AppColors.textDisabled,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Completion Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      _buildSummaryRow('Model', _origami.name),
                      const Divider(height: AppSpacing.xl),
                      _buildSummaryRow('Category', _origami.category),
                      const Divider(height: AppSpacing.xl),
                      _buildSummaryRow('Date', 'Today'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Visibility Setting Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Publish to Community',
                            style: AppTextStyles.labelLarge,
                          ),
                          Switch(
                            value: _isPublic,
                            onChanged: (value) {
                              setState(() {
                                _isPublic = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _isPublic
                            ? 'Your creation will be visible in the Community Gallery for others to see.'
                            : 'This creation is private. Only you can see it in your Gallery, unless you share the link.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              PrimaryButton(
                label: 'Save Creation',
                onPressed: _isSaving ? null : _handleSave,
                isLoading: _isSaving,
              ),
              const SizedBox(height: AppSpacing.md),
              SecondaryButton(
                label: 'Generate Share Link',
                onPressed: _isSaving ? null : _handleGenerateLink,
              ),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.goNamed(RouteNames.home),
                child: const Text('Continue Journey'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.label),
      ],
    );
  }
}
