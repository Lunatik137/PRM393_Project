import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_radius.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/navigation/route_names.dart';
import '../../../home/domain/entities/feed_post.dart';

class ProfilePostGrid extends StatelessWidget {
  final List<FeedPost> posts;
  final bool hasReachedMaxPosts;

  const ProfilePostGrid({
    super.key,
    required this.posts,
    required this.hasReachedMaxPosts,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.all(AppSpacing.sm),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: AppSpacing.sm,
          mainAxisSpacing: AppSpacing.sm,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (index >= posts.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final post = posts[index];
            return GestureDetector(
              onTap: () {
                context.pushNamed(RouteNames.postDetail, pathParameters: {'postId': post.id});
              },
              child: ClipRRect(
                borderRadius: AppRadius.medium,
                child: CachedNetworkImage(
                  imageUrl: post.imageUrl ?? '',
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: AppColors.surfaceMuted,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: AppColors.surfaceMuted,
                    child: const Center(
                      child: Icon(Icons.image_not_supported, color: AppColors.textDisabled),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: hasReachedMaxPosts ? posts.length : posts.length + 1,
        ),
      ),
    );
  }
}
