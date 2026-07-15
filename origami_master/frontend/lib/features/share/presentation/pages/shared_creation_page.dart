import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../bloc/share_bloc.dart';
import '../bloc/share_event.dart';
import '../bloc/share_state.dart';
import '../widgets/unavailable_link_view.dart';

class SharedCreationPage extends StatelessWidget {
  final String token;

  const SharedCreationPage({super.key, required this.token});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ShareBloc>()..add(LoadSharedCreation(token)),
      child: const SharedCreationView(),
    );
  }
}

class SharedCreationView extends StatelessWidget {
  const SharedCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ShareBloc, ShareState>(
        builder: (context, state) {
          if (state is ShareLoading || state is ShareInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ShareUnavailable || state is ShareError) {
            return const UnavailableLinkView();
          }

          if (state is SharedCreationLoaded) {
            final creation = state.creation;
            final dateStr = '${creation.completionDate.day}/${creation.completionDate.month}/${creation.completionDate.year}';
            
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 400,
                  pinned: true,
                  iconTheme: const IconThemeData(color: Colors.white),
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CircleAvatar(
                      backgroundColor: Colors.black.withValues(alpha: 0.5),
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Colors.white, size: 20),
                        onPressed: () => context.go('/home'),
                      ),
                    ),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      creation.imageUrl,
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
                SliverSafeArea(
                  top: false,
                  sliver: SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              'Shared Creation - Read Only',
                              style: TextStyle(color: AppColors.primary, fontSize: 12),
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(creation.origamiModelName, style: AppTextStyles.pageTitle),
                          const SizedBox(height: AppSpacing.sm),
                          Text('Created by ${creation.creatorUsername}', style: AppTextStyles.labelLarge),
                          const SizedBox(height: AppSpacing.xs),
                          Text('Completed on $dateStr', style: AppTextStyles.caption),
                          if (creation.description != null && creation.description!.isNotEmpty) ...[
                            const SizedBox(height: AppSpacing.lg),
                            const Text('Description', style: AppTextStyles.sectionTitle),
                            const SizedBox(height: AppSpacing.sm),
                            Text(
                              creation.description!,
                              style: AppTextStyles.body,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

