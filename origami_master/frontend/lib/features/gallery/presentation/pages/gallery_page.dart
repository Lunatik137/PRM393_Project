import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/widgets/app_header.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';
import '../widgets/gallery_grid.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: GalleryView(),
    );
  }
}

class GalleryView extends StatefulWidget {
  const GalleryView({super.key});

  @override
  State<GalleryView> createState() => _GalleryViewState();
}

class _GalleryViewState extends State<GalleryView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(
        title: 'My Gallery',
        bottom: TabBar(
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: [
            Tab(text: 'Creations'),
            Tab(text: 'Posts'),
          ],
        ),
      ),
      body: const TabBarView(
        children: [
          GalleryTabView(isPostsTab: false),
          GalleryTabView(isPostsTab: true),
        ],
      ),
    );
  }
}

class GalleryTabView extends StatefulWidget {
  final bool isPostsTab;

  const GalleryTabView({super.key, required this.isPostsTab});

  @override
  State<GalleryTabView> createState() => _GalleryTabViewState();
}

class _GalleryTabViewState extends State<GalleryTabView> with AutomaticKeepAliveClientMixin {
  late GalleryBloc _bloc;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _bloc = getIt<GalleryBloc>()..add(LoadGallery(isPostsTab: widget.isPostsTab));
    galleryTabRefresh.addListener(_onTabRefresh);
  }

  @override
  void dispose() {
    galleryTabRefresh.removeListener(_onTabRefresh);
    _bloc.close();
    super.dispose();
  }

  void _onTabRefresh() {
    _bloc.add(RefreshGallery());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider.value(
      value: _bloc,
      child: BlocConsumer<GalleryBloc, GalleryState>(
        listener: (context, state) {
          if (state is GalleryActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.success),
            );
          } else if (state is GalleryActionError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
            );
          } else if (state is GalleryErrorLoadingMore) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
            );
          } else if (state is GalleryError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
            );
          }
        },
        builder: (context, state) {
          if (state is GalleryLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is GalleryEmpty) {
            return EmptyState(
              title: widget.isPostsTab ? 'No posts yet.' : 'No completed origami yet.',
              message: widget.isPostsTab ? 'Share your creations with the community.' : 'Create your first masterpiece.',
              icon: widget.isPostsTab ? Icons.dynamic_feed : Icons.photo_library_outlined,
            );
          }

          if (state is GalleryLoaded) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<GalleryBloc>().add(RefreshGallery());
              },
              child: GalleryGrid(
                items: state.items,
                isLoadingMore: state is GalleryLoadingMore,
                hasReachedMax: state.hasReachedMax,
                isPost: widget.isPostsTab,
                onLoadMore: () {
                  context.read<GalleryBloc>().add(LoadMoreGallery());
                },
                onItemTap: widget.isPostsTab ? (item) {
                  context.pushNamed(
                    RouteNames.postDetail,
                    pathParameters: {'postId': item.id},
                  );
                } : null,
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
