import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';
import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_header.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/dto/gallery_request_dto.dart';
import '../../domain/usecases/get_gallery.dart';
import '../../domain/entities/gallery_item.dart';
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';

class EditGalleryPage extends StatefulWidget {
  final String creationId;
  const EditGalleryPage({super.key, required this.creationId});

  @override
  State<EditGalleryPage> createState() => _EditGalleryPageState();
}

class _EditGalleryPageState extends State<EditGalleryPage> {
  final _captionController = TextEditingController();
  final _foldModelIdController = TextEditingController();
  bool _isPublic = true;
  File? _selectedImage;
  GalleryItem? _item;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadItem();
  }

  Future<void> _loadItem() async {
    try {
      final item = await getIt<GetGalleryUseCase>().detail(widget.creationId);
      if (mounted) {
        setState(() {
          _item = item;
          _captionController.text = item.caption ?? '';
          _foldModelIdController.text = item.origamiModelId ?? '';
          _isPublic = item.visibility == 'Public';
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

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
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

      if (croppedFile != null) {
        setState(() {
          _selectedImage = File(croppedFile.path);
        });
      }
    }
  }

  void _onSave(BuildContext context) {
    final foldModelId = _foldModelIdController.text.trim();
    final request = UpdateGalleryRequestDto(
      caption: _captionController.text.trim(),
      visibility: _isPublic ? 'Public' : 'Private',
      foldModelId: foldModelId.isEmpty ? null : foldModelId,
    );
    context.read<GalleryBloc>().add(UpdateGallery(id: widget.creationId, request: request, newImageFile: _selectedImage));
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(title: 'Edit Creation'),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_item == null) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(title: 'Edit Creation'),
        body: Center(child: Text('Creation not found')),
      );
    }

    return BlocProvider(
      create: (context) => getIt<GalleryBloc>(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: const AppHeader(title: 'Edit Creation'),
        body: BlocConsumer<GalleryBloc, GalleryState>(
          listener: (context, state) {
            if (state is GalleryActionSuccess) {
              galleryTabRefresh.value++;
              context.pop();
            } else if (state is GalleryActionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: AppColors.danger),
              );
            }
          },
          builder: (context, state) {
            final isUpdating = state is GalleryUpdating;
            
            return SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: isUpdating ? null : _pickImage,
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(AppSpacing.md),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: _selectedImage != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(AppSpacing.md),
                              child: Image.file(_selectedImage!, fit: BoxFit.cover),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(AppSpacing.md),
                              child: Image.network(_item!.imageUrl, fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const Center(child: Text('Tap image to change', style: TextStyle(color: AppColors.textSecondary, fontSize: 12))),
                  const SizedBox(height: AppSpacing.lg),
                  
                  TextField(
                    controller: _captionController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Caption (Optional)',
                      border: OutlineInputBorder(),
                    ),
                    enabled: !isUpdating,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  
                  SwitchListTile(
                    title: const Text('Public Visibility'),
                    subtitle: const Text('Allow others to see this creation in Community Gallery'),
                    value: _isPublic,
                    onChanged: isUpdating ? null : (value) => setState(() => _isPublic = value),
                    contentPadding: EdgeInsets.zero,
                  ),
                  
                  const SizedBox(height: AppSpacing.xxl),
                  PrimaryButton(
                    label: isUpdating ? 'Saving...' : 'Save Changes',
                    onPressed: isUpdating ? null : () => _onSave(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

