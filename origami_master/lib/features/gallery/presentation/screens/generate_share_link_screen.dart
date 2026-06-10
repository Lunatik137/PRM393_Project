import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/services/share_link_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../models/user_creation.dart';
import '../../../../models/share_link.dart';

class GenerateShareLinkScreen extends StatefulWidget {
  final String creationId;

  const GenerateShareLinkScreen({super.key, required this.creationId});

  @override
  State<GenerateShareLinkScreen> createState() =>
      _GenerateShareLinkScreenState();
}

class _GenerateShareLinkScreenState extends State<GenerateShareLinkScreen> {
  UserCreation? _creation;
  ShareLink? _generatedLink;
  bool _isLoading = true;
  bool _isGenerating = false;

  @override
  void initState() {
    super.initState();
    _loadCreation();
  }

  Future<void> _loadCreation() async {
    final creation = await CreationService.instance.getCreationById(
      widget.creationId,
    );
    if (mounted) {
      setState(() {
        _creation = creation;
        _isLoading = false;
      });
    }
  }

  Future<void> _handleGenerate() async {
    setState(() {
      _isGenerating = true;
    });

    // Simulate some delay
    await Future.delayed(const Duration(milliseconds: 500));

    final newLink = await ShareLinkService.instance.generateShareLink(
      widget.creationId,
    );

    if (mounted) {
      setState(() {
        _generatedLink = newLink;
        _isGenerating = false;
      });
    }
  }

  void _copyToClipboard() {
    if (_generatedLink == null) return;

    Clipboard.setData(ClipboardData(text: _generatedLink!.url));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_creation == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(title: const Text('Generate Share Link')),
        body: const Center(child: Text('Creation not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Generate Share Link',
          style: AppTextStyles.sectionTitle,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildPreview(),
              const SizedBox(height: AppSpacing.xl),
              _buildPrivacyNotice(),
              const SizedBox(height: AppSpacing.xxl),
              PrimaryButton(
                label: 'Generate Link',
                icon: Icons.link,
                onPressed: _isGenerating ? null : _handleGenerate,
                isLoading: _isGenerating,
              ),
              if (_generatedLink != null) ...[
                const SizedBox(height: AppSpacing.xl),
                _buildOutputField(),
              ],
              const SizedBox(height: AppSpacing.lg),
              SecondaryButton(
                label: 'Copy Link',
                icon: Icons.copy,
                onPressed: _generatedLink == null ? null : _copyToClipboard,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextButton(
                onPressed: () => context.pushNamed(
                  RouteNames.sharedLinks,
                  queryParameters: {
                    'source': RouteNames.generateShareLink,
                    'creationId': widget.creationId,
                  },
                ),
                child: const Text('View Shared Links'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: AppRadius.input,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: AppRadius.input,
            child: Image.asset(
              _creation!.imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: AppColors.surfaceMuted,
                child: const Icon(Icons.image, color: AppColors.textDisabled),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Creation Preview', style: AppTextStyles.caption),
                const SizedBox(height: 4),
                Text(
                  _creation!.foldName,
                  style: AppTextStyles.cardTitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyNotice() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: AppColors.infoBackground,
        borderRadius: AppRadius.input,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info_outline, color: AppColors.primary, size: 20),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Privacy Notice',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: AppSpacing.xs),
                Text(
                  'Anyone with this link will be able to view your creation, even if it is set to private.',
                  style: AppTextStyles.body,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOutputField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Generated Link', style: AppTextStyles.labelLarge),
        const SizedBox(height: AppSpacing.sm),
        TextFormField(
          key: const Key('generated-share-link-field'),
          initialValue: _generatedLink!.url,
          readOnly: true,
          style: AppTextStyles.body.copyWith(color: AppColors.textSecondary),
          decoration: const InputDecoration(
            filled: true,
            fillColor: AppColors.surface,
          ),
        ),
      ],
    );
  }
}
