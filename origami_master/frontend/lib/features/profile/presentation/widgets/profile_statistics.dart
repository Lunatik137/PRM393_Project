import 'package:flutter/material.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../domain/entities/profile.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/navigation/route_names.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
class ProfileStatisticsWidget extends StatelessWidget {
  final Profile profile;

  const ProfileStatisticsWidget({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildStatColumn('Folds', profile.completedFolds, () {}),
        _buildStatColumn('Posts', profile.publicCreations, () {}),
        _buildStatColumn('Followers', profile.followersCount, () async {
          await context.pushNamed(RouteNames.followers, pathParameters: {'userId': profile.id});
          if (context.mounted) {
            context.read<ProfileBloc>().add(RefreshProfile(profile.id));
          }
        }),
        _buildStatColumn('Following', profile.followingCount, () async {
          await context.pushNamed(RouteNames.following, pathParameters: {'userId': profile.id});
          if (context.mounted) {
            context.read<ProfileBloc>().add(RefreshProfile(profile.id));
          }
        }),
      ],
    );
  }

  Widget _buildStatColumn(String label, int count, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm, horizontal: AppSpacing.sm),
        child: Column(
          children: [
            Text(count.toString(), style: AppTextStyles.titleLarge),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              label,
              style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
