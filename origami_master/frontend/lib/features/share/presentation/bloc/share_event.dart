import 'package:equatable/equatable.dart';

abstract class ShareEvent extends Equatable {
  const ShareEvent();
  @override
  List<Object?> get props => [];
}

class GenerateShareLink extends ShareEvent {
  final String galleryId;
  const GenerateShareLink(this.galleryId);
  @override
  List<Object?> get props => [galleryId];
}

class LoadShareLinks extends ShareEvent {}

class DeleteShareLink extends ShareEvent {
  final String shareId;
  const DeleteShareLink(this.shareId);
  @override
  List<Object?> get props => [shareId];
}

class LoadSharedCreation extends ShareEvent {
  final String token;
  const LoadSharedCreation(this.token);
  @override
  List<Object?> get props => [token];
}

class ToggleShareLink extends ShareEvent {
  final String shareId;
  const ToggleShareLink(this.shareId);
  @override
  List<Object?> get props => [shareId];
}
