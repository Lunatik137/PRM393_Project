import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../models/origami_model.dart';
import '../../../../core/repositories/origami_repository.dart';
import '../../../gallery/data/api/gallery_api.dart';
import '../../../gallery/data/dto/gallery_response_dto.dart';

class FoldDetailScreen extends StatefulWidget {
  final String origamiId;

  const FoldDetailScreen({super.key, required this.origamiId});

  @override
  State<FoldDetailScreen> createState() => _FoldDetailScreenState();
}

class _FoldDetailScreenState extends State<FoldDetailScreen> {
  OrigamiModel? _origami;
  bool _isLoading = true;
  String? _error;
  List<GalleryResponseDto> _communityPosts = [];
  bool _communityLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchOrigami();
    _fetchCommunityPosts();
  }

  Future<void> _fetchOrigami() async {
    try {
      final repo = getIt<OrigamiRepository>();
      final model = await repo.getOrigamiById(widget.origamiId);
      if (mounted) {
        setState(() {
          _origami = model;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _error = e.toString();
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _fetchCommunityPosts() async {
    setState(() => _communityLoading = true);
    try {
      final api = getIt<GalleryApi>();
      final pagination = await api.getPublicGallery(
        origamiModelId: widget.origamiId,
        pageNumber: 1,
        pageSize: 6,
      );
      if (mounted) {
        setState(() {
          _communityPosts = pagination.items;
          _communityLoading = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _communityLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_error != null || _origami == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(child: Text(_error ?? 'Failed to load model')),
      );
    }

    final origami = _origami!;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(context, origami),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeaderInfo(origami),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildSectionTitle('Description'),
                  const SizedBox(height: AppSpacing.md),
                  Text(origami.description, style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildSectionTitle('Materials Needed'),
                  const SizedBox(height: AppSpacing.md),
                  _buildMaterialsList(origami.materials),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildCommunityGallerySection(context),
                  const SizedBox(height: 80), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: const BoxDecoration(
          color: AppColors.background,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: SafeArea(
          child: PrimaryButton(
            label: 'Start Learning',
            onPressed: () => context.pushNamed(
              RouteNames.learningStep,
              pathParameters: {'origamiId': widget.origamiId},
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context, OrigamiModel origami) {
    return SliverAppBar(
      expandedHeight: 300,
      pinned: true,
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: AppColors.overlay,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: origami.imagePath.startsWith('http')
            ? Image.network(
                origami.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: AppColors.surfaceMuted,
                  child: const Icon(
                    Icons.image,
                    size: 100,
                    color: AppColors.textDisabled,
                  ),
                ),
              )
            : Image.asset(
                origami.imagePath,
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
    );
  }

  Widget _buildHeaderInfo(OrigamiModel origami) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: Text(origami.name, style: AppTextStyles.pageTitle)),
            _DifficultyBadge(difficulty: origami.difficulty),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            const Icon(
              Icons.category_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(origami.category, style: AppTextStyles.bodySmall),
            const SizedBox(width: AppSpacing.md),
            const Icon(
              Icons.timer_outlined,
              size: 16,
              color: AppColors.textSecondary,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              '${origami.estimatedMinutes} mins',
              style: AppTextStyles.bodySmall,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: AppTextStyles.sectionTitle);
  }

  Widget _buildMaterialsList(List<String> materials) {
    if (materials.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceWhite,
          borderRadius: AppRadius.medium,
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.check_box_outline_blank, size: 18, color: AppColors.primary),
            const SizedBox(width: AppSpacing.sm),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Square Paper', style: AppTextStyles.bodySmall),
                Text(
                  '15x15cm standard',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: materials.map((material) => _buildMaterialChip(material)).toList(),
    );
  }

  Widget _buildMaterialChip(String material) {
    // Parse: optional "Nx " prefix, name, optional size like "15x15cm"
    String displayName = material.trim();
    String sizeHint = '';

    final sizeMatch = RegExp(r'(\d+\s*[xX×]\s*\d+\s*cm)', caseSensitive: false).firstMatch(material);
    if (sizeMatch != null) {
      sizeHint = sizeMatch.group(0)!.trim();
      displayName = material.replaceAll(sizeMatch.group(0)!, '').trim();
      // Remove trailing/leading qty like "1x"
      displayName = displayName.replaceAll(RegExp(r'^\d+x\s*'), '').trim();
    } else if (material.toLowerCase().contains('square paper') ||
        material.toLowerCase().contains('origami paper')) {
      sizeHint = '15x15cm standard';
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.surfaceWhite,
        borderRadius: AppRadius.medium,
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.check_box_outline_blank, size: 18, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(displayName, style: AppTextStyles.bodySmall),
              if (sizeHint.isNotEmpty)
                Text(
                  sizeHint,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityGallerySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Community Gallery', style: AppTextStyles.sectionTitle),
            TextButton(
              onPressed: () => context.pushNamed(
                RouteNames.communityGallery,
                pathParameters: {'origamiId': widget.origamiId},
              ),
              child: Text(
                'VIEW ALL',
                style: AppTextStyles.caption.copyWith(color: AppColors.primary),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        if (_communityLoading)
          const SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          )
        else if (_communityPosts.isEmpty)
          Container(
            height: 160,
            decoration: BoxDecoration(
              color: AppColors.surfaceMuted,
              borderRadius: AppRadius.medium,
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.photo_library_outlined, size: 40, color: AppColors.textDisabled),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Be the first to share!',
                    style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            height: 180,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: _communityPosts.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
              itemBuilder: (context, index) {
                final post = _communityPosts[index];
                return _buildCommunityPostCard(context, post);
              },
            ),
          ),
      ],
    );
  }

  Widget _buildCommunityPostCard(BuildContext context, GalleryResponseDto post) {
    return SizedBox(
      width: 140,
      child: GestureDetector(
        onTap: () => context.pushNamed(
          RouteNames.creationDetail,
          pathParameters: {'creationId': post.id},
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: AppRadius.medium,
                child: post.imageUrl.startsWith('http')
                    ? Image.network(
                        post.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        errorBuilder: (_, __, ___) => Container(
                          color: AppColors.surfaceMuted,
                          child: const Icon(Icons.image, color: AppColors.textDisabled),
                        ),
                      )
                    : Container(
                        color: AppColors.surfaceMuted,
                        child: const Icon(Icons.image, color: AppColors.textDisabled),
                      ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Row(
              children: [
                CircleAvatar(
                  radius: 8,
                  backgroundColor: AppColors.surfaceMuted,
                  backgroundImage: post.creatorAvatar != null && post.creatorAvatar!.isNotEmpty
                      ? NetworkImage(post.creatorAvatar!)
                      : null,
                  child: post.creatorAvatar == null || post.creatorAvatar!.isEmpty
                      ? const Icon(Icons.person, size: 10, color: AppColors.textDisabled)
                      : null,
                ),
                const SizedBox(width: AppSpacing.xs),
                Expanded(
                  child: Text(
                    post.creatorName,
                    style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DifficultyBadge extends StatelessWidget {
  final String difficulty;

  const _DifficultyBadge({required this.difficulty});

  @override
  Widget build(BuildContext context) {
    final color = _getDifficultyColor(difficulty);
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: AppRadius.badge,
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        difficulty,
        style: AppTextStyles.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return AppColors.success;
      case 'intermediate':
        return AppColors.warning;
      case 'advanced':
      case 'expert':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }
}

