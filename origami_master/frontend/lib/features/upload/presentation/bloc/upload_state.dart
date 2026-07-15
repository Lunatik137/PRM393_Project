import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../domain/entities/uploaded_image.dart';

abstract class UploadState extends Equatable {
  const UploadState();
  @override
  List<Object?> get props => [];
}

class UploadInitial extends UploadState {}

class UploadSelecting extends UploadState {}

class UploadPreview extends UploadState {
  final File file;
  const UploadPreview(this.file);
  @override
  List<Object?> get props => [file];
}

class Uploading extends UploadState {}

class UploadSuccess extends UploadState {
  final UploadedImage image;
  const UploadSuccess(this.image);
  @override
  List<Object?> get props => [image];
}

class UploadFailed extends UploadState {
  final String message;
  final File? lastFile;
  const UploadFailed(this.message, {this.lastFile});
  @override
  List<Object?> get props => [message, lastFile];
}

class UploadCancelled extends UploadState {}
