import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/creation_card.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../data/mock/mock_data.dart';
import '../../../../models/origami_model.dart';
import '../../../../models/user_creation.dart';

class FoldDetailScreen extends StatelessWidget {
  final String origamiId;

  const FoldDetailScreen({super.key, required this.origamiId});

  @override
  Widget build(BuildContext context) {
    final origami = MockData.origamiModels.firstWhere(
      (m) => m.id == origamiId,
      orElse: () => throw Exception('Origami model not found: $origamiId'),
    );

    final communityCreations = MockData.communityCreations
        .where((c) => c.isPublic && c.origamiId == origamiId)
        .toList();

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
                  _buildSectionTitle('Materials'),
                  const SizedBox(height: AppSpacing.md),
                  _buildMaterialsList(origami.materials),
                  const SizedBox(height: AppSpacing.xxl),
                  _buildSectionTitle('Step Preview'),
                  const SizedBox(height: AppSpacing.md),
                  _buildStepsTimeline(origami),
                  const SizedBox(height: AppSpacing.xxl),
                  if (communityCreations.isNotEmpty) ...[
                    _buildSectionTitle('Community Gallery'),
                    const SizedBox(height: AppSpacing.md),
                    _buildCommunityGallery(context, communityCreations),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
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
              pathParameters: {'origamiId': origamiId},
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
        background: Image.asset(
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
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: materials.map((material) {
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
              const Icon(
                Icons.check_circle_outline,
                size: 16,
                color: AppColors.primary,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(material, style: AppTextStyles.bodySmall),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildStepsTimeline(OrigamiModel origami) {
    return Column(
      children: origami.steps.map((step) {
        final isLast = origami.steps.last == step;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  width: 28,
                  height: 28,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      '${step.stepNumber}',
                      style: AppTextStyles.caption.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                if (!isLast)
                  Container(width: 2, height: 40, color: AppColors.divider),
              ],
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(step.title, style: AppTextStyles.labelLarge),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    step.description,
                    style: AppTextStyles.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  Widget _buildCommunityGallery(
    BuildContext context,
    List<UserCreation> creations,
  ) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: creations.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.md),
        itemBuilder: (context, index) {
          final creation = creations[index];
          return SizedBox(
            width: 140,
            child: CreationCard(
              foldName: creation.foldName,
              imagePath: creation.imagePath,
              isPublic: creation.isPublic,
              completedAt: creation.completedAt,
              onTap: () => context.pushNamed(
                RouteNames.creationDetail,
                pathParameters: {'creationId': creation.id},
              ),
            ),
          );
        },
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
      case 'easy':
        return AppColors.success;
      case 'medium':
        return AppColors.warning;
      case 'hard':
        return AppColors.danger;
      default:
        return AppColors.primary;
    }
  }
}
