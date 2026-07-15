import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/widgets/app_header.dart';
import '../../../../../core/di/injection.dart';
import '../bloc/follow_bloc.dart';
import '../bloc/follow_event.dart';
import '../bloc/follow_state.dart';
import '../widgets/user_list_item.dart';

class FollowingPage extends StatelessWidget {
  final String userId;

  const FollowingPage({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<FollowBloc>()..add(LoadFollowing(userId)),
      child: FollowingView(userId: userId),
    );
  }
}

class FollowingView extends StatefulWidget {
  final String userId;

  const FollowingView({super.key, required this.userId});

  @override
  State<FollowingView> createState() => _FollowingViewState();
}

class _FollowingViewState extends State<FollowingView> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<FollowBloc>().add(LoadMoreFollowing(widget.userId));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    return currentScroll >= (maxScroll * 0.8);
  }

  Future<void> _onRefresh() async {
    context.read<FollowBloc>().add(RefreshFollowing(widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppHeader(title: 'Following'),
      body: BlocConsumer<FollowBloc, FollowState>(
        listener: (context, state) {
          if (state is FollowErrorLoadingMore) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load more: ${state.message}')),
            );
          } else if (state is FollowError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Error: ${state.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is FollowInitial || state is FollowLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is FollowError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.message),
                  const SizedBox(height: AppSpacing.md),
                  ElevatedButton(
                    onPressed: () => context.read<FollowBloc>().add(LoadFollowing(widget.userId)),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is FollowEmpty) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: const CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'Not following anyone yet.',
                        style: AppTextStyles.body,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FollowLoaded) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.separated(
                controller: _scrollController,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.hasReachedMax ? state.users.length : state.users.length + 1,
                separatorBuilder: (context, index) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  if (index >= state.users.length) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(AppSpacing.md),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  final user = state.users[index];
                  return UserListItem(user: user);
                },
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
