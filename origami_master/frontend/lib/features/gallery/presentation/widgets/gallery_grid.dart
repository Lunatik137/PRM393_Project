import 'package:flutter/material.dart';
import '../../domain/entities/gallery_item.dart';
import '../../../../core/theme/app_spacing.dart';
import 'gallery_card.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';

class GalleryGrid extends StatefulWidget {
  final List<GalleryItem> items;
  final bool isLoadingMore;
  final bool hasReachedMax;
  final VoidCallback onLoadMore;
  final void Function(GalleryItem)? onItemTap;
  final bool showCreatorName;
  final bool isPost;

  const GalleryGrid({
    super.key,
    required this.items,
    required this.isLoadingMore,
    required this.hasReachedMax,
    required this.onLoadMore,
    this.onItemTap,
    this.showCreatorName = false,
    this.isPost = false,
  });

  @override
  State<GalleryGrid> createState() => _GalleryGridState();
}

class _GalleryGridState extends State<GalleryGrid> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom && !widget.isLoadingMore && !widget.hasReachedMax) {
      widget.onLoadMore();
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: AppSpacing.md,
              mainAxisSpacing: AppSpacing.md,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final item = widget.items[index];
                return GalleryCard(
                  item: item,
                  showCreatorName: widget.showCreatorName,
                  isPost: widget.isPost,
                  onTap: () {
                    if (widget.onItemTap != null) {
                      widget.onItemTap!(item);
                    } else {
                      context.pushNamed(
                        RouteNames.creationDetail,
                        pathParameters: {'creationId': item.id},
                      );
                    }
                  },
                );
              },
              childCount: widget.items.length,
            ),
          ),
        ),
        if (widget.isLoadingMore)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    );
  }
}
