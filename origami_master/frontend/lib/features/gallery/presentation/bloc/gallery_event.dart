import 'dart:io';
import 'package:equatable/equatable.dart';
import '../../data/dto/gallery_request_dto.dart';

abstract class GalleryEvent extends Equatable {
  const GalleryEvent();
  @override
  List<Object?> get props => [];
}

class LoadGallery extends GalleryEvent {
  final bool isPostsTab;
  const LoadGallery({this.isPostsTab = false});
  @override
  List<Object?> get props => [isPostsTab];
}

class RefreshGallery extends GalleryEvent {}

class LoadMoreGallery extends GalleryEvent {}

class CreateGallery extends GalleryEvent {
  final CreateGalleryRequestDto request;
  final File? imageFile;
  
  const CreateGallery({required this.request, this.imageFile});
  
  @override
  List<Object?> get props => [request, imageFile];
}

class UpdateGallery extends GalleryEvent {
  final String id;
  final UpdateGalleryRequestDto request;
  final File? newImageFile;

  const UpdateGallery({required this.id, required this.request, this.newImageFile});
  
  @override
  List<Object?> get props => [id, request, newImageFile];
}

class DeleteGallery extends GalleryEvent {
  final String id;
  const DeleteGallery(this.id);
  @override
  List<Object?> get props => [id];
}

class UpdateVisibility extends GalleryEvent {
  final String id;
  final bool isPublic;
  const UpdateVisibility(this.id, this.isPublic);
  @override
  List<Object?> get props => [id, isPublic];
}
