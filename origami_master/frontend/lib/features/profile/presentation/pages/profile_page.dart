import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/di/injection.dart';
import '../../../../../core/widgets/app_header.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/utils/tab_refresh_notifier.dart';
import '../bloc/profile_bloc.dart';
import '../bloc/profile_event.dart';
import '../bloc/profile_state.dart';
import '../widgets/profile_header.dart';
import '../widgets/profile_post_grid.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ProfileBloc>()..add(LoadMyProfile()),
      child: const ProfileView(),
    );
  }
}

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final _scrollController = ScrollController();
  late ProfileBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = context.read<ProfileBloc>();
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    profileTabRefresh.addListener(_onTabRefresh);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    profileTabRefresh.removeListener(_onTabRefresh);
    super.dispose();
  }

  void _onTabRefresh() {
    _bloc.add(LoadMyProfile());
  }

  void _onScroll() {
    if (_isBottom) {
      final state = context.read<ProfileBloc>().state;
      if (state is ProfileLoaded && !state.hasReachedMaxPosts) {
        context.read<ProfileBloc>().add(LoadMorePosts(state.profile.id));
      }
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'My Profile', leading: SizedBox.shrink()),
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {
          if (state is ProfileLogoutSuccess) {
            context.go('/login');
          } else if (state is ProfileErrorLoadingMorePosts) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load posts: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is ProfileLoading || state is ProfileInitial) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is ProfileError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message, style: AppTextStyles.body),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => context.read<ProfileBloc>().add(LoadMyProfile()),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (state is ProfileLoaded) {
            final isLoggingOut = false;
            return RefreshIndicator(
              onRefresh: () async {
                context.read<ProfileBloc>().add(RefreshProfile());
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverToBoxAdapter(
                    child: ProfileHeader(
                      profile: state.profile,
                      isMyProfile: state.isMyProfile,
                      isLoggingOut: isLoggingOut,
                    ),
                  ),
                  if (state is ProfileEmptyPosts)
                    const SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Text(
                          'No posts yet.',
                          style: AppTextStyles.body,
                        ),
                      ),
                    )
                  else
                    ProfilePostGrid(
                      posts: state.posts,
                      hasReachedMaxPosts: state.hasReachedMaxPosts,
                    ),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}
