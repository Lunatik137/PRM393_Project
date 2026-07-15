import 'package:equatable/equatable.dart';
import '../../domain/entities/share_link.dart';
import '../../domain/entities/shared_creation.dart';

abstract class ShareState extends Equatable {
  const ShareState();
  @override
  List<Object?> get props => [];
}

class ShareInitial extends ShareState {}

class ShareLoading extends ShareState {}

class ShareLinksLoaded extends ShareState {
  final List<ShareLink> links;
  const ShareLinksLoaded(this.links);
  @override
  List<Object?> get props => [links];
}

class SharedCreationLoaded extends ShareState {
  final SharedCreation creation;
  const SharedCreationLoaded(this.creation);
  @override
  List<Object?> get props => [creation];
}

class ShareGenerating extends ShareState {}

class ShareDeleting extends ShareState {}

class ShareUnavailable extends ShareState {
  final String message;
  const ShareUnavailable(this.message);
  @override
  List<Object?> get props => [message];
}

class ShareError extends ShareState {
  final String message;
  const ShareError(this.message);
  @override
  List<Object?> get props => [message];
}

// Action Success States
class ShareGeneratedSuccess extends ShareState {
  final ShareLink link;
  const ShareGeneratedSuccess(this.link);
  @override
  List<Object?> get props => [link];
}

class ShareDeletedSuccess extends ShareState {}

class ShareToggledSuccess extends ShareState {}

