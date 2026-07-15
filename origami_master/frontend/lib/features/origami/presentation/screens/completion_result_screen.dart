import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/navigation/route_names.dart';
import '../../../../core/repositories/origami_repository.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../../../core/widgets/secondary_button.dart';
import '../../../../models/origami_model.dart';
import '../../../gallery/data/dto/gallery_request_dto.dart';
import '../../../gallery/domain/usecases/create_gallery.dart';
import '../../../upload/domain/usecases/upload_image.dart';

class CompletionResultScreen extends StatefulWidget {
  final String creationId;

  const CompletionResultScreen({super.key, required this.creationId});

  @override
  State<CompletionResultScreen> createState() => _CompletionResultScreenState();
}

class _CompletionResultScreenState extends State<CompletionResultScreen> {
  // Track saved origami IDs across the session
  static final Set<String> _savedOrigamiIds = {};

  OrigamiModel? _origami;
  bool _isLoading = true;
  bool _isPublic = false;
  bool _isSaving = false;
  File? _selectedImage;
  final _captionController = TextEditingController();

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  String get _origamiId => widget.creationId.startsWith('new_creation_')
      ? widget.creationId.substring('new_creation_'.length)
      : widget.creationId;

  @override
  void initState() {
    super.initState();
    _loadOrigami();
  }

  Future<void> _loadOrigami() async {
    try {
      final repo = getIt<OrigamiRepository>();
      final model = await repo.getOrigamiById(_origamiId);
      if (mounted) setState(() { _origami = model; _isLoading = false; });
    } catch (_) {
      if (mounted) setState(() { _isLoading = false; });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(source: source, imageQuality: 85);
      if (pickedFile != null && mounted) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not pick image: $e')),
        );
      }
    }
  }

  void _showImageSourceSheet() {
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

  Future<String> _uploadImageIfNeeded() async {
    if (_selectedImage != null) {
      final uploadUseCase = getIt<UploadImageUseCase>();
      final result = await uploadUseCase(_selectedImage!);
      return result.imageUrl;
    }
    final imagePath = _origami?.imagePath ?? '';
    return imagePath.startsWith('http') ? imagePath : '';
  }

  Future<void> _handleSave() async {
    setState(() => _isSaving = true);
    try {
      final imageUrl = await _uploadImageIfNeeded();
      final createUseCase = getIt<CreateGalleryUseCase>();
      await createUseCase(CreateGalleryRequestDto(
        foldModelId: _origamiId,
        imageUrl: imageUrl,
        caption: _captionController.text.trim().isEmpty ? null : _captionController.text.trim(),
        visibility: _isPublic ? 'Public' : 'Private',
      ));
      _savedOrigamiIds.add(_origamiId);
      galleryTabRefresh.value++;
      if (mounted) context.goNamed(RouteNames.myGallery);
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

  Future<void> _handleGenerateLink() async {
    setState(() => _isSaving = true);
    try {
      final imageUrl = await _uploadImageIfNeeded();
      final createUseCase = getIt<CreateGalleryUseCase>();
      final galleryItem = await createUseCase(CreateGalleryRequestDto(
        foldModelId: _origamiId,
        imageUrl: imageUrl,
        caption: _captionController.text.trim().isEmpty ? null : _captionController.text.trim(),
        visibility: _isPublic ? 'Public' : 'Private',
      ));
      _savedOrigamiIds.add(_origamiId);
      galleryTabRefresh.value++;
      if (mounted) {
        context.pushNamed(
          RouteNames.generateShareLink,
          pathParameters: {'creationId': galleryItem.id},
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.toString()),
          backgroundColor: AppColors.danger,
        ));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final origami = _origami;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xl),
              const Icon(
                Icons.stars_rounded,
                color: AppColors.warning,
                size: 64,
              ),
              const SizedBox(height: AppSpacing.md),
              const Text(
                'Masterpiece Completed!',
                style: AppTextStyles.display,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Tappable Image Area
              GestureDetector(
                onTap: _showImageSourceSheet,
                child: ClipRRect(
                  borderRadius: AppRadius.large,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!, fit: BoxFit.cover)
                        : Container(
                            color: AppColors.surfaceMuted,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.add_a_photo_outlined,
                                  size: 64,
                                  color: AppColors.textDisabled,
                                ),
                                const SizedBox(height: AppSpacing.sm),
                                Text(
                                  'Tap to add your photo',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Completion Summary
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    children: [
                      _buildSummaryRow('Model', origami?.name ?? 'Origami'),
                      const Divider(height: AppSpacing.xl),
                      _buildSummaryRow('Category', origami?.category ?? ''),
                      const Divider(height: AppSpacing.xl),
                      _buildSummaryRow('Date', 'Today'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Caption field
              TextField(
                controller: _captionController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'Add a caption (optional)...',
                  filled: true,
                  fillColor: AppColors.surfaceWhite,
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.medium,
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppRadius.medium,
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              // Visibility Setting Card
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Share to Community',
                            style: AppTextStyles.labelLarge,
                          ),
                          Switch(
                            value: _isPublic,
                            onChanged: (value) {
                              setState(() {
                                _isPublic = value;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      Text(
                        _isPublic
                            ? 'Your creation will be visible in the Community Gallery.'
                            : 'This creation is private. Only you can see it in your Gallery, unless you share the link.',
                        style: AppTextStyles.bodySmall,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxl),

              if (_savedOrigamiIds.contains(_origamiId)) ...[  
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(
                    color: AppColors.success.withValues(alpha: 0.1),
                    borderRadius: AppRadius.medium,
                    border: Border.all(color: AppColors.success.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.check_circle, color: AppColors.success),
                      const SizedBox(width: AppSpacing.sm),
                      const Expanded(
                        child: Text(
                          'Already saved to your Gallery.',
                          style: AppTextStyles.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ] else ...[
                PrimaryButton(
                  label: 'Save Creation',
                  onPressed: _isSaving ? null : _handleSave,
                  isLoading: _isSaving,
                ),
                const SizedBox(height: AppSpacing.md),
                SecondaryButton(
                  label: 'Generate Share Link',
                  onPressed: _isSaving ? null : _handleGenerateLink,
                ),
              ],
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.goNamed(RouteNames.home),
                child: const Text('Continue Journey'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: AppTextStyles.caption),
        Text(value, style: AppTextStyles.label),
      ],
    );
  }
}
