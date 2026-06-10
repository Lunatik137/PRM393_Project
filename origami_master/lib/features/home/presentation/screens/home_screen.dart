import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/creation_card.dart';
import '../../../../core/widgets/origami_card.dart';
import '../../../../data/mock/mock_data.dart';
import '../widgets/continue_learning_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Data setup
    final featuredFold = MockData.origamiModels.first;
    final activeProgress = MockData.learningProgress.firstWhere(
      (p) => !p.isCompleted,
      orElse: () => MockData.learningProgress.first,
    );
    final activeOrigami = MockData.origamiModels.firstWhere(
      (m) => m.id == activeProgress.origamiId,
    );
    final recentPublicCreations = MockData.communityCreations
        .where((c) => c.isPublic)
        .take(5)
        .toList();

    return Scaffold(
      appBar: AppHeader(
        showLogo: true,
        actions: [
          IconButton(
            onPressed: () => context.goNamed(RouteNames.profile),
            icon: const CircleAvatar(
              radius: 16,
              backgroundColor: AppColors.surfaceMuted,
              child: Icon(
                Icons.person,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          children: [
            // Featured Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Featured Fold',
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 240,
                    child: OrigamiCard(
                      name: featuredFold.name,
                      category: featuredFold.category,
                      difficulty: featuredFold.difficulty,
                      imagePath: featuredFold.imagePath,
                      onTap: () => context.pushNamed(
                        RouteNames.foldDetail,
                        pathParameters: {'origamiId': featuredFold.id},
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Continue Learning Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Resume Progress',
                    style: AppTextStyles.sectionTitle,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  ContinueLearningCard(
                    title: activeOrigami.name,
                    currentStep: activeProgress.currentStep,
                    totalSteps: activeProgress.totalSteps,
                    onTap: () => context.pushNamed(
                      RouteNames.learningStep,
                      pathParameters: {'origamiId': activeOrigami.id},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.xxl),

            // Community Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                  child: Text(
                    'Recent Community Creations',
                    style: AppTextStyles.sectionTitle,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                SizedBox(
                  height: 200,
                  child: ListView.separated(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg,
                    ),
                    scrollDirection: Axis.horizontal,
                    itemCount: recentPublicCreations.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: AppSpacing.md),
                    itemBuilder: (context, index) {
                      final creation = recentPublicCreations[index];
                      return SizedBox(
                        width: 160,
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
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
