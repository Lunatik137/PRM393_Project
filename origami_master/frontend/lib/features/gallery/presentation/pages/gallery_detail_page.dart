import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/config/app_config.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/visibility_badge.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';
import '../../domain/usecases/get_gallery.dart';
import '../../domain/entities/gallery_item.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_state.dart';
import '../bloc/gallery_event.dart';
import '../../../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../../../features/auth/presentation/bloc/auth_state.dart';

class GalleryDetailPage extends StatefulWidget {
  final String creationId;
  final String? source;
  final bool showOwnerActions;

  const GalleryDetailPage({
    super.key,
    required this.creationId,
    this.source,
    this.showOwnerActions = true,
  });

  @override
  State<GalleryDetailPage> createState() => _GalleryDetailPageState();
}

class _GalleryDetailPageState extends State<GalleryDetailPage> {
  GalleryItem? _item;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    try {
      final getGallery = getIt<GetGalleryUseCase>();
      final item = await getGallery.detail(widget.creationId);
      if (mounted) {
        setState(() {
          _item = item;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load gallery detail')),
        );
      }
    }
  }

  void _onBack() {
    if (widget.source != null) {
      context.go(widget.source!);
    } else {
      context.pop();
    }
  }

  Future<void> _confirmDelete(BuildContext blocContext) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Creation'),
        content: const Text(
          'Are you sure you want to delete this creation? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      blocContext.read<GalleryBloc>().add(DeleteGallery(_item!.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_item == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
            onPressed: _onBack,
          ),
        ),
        body: const Center(child: Text('Creation not found')),
      );
    }

      return BlocProvider(
        create: (_) => getIt<GalleryBloc>(),
        child: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, state) {
            if (state is GalleryActionSuccess) {
              galleryTabRefresh.value++;
              _onBack();
            } else if (state is GalleryActionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
              );
            }
          },
          builder: (context, state) {
            return Scaffold(
              backgroundColor: AppColors.background,
              body: Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      _buildSliverAppBar(),
                      SliverSafeArea(
                        top: false,
                        sliver: SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSpacing.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _buildInfo(),
                                const SizedBox(height: AppSpacing.xxl),
                                _buildOwnerActions(context),
                                const SizedBox(height: AppSpacing.xxl),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (state is GalleryDeleting)
                    Container(
                      color: Colors.black54,
                      child: const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                    ),
                ],
              ),
            );
          },
        ),
      );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 400,
      pinned: true,
      leading: IconButton(
        icon: const CircleAvatar(
          backgroundColor: AppColors.overlay,
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
        onPressed: _onBack,
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            _item!.imageUrl.isNotEmpty
                ? Image.network(
                    _item!.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      color: AppColors.surfaceMuted,
                      child: const Icon(
                        Icons.image,
                        size: 100,
                        color: AppColors.textDisabled,
                      ),
                    ),
                  )
                : Container(
                    color: AppColors.surfaceMuted,
                    child: const Icon(
                      Icons.image,
                      size: 100,
                      color: AppColors.textDisabled,
                    ),
                  ),
            Positioned(
              bottom: AppSpacing.lg,
              left: AppSpacing.lg,
              child: VisibilityBadge(isPublished: _item!.visibility == 'Public'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfo() {
    final date = _item!.createdAt;
    final dateStr = date != null ? '${date.day}/${date.month}/${date.year}' : 'Unknown date';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(_item!.caption?.isNotEmpty == true ? _item!.caption! : 'Untitled', style: AppTextStyles.pageTitle),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            CircleAvatar(
              radius: 12,
              backgroundColor: AppColors.surfaceMuted,
              backgroundImage: _item!.creatorAvatar != null && _item!.creatorAvatar!.isNotEmpty
                  ? NetworkImage(_item!.creatorAvatar!)
                  : null,
              child: _item!.creatorAvatar == null || _item!.creatorAvatar!.isEmpty
                  ? const Icon(Icons.person, size: 16, color: AppColors.textDisabled)
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              _item!.creatorName,
              style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Completed on $dateStr', style: AppTextStyles.caption),
        const SizedBox(height: AppSpacing.sm),
      ],
    );
  }

  Widget _buildOwnerActions(BuildContext blocContext) {
    if (!widget.showOwnerActions) {
      return const SizedBox.shrink();
    }

    final authState = context.read<AuthBloc>().state;
    bool isCreator = false;
    if (authState is Authenticated) {
      isCreator = authState.session.user.id == _item!.creatorId;
    }

    if (!isCreator) {
      return const SizedBox.shrink();
    }

    final hasShareLink = _item!.shareToken != null;
    final shareUrl = hasShareLink ? '${AppConfig.mediaBaseUrl}/share/${_item!.shareToken}' : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Card(
          elevation: 0,
          color: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.md),
            side: const BorderSide(color: AppColors.border),
          ),
          child: ListTile(
            leading: const Icon(Icons.edit_outlined),
            title: const Text('Edit Details'),
            trailing: const Icon(Icons.chevron_right),
            onTap: () {
              context.pushNamed(
                RouteNames.editGallery,
                pathParameters: {'creationId': _item!.id},
              ).then((_) => _loadItem());
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (hasShareLink) ...[
          // Show existing share link
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.md),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(Icons.link, size: 16, color: AppColors.primary),
                    const SizedBox(width: AppSpacing.xs),
                    const Text('Share Link', style: TextStyle(fontWeight: FontWeight.w600)),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: (_item!.shareIsActive == true ? AppColors.success : AppColors.danger).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        _item!.shareIsActive == true ? 'Active' : 'Inactive',
                        style: TextStyle(
                          fontSize: 11,
                          color: _item!.shareIsActive == true ? AppColors.success : AppColors.danger,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  shareUrl ?? '',
                  style: AppTextStyles.caption.copyWith(color: AppColors.textSecondary),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        await Clipboard.setData(ClipboardData(text: shareUrl ?? ''));
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Link copied!')),
                          );
                        }
                      },
                      icon: const Icon(Icons.copy, size: 16),
                      label: const Text('Copy'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ] else ...[
          PrimaryButton(
            label: 'Generate Share Link',
            onPressed: () => context.pushNamed(
              RouteNames.generateShareLink,
              pathParameters: {'creationId': _item!.id},
            ).then((_) => _loadItem()),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        TextButton(
          onPressed: () => _confirmDelete(blocContext),
          style: TextButton.styleFrom(foregroundColor: AppColors.danger),
          child: const Text('Delete Creation'),
        ),
      ],
    );
  }
}
