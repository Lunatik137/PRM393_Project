import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/visibility_badge.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../models/user_creation.dart';

class CreationDetailScreen extends StatefulWidget {
  final String creationId;
  final String? source;

  const CreationDetailScreen({
    super.key,
    required this.creationId,
    this.source,
  });

  @override
  State<CreationDetailScreen> createState() => _CreationDetailScreenState();
}

class _CreationDetailScreenState extends State<CreationDetailScreen> {
  UserCreation? _creation;
  bool _isLoading = true;

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

  bool get _isOwner => _creation?.creatorId == MockData.currentUserId;

  Future<void> _toggleVisibility() async {
    if (_creation == null) return;
    final newVisibility = !_creation!.isPublic;
    await CreationService.instance.updateVisibility(
      _creation!.id,
      newVisibility,
    );
    await _loadCreation();
  }

  Future<void> _confirmDelete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Creation'),
        content: const Text(
          'Are you sure you want to delete this creation? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      await CreationService.instance.deleteCreation(_creation!.id);
      if (mounted) {
        if (widget.source != null) {
          context.go(widget.source!);
        } else {
          context.pop();
        }
      }
    }
  }

  void _onBack() {
    if (widget.source != null) {
      context.go(widget.source!);
    } else {
      context.pop();
    }
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
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: _onBack,
          ),
        ),
        body: const Center(child: Text('Creation not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverSafeArea(
            top: false,
            sliver: SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCreatorInfo(),
                    const SizedBox(height: AppSpacing.lg),
                    _buildDescription(),
                    if (_isOwner) ...[
                      const SizedBox(height: AppSpacing.xxl),
                      _buildOwnerActions(),
                    ],
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: AppColors.overlay,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: _onBack,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              _creation!.imagePath,
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
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              child: VisibilityBadge(isPublic: _creation!.isPublic),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorInfo() {
    final dateStr =
        '${_creation!.completedAt.day}/${_creation!.completedAt.month}/${_creation!.completedAt.year}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_creation!.foldName, style: AppTextStyles.pageTitle),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(_creation!.creatorAvatarPath),
              backgroundColor: AppColors.surfaceMuted,
              child: _creation!.creatorAvatarPath.isEmpty
                  ? const Icon(Icons.person, size: 20)
                  : null,
            ),
            const SizedBox(width: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _creation!.creatorNickname,
                  style: AppTextStyles.labelLarge,
                ),
                Text('Completed on $dateStr', style: AppTextStyles.caption),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Note', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.sm),
        Text(
          _creation!.description ?? 'No description provided.',
          style: AppTextStyles.body,
        ),
      ],
    );
  }

  Widget _buildOwnerActions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 0,
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            side: const BorderSide(color: AppColors.border),
          ),
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.edit_outlined),
                title: const Text('Edit Details'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Edit feature coming soon')),
                  );
                },
              ),
              const Divider(height: 1, indent: AppSpacing.xl),
              ListTile(
                leading: Icon(
                  _creation!.isPublic ? Icons.lock_outline : Icons.public,
                ),
                title: Text(
                  _creation!.isPublic ? 'Make Private' : 'Make Public',
                ),
                trailing: const Icon(Icons.chevron_right),
                onTap: _toggleVisibility,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        PrimaryButton(
          label: 'Share Creation',
          onPressed: () => context.pushNamed(
            RouteNames.generateShareLink,
            pathParameters: {'creationId': _creation!.id},
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: _confirmDelete,
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: const Text('Delete Creation'),
        ),
      ],
    );
  }
}
