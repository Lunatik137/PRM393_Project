import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/upload_bloc.dart';
import '../bloc/upload_event.dart';

class ImagePreview extends StatelessWidget {
  final File? localFile;
  final String? remoteUrl;
  final VoidCallback? onRemove;
  final VoidCallback? onChange;

  const ImagePreview({
    super.key,
    this.localFile,
    this.remoteUrl,
    this.onRemove,
    this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.hardEdge,
          child: _buildImage(),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (onChange != null)
              ElevatedButton.icon(
                onPressed: onChange,
                icon: const Icon(Icons.change_circle),
                label: const Text('Change'),
              ),
            if (onChange != null && onRemove != null) const SizedBox(width: 16),
            if (onRemove != null)
              OutlinedButton.icon(
                onPressed: () {
                  context.read<UploadBloc>().add(ClearSelection());
                  onRemove?.call();
                },
                icon: const Icon(Icons.delete, color: Colors.red),
                label: const Text('Remove', style: TextStyle(color: Colors.red)),
              ),
          ],
        )
      ],
    );
  }

  Widget _buildImage() {
    if (localFile != null) {
      return Image.file(localFile!, fit: BoxFit.cover);
    } else if (remoteUrl != null && remoteUrl!.isNotEmpty) {
      return Image.network(
        remoteUrl!,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(Icons.broken_image, size: 50),
      );
    }
    return const Icon(Icons.image, size: 50, color: Colors.grey);
  }
}
