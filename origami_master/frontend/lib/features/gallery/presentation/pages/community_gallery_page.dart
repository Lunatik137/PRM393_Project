import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/navigation/route_names.dart';
import '../widgets/gallery_grid.dart';
import '../../data/api/gallery_api.dart';
import '../../domain/entities/gallery_item.dart';

class CommunityGalleryPage extends StatefulWidget {
  final String origamiModelId;

  const CommunityGalleryPage({super.key, required this.origamiModelId});

  @override
  State<CommunityGalleryPage> createState() => _CommunityGalleryPageState();
}

class _CommunityGalleryPageState extends State<CommunityGalleryPage> {
  final List<GalleryItem> _items = [];
  bool _isLoading = true;
  bool _isLoadingMore = false;
  bool _hasReachedMax = false;
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _loadInitial();
  }

  Future<void> _loadInitial() async {
    setState(() => _isLoading = true);
    try {
      final api = getIt<GalleryApi>();
      final response = await api.getPublicGallery(
        origamiModelId: widget.origamiModelId,
        pageNumber: 1,
        pageSize: 20,
      );
      if (mounted) {
        setState(() {
          _items.clear();
          // Assuming GalleryItem mapping is available
          // We need to map from GalleryResponseDto to GalleryItem
          _items.addAll(response.items.map((e) => GalleryItem(
            id: e.id,
            origamiModelId: e.origamiModelId,
            origamiModelName: e.origamiModelName,
            imageUrl: e.imageUrl,
            caption: e.caption,
            difficulty: e.difficulty,
            createdAt: e.createdAt,
            visibility: e.visibility ?? 'Public',
            isPublished: e.isPublished ?? true,
            creatorId: e.creatorId,
            creatorName: e.creatorName,
            creatorAvatar: e.creatorAvatar,
          )).toList());
          _isLoading = false;
          _hasReachedMax = !response.hasMore;
          _currentPage = 1;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load community gallery')),
        );
      }
    }
  }

  Future<void> _loadMore() async {
    if (_isLoadingMore || _hasReachedMax) return;
    setState(() => _isLoadingMore = true);
    try {
      final nextPage = _currentPage + 1;
      final api = getIt<GalleryApi>();
      final response = await api.getPublicGallery(
        origamiModelId: widget.origamiModelId,
        pageNumber: nextPage,
        pageSize: 20,
      );
      if (mounted) {
        setState(() {
          _items.addAll(response.items.map((e) => GalleryItem(
            id: e.id,
            origamiModelId: e.origamiModelId,
            origamiModelName: e.origamiModelName,
            imageUrl: e.imageUrl,
            caption: e.caption,
            difficulty: e.difficulty,
            createdAt: e.createdAt,
            visibility: e.visibility ?? 'Public',
            isPublished: e.isPublished ?? true,
            creatorId: e.creatorId,
            creatorName: e.creatorName,
            creatorAvatar: e.creatorAvatar,
          )).toList());
          _isLoadingMore = false;
          _hasReachedMax = !response.hasMore;
          _currentPage = nextPage;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMore = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load more')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Community Gallery', style: AppTextStyles.titleLarge),
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => context.pop(),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _items.isEmpty
              ? const EmptyState(
                  title: 'No community creations',
                  message: 'Be the first to share your creation!',
                  icon: Icons.photo_library_outlined,
                )
              : RefreshIndicator(
                  onRefresh: _loadInitial,
                  child: GalleryGrid(
                    items: _items,
                    isLoadingMore: _isLoadingMore,
                    hasReachedMax: _hasReachedMax,
                    onLoadMore: _loadMore,
                    showCreatorName: true,
                    onItemTap: (item) {
                      context.pushNamed(
                        RouteNames.creationDetail,
                        pathParameters: {'creationId': item.id},
                        queryParameters: {'showOwnerActions': 'false'},
                      );
                    },
                  ),
                ),
    );
  }
}
