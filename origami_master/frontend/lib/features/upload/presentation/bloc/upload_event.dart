import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class UploadEvent extends Equatable {
  const UploadEvent();
  @override
  List<Object?> get props => [];
}

class PickFromGallery extends UploadEvent {}

class TakePhoto extends UploadEvent {}

class UploadImage extends UploadEvent {
  final File file;
  const UploadImage(this.file);
  @override
  List<Object?> get props => [file];
}

class RetryUpload extends UploadEvent {}

class ClearSelection extends UploadEvent {}
