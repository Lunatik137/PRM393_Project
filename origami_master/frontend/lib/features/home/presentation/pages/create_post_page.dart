import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';
import '../../../upload/domain/usecases/upload_image.dart';
import '../../data/api/feed_api.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final _descriptionController = TextEditingController();
  final _hashtagsController = TextEditingController();
  File? _selectedImage;
  bool _isSaving = false;

  @override
  void dispose() {
    _descriptionController.dispose();
    _hashtagsController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final file = await picker.pickImage(source: source, imageQuality: 85);
      if (file != null) {
        final croppedFile = await ImageCropper().cropImage(
          sourcePath: file.path,
          aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
          uiSettings: [
            AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: AppColors.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: true,
            ),
            IOSUiSettings(
              title: 'Crop Image',
              aspectRatioLockEnabled: true,
              resetAspectRatioEnabled: false,
            ),
          ],
        );

        if (croppedFile != null && mounted) {
          setState(() => _selectedImage = File(croppedFile.path));
        }
      }
    } catch (_) {}
  }

  void _showImageSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: AppSpacing.md,
                horizontal: AppSpacing.lg,
              ),
              child: Text('Add Photo', style: AppTextStyles.labelLarge),
            ),
            const Divider(height: 1),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: const Text('Take Photo'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: const Text('Choose from Library'),
              onTap: () {
                Navigator.pop(ctx);
                _pickImage(ImageSource.gallery);
              },
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ),
      ),
    );
  }

  Future<void> _submit() async {
    final description = _descriptionController.text.trim();
    if (description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add a description')),
      );
      return;
    }

    // Extract hashtags from controller, split by comma or space
    final rawHashtags = _hashtagsController.text.trim();
    final hashtags = rawHashtags.isNotEmpty
        ? rawHashtags.split(RegExp(r'[,\s]+'))
            .where((tag) => tag.isNotEmpty)
            .map((tag) => tag.startsWith('#') ? tag : '#$tag')
            .toList()
        : <String>[];

    setState(() => _isSaving = true);
    try {
      // Upload image if selected
      String? imageUrl;
      if (_selectedImage != null) {
        final uploadUseCase = getIt<UploadImageUseCase>();
        final result = await uploadUseCase(_selectedImage!);
        imageUrl = result.imageUrl;
      }

      // Publish directly as a feed post (no creation record needed)
      final feedApi = getIt<FeedApi>();
      await feedApi.publishPost({
        'imageUrl': imageUrl,
        'description': description,
        'hashtags': hashtags,
      });

      homeTabRefresh.value++;
      profileTabRefresh.value++;
      galleryTabRefresh.value++;
      if (mounted) context.pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.danger,
        ));
        setState(() => _isSaving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Create Post'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Image area
            GestureDetector(
              onTap: _showImageSheet,
              child: AspectRatio(
                aspectRatio: 1.0,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.surfaceMuted,
                    borderRadius: AppRadius.large,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: _selectedImage != null
                      ? ClipRRect(
                          borderRadius: AppRadius.large,
                          child: Image.file(_selectedImage!, fit: BoxFit.cover, width: double.infinity),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.add_photo_alternate_outlined, size: 48, color: AppColors.textDisabled),
                            const SizedBox(height: AppSpacing.sm),
                            Text('Tap to add photo (optional)', style: AppTextStyles.bodySmall.copyWith(color: AppColors.textSecondary)),
                          ],
                        ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            // Description
            TextField(
              controller: _descriptionController,
              maxLines: 5,
              decoration: InputDecoration(
                hintText: 'Share your knowledge, tips, or experience...',
                filled: true,
                fillColor: AppColors.surfaceWhite,
                border: OutlineInputBorder(borderRadius: AppRadius.medium),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.medium,
                  borderSide: BorderSide(color: AppColors.border),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            
            // Hashtags
            TextField(
              controller: _hashtagsController,
              decoration: InputDecoration(
                hintText: 'Add hashtags (e.g., #origami, #paper)',
                filled: true,
                fillColor: AppColors.surfaceWhite,
                border: OutlineInputBorder(borderRadius: AppRadius.medium),
                enabledBorder: OutlineInputBorder(
                  borderRadius: AppRadius.medium,
                  borderSide: BorderSide(color: AppColors.border),
                ),
                prefixIcon: const Icon(Icons.tag, color: AppColors.textSecondary),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),

            PrimaryButton(
              label: _isSaving ? 'Posting...' : 'Post',
              onPressed: _isSaving ? null : _submit,
              isLoading: _isSaving,
            ),
          ],
        ),
      ),
    );
  }
}
