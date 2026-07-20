import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_spacing.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../core/theme/app_radius.dart';

class CommentInput extends StatefulWidget {
  final void Function(String text, String? imagePath) onSend;
  final bool isSending;

  const CommentInput({super.key, required this.onSend, this.isSending = false});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  final _controller = TextEditingController();
  String? _selectedImagePath;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _selectedImagePath = pickedFile.path;
      });
    }
  }

  void _submit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty || _selectedImagePath != null) {
      widget.onSend(text, _selectedImagePath);
      _controller.clear();
      setState(() {
        _selectedImagePath = null;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(top: BorderSide(color: AppColors.divider)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_selectedImagePath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.sm),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppSpacing.sm),
                      child: Image.file(
                        File(_selectedImagePath!),
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => setState(() => _selectedImagePath = null),
                      child: Container(
                        margin: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                          color: Colors.black54,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.close, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.image_outlined),
                color: AppColors.textSecondary,
                onPressed: _pickImage,
              ),
              const SizedBox(width: AppSpacing.xs),
              Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Add a comment...',
                hintStyle: AppTextStyles.body.copyWith(
                  color: AppColors.textDisabled,
                ),
                filled: true,
                fillColor: AppColors.surfaceMuted,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  borderSide: BorderSide.none,
                ),
              ),
              maxLines: null,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => _submit(),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          widget.isSending
              ? const Padding(
                  padding: EdgeInsets.all(AppSpacing.sm),
                  child: SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : IconButton(
                  icon: const Icon(Icons.send),
                  color: AppColors.primary,
                  onPressed: _submit,
                ),
        ],
      ),
    ],
  ),
);
  }
}
