import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'upload_event.dart';
import 'upload_state.dart';
import '../../domain/usecases/upload_image.dart';

@injectable
class UploadBloc extends Bloc<UploadEvent, UploadState> {
  final UploadImageUseCase _uploadImage;
  final ImagePicker _picker = ImagePicker();

  UploadBloc(this._uploadImage) : super(UploadInitial()) {
    on<PickFromGallery>(_onPickFromGallery);
    on<TakePhoto>(_onTakePhoto);
    on<UploadImage>(_onUploadImage);
    on<RetryUpload>(_onRetryUpload);
    on<ClearSelection>(_onClearSelection);
  }

  Future<void> _onPickFromGallery(PickFromGallery event, Emitter<UploadState> emit) async {
    emit(UploadSelecting());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        emit(UploadPreview(File(image.path)));
      } else {
        emit(UploadInitial());
      }
    } catch (e) {
      emit(UploadFailed('Failed to pick image: ${e.toString()}'));
    }
  }

  Future<void> _onTakePhoto(TakePhoto event, Emitter<UploadState> emit) async {
    emit(UploadSelecting());
    try {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        emit(UploadPreview(File(image.path)));
      } else {
        emit(UploadInitial());
      }
    } catch (e) {
      emit(UploadFailed('Failed to take photo: ${e.toString()}'));
    }
  }

  Future<void> _onUploadImage(UploadImage event, Emitter<UploadState> emit) async {
    emit(Uploading());
    try {
      final file = event.file;
      
      final length = await file.length();
      if (length > 5 * 1024 * 1024) {
        emit(UploadFailed('File size exceeds 5MB limit.', lastFile: file));
        return;
      }

      final lastDotIndex = file.path.lastIndexOf('.');
      final outPath = '${file.path.substring(0, lastDotIndex)}_compressed.jpg';
      var resultFile = file;

      if (length > 500 * 1024) {
        final compressed = await FlutterImageCompress.compressAndGetFile(
          file.path,
          outPath,
          minWidth: 1920,
          minHeight: 1920,
          quality: 85,
        );
        if (compressed != null) {
          resultFile = File(compressed.path);
        }
      }

      final uploadedImage = await _uploadImage(resultFile);
      emit(UploadSuccess(uploadedImage));
    } catch (e) {
      emit(UploadFailed(e.toString(), lastFile: event.file));
    }
  }

  Future<void> _onRetryUpload(RetryUpload event, Emitter<UploadState> emit) async {
    final currentState = state;
    if (currentState is UploadFailed && currentState.lastFile != null) {
      add(UploadImage(currentState.lastFile!));
    }
  }

  Future<void> _onClearSelection(ClearSelection event, Emitter<UploadState> emit) async {
    emit(UploadInitial());
  }
}

