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
import '../bloc/gallery_bloc.dart';
import '../bloc/gallery_event.dart';
import '../bloc/gallery_state.dart';
import '../../../../core/utils/tab_refresh_notifier.dart';

class CreateGalleryPage extends StatelessWidget {
  const CreateGalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<GalleryBloc>(),
      child: const CreateGalleryView(),
    );
  }
}

class CreateGalleryView extends StatefulWidget {
  const CreateGalleryView({super.key});

  @override
  State<CreateGalleryView> createState() => _CreateGalleryViewState();
}

class _CreateGalleryViewState extends State<CreateGalleryView> {
  final _captionController = TextEditingController();
  final _foldModelIdController = TextEditingController();
  String _difficulty = 'Beginner';
  bool _isPublic = true;
  File? _selectedImage;

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

  void _onCreate() {
    final foldModelId = _foldModelIdController.text.trim();
    final request = CreateGalleryRequestDto(
      caption: _captionController.text.trim(),
      visibility: _isPublic ? 'Public' : 'Private',
      foldModelId: foldModelId.isEmpty ? null : foldModelId,
      imageUrl: '', // Will be replaced by bloc
    );

    context.read<GalleryBloc>().add(CreateGallery(request: request, imageFile: _selectedImage));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'New Creation'),
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
          final isCreating = state is GalleryCreating;
          
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: isCreating ? null : _pickImage,
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
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: AppColors.textDisabled),
                              SizedBox(height: AppSpacing.sm),
                              Text('Tap to select image', style: TextStyle(color: AppColors.textSecondary)),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                
                TextField(
                  controller: _foldModelIdController,
                  decoration: const InputDecoration(
                    labelText: 'Fold Model ID (Demo)',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !isCreating,
                ),
                const SizedBox(height: AppSpacing.md),
                
                TextField(
                  controller: _captionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Caption (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  enabled: !isCreating,
                ),
                const SizedBox(height: AppSpacing.md),
                
                DropdownButtonFormField<String>(
                  value: _difficulty,
                  decoration: const InputDecoration(
                    labelText: 'Difficulty',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(value: 'Beginner', child: Text('Beginner')),
                    DropdownMenuItem(value: 'Intermediate', child: Text('Intermediate')),
                    DropdownMenuItem(value: 'Advanced', child: Text('Advanced')),
                  ],
                  onChanged: isCreating ? null : (value) {
                    if (value != null) setState(() => _difficulty = value);
                  },
                ),
                const SizedBox(height: AppSpacing.md),
                
                SwitchListTile(
                  title: const Text('Public Visibility'),
                  subtitle: const Text('Allow others to see this creation on your profile'),
                  value: _isPublic,
                  onChanged: isCreating ? null : (value) => setState(() => _isPublic = value),
                  contentPadding: EdgeInsets.zero,
                ),
                
                const SizedBox(height: AppSpacing.xxl),
                PrimaryButton(
                  label: isCreating ? 'Creating...' : 'Create Masterpiece',
                  onPressed: isCreating ? null : _onCreate,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

