import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/api/feed_api.dart';
import '../../domain/entities/feed_post.dart';
import '../../../../features/home/data/dto/feed_response_dto.dart';
import '../../../../features/home/data/mapper/feed_mapper.dart';

class EditPostPage extends StatefulWidget {
  final String postId;
  const EditPostPage({super.key, required this.postId});

  @override
  State<EditPostPage> createState() => _EditPostPageState();
}

class _EditPostPageState extends State<EditPostPage> {
  final _captionController = TextEditingController();
  final _hashtagsController = TextEditingController();
  FeedPost? _item;
  bool _isLoading = true;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }
  
  @override
  void dispose() {
    _captionController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }

  Future<void> _loadItem() async {
    try {
      final feedApi = getIt<FeedApi>();
      final itemResponse = await feedApi.getPost(widget.postId);
      final dto = FeedResponseDto.fromJson(itemResponse);
      final item = FeedMapper.mapToEntity(dto);
      if (mounted) {
        setState(() {
          _item = item;
          _captionController.text = item.description;
          _hashtagsController.text = item.hashtags.join(' ');
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load item')),
        );
      }
    }
  }

  Future<void> _onSave(BuildContext context) async {
    final rawHashtags = _hashtagsController.text.trim();
    final hashtags = rawHashtags.isNotEmpty
        ? rawHashtags.split(RegExp(r'[,\s]+'))
            .where((tag) => tag.isNotEmpty)
            .map((tag) => tag.startsWith('#') ? tag : '#$tag')
            .toList()
        : <String>[];

    setState(() => _isSaving = true);
    try {
      final feedApi = getIt<FeedApi>();
      await feedApi.updatePost(widget.postId, {
        'description': _captionController.text.trim(),
        'hashtags': hashtags,
      });
      if (mounted) {
        context.pop(true);
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update post: $e'), backgroundColor: AppColors.danger),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(title: 'Edit Post'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_item == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(title: 'Edit Post'),
        body: Center(child: Text('Post not found')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Edit Post'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.md),
                border: Border.all(color: AppColors.border),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSpacing.md),
                child: _item!.imageUrl != null
                    ? Image.network(_item!.imageUrl!, fit: BoxFit.cover)
                    : const Center(child: Icon(Icons.image, size: 48)),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            
            TextField(
              controller: _captionController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              enabled: !_isSaving,
            ),
            const SizedBox(height: AppSpacing.md),
            
            TextField(
              controller: _hashtagsController,
              decoration: const InputDecoration(
                labelText: 'Hashtags',
                hintText: 'e.g., #origami #paper',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.tag),
              ),
              enabled: !_isSaving,
            ),
            
            const SizedBox(height: AppSpacing.xxl),
            PrimaryButton(
              label: _isSaving ? 'Saving...' : 'Save Changes',
              onPressed: _isSaving ? null : () => _onSave(context),
            ),
          ],
        ),
      ),
    );
  }
}
