import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/navigation/route_names.dart';
import '../../../../core/services/creation_service.dart';
import '../../../../core/services/share_link_service.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/empty_state.dart';
import '../../../../core/widgets/shared_link_card.dart';
import '../../../../models/share_link.dart';
import '../../../../models/user_creation.dart';

class SharedLinksScreen extends StatefulWidget {
  final String? source;
  final String? creationId;

  const SharedLinksScreen({super.key, this.source, this.creationId});

  @override
  State<SharedLinksScreen> createState() => _SharedLinksScreenState();
}

class _SharedLinksScreenState extends State<SharedLinksScreen> {
  final Map<String, UserCreation> _creationsById = {};
  List<ShareLink> _links = const [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLinks();
  }

  Future<void> _loadLinks() async {
    final creations = await CreationService.instance.getCreations();
    final creationIds = creations.map((creation) => creation.id).toSet();
    final links = await ShareLinkService.instance.getShareLinksByCreationIds(
      creationIds,
    );

    if (!mounted) return;

    setState(() {
      _creationsById
        ..clear()
        ..addEntries(
          creations.map((creation) => MapEntry(creation.id, creation)),
        );
      _links = links;
      _isLoading = false;
    });
  }

  void _handleBack() {
    if (widget.source == RouteNames.generateShareLink &&
        widget.creationId != null &&
        widget.creationId!.isNotEmpty) {
      context.goNamed(
        RouteNames.generateShareLink,
        pathParameters: {'creationId': widget.creationId!},
      );
      return;
    }

    context.goNamed(RouteNames.profile);
  }

  Future<void> _copyLink(ShareLink link) async {
    if (!link.isActive) return;

    await Clipboard.setData(ClipboardData(text: link.url));

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link copied to clipboard!'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _confirmDisable(ShareLink link) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Disable Link?'),
        content: const Text(
          'This shared link will stop opening your creation.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Disable'),
          ),
        ],
      ),
    );

    if (confirmed != true) return;

    await ShareLinkService.instance.disableShareLink(link.id);
    await _loadLinks();

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Link disabled'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _openSharedCreation(ShareLink link) {
    if (!link.isActive) return;

    context.pushNamed(
      RouteNames.sharedCreation,
      pathParameters: {'token': link.token},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: _handleBack,
        ),
        title: const Text('Shared Links', style: AppTextStyles.sectionTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _links.isEmpty
            ? const EmptyState(
                icon: Icons.link_off,
                title: 'No shared links yet',
                message: 'Generated links will appear here.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(AppSpacing.lg),
                itemCount: _links.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: AppSpacing.md),
                itemBuilder: (context, index) {
                  final link = _links[index];
                  final creation = _creationsById[link.creationId];

                  return SharedLinkCard(
                    foldName: creation?.foldName ?? 'Unknown Creation',
                    imagePath: creation?.imagePath ?? '',
                    url: link.url,
                    isActive: link.isActive,
                    createdAt: link.createdAt,
                    onTap: () => _openSharedCreation(link),
                    onCopy: () => _copyLink(link),
                    onDelete: link.isActive
                        ? () => _confirmDisable(link)
                        : null,
                  );
                },
              ),
      ),
    );
  }
}
