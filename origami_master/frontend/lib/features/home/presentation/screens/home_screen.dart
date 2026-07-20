import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';
import '../bloc/feed_bloc.dart';
import '../bloc/feed_event.dart';
import '../bloc/feed_state.dart';
import '../widgets/feed_post_card.dart'; 

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FeedBloc>()..add(LoadFeed()),
      child: const HomeFeedView(),
    );
  }
}

class HomeFeedView extends StatefulWidget {
  const HomeFeedView({super.key});

  @override
  State<HomeFeedView> createState() => _HomeFeedViewState();
}

class _HomeFeedViewState extends State<HomeFeedView> {
  final _scrollController = ScrollController();
  late FeedBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<FeedBloc>();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    homeTabRefresh.addListener(_onTabRefresh);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    homeTabRefresh.removeListener(_onTabRefresh);
    super.dispose();
  }

  void _onTabRefresh() {
    _bloc.add(LoadFeed());
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<FeedBloc>().add(LoadMoreFeed());
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return maxScroll > 0 && currentScroll >= (maxScroll - 50);
  }

  Future<void> _onRefresh() async {
    context.read<FeedBloc>().add(RefreshFeed());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppHeader(
        showLogo: true,
        actions: [
          IconButton(
            onPressed: () => context.pushNamed(RouteNames.search),
            icon: const Icon(Icons.search, color: AppColors.primary, size: 28),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () => context.pushNamed(RouteNames.createPost),
            icon: const Icon(Icons.add_circle_outline, color: AppColors.primary, size: 28),
            tooltip: 'Create Post',
          ),
          const SizedBox(width: AppSpacing.xs),
        ],
      ),
      body: SafeArea(
        child: BlocConsumer<FeedBloc, FeedState>(
          listener: (context, state) {
            if (state is FeedErrorLoadingMore) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Failed to load more: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            if (state is FeedInitial || state is FeedLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is FeedError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.message}'),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: () => context.read<FeedBloc>().add(LoadFeed()),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            } else if (state is FeedEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('No posts available.\nFollow more creators or check back later.', textAlign: TextAlign.center),
                    const SizedBox(height: AppSpacing.md),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      child: const Text('Refresh'),
                    ),
                  ],
                ),
              );
            } else if (state is FeedLoaded) {
              return RefreshIndicator(
                onRefresh: _onRefresh,
                child: ListView.builder(
                  controller: _scrollController,
                  padding: EdgeInsets.only(
                    bottom: state.hasReachedMax ? AppSpacing.xxl : MediaQuery.of(context).size.height * 0.5,
                  ),
                  itemCount: state.hasReachedMax ? state.posts.length : state.posts.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.posts.length) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(AppSpacing.md),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    
                    final post = state.posts[index];
                    return FeedPostCard(
                      creatorAvatarPath: post.creatorAvatar ?? '',
                      creatorName: post.creatorName,
                      isFollowing: false, // isFollowingCreator removed
                      creationImagePath: post.imageUrl ?? '',
                      foldName: post.description,
                      likesCount: post.likeCount,
                      commentsCount: post.commentCount,
                      isLiked: post.isLiked,
                      hashtags: post.hashtags,
                      onLikeTapped: () {
                        if (post.isLiked) {
                          context.read<FeedBloc>().add(UnlikePost(post.id));
                        } else {
                          context.read<FeedBloc>().add(LikePost(post.id));
                        }
                      },
                      onCommentTapped: () => context.pushNamed(
                        RouteNames.postDetail,
                        pathParameters: {'postId': post.id},
                      ),
                      onShareTapped: () {},
                      onCardTapped: () => context.pushNamed(
                        RouteNames.postDetail,
                        pathParameters: {'postId': post.id},
                      ),
                      onCreatorTapped: () => context.pushNamed(
                        RouteNames.userProfile,
                        pathParameters: {'userId': post.creatorId},
                      ),
                    );
                  },
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
