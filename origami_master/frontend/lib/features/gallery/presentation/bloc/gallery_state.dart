import 'package:equatable/equatable.dart';
import '../../domain/entities/gallery_item.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();
  @override
  List<Object?> get props => [];
}

class GalleryInitial extends GalleryState {}

class GalleryLoading extends GalleryState {}

class GalleryLoaded extends GalleryState {
  final List<GalleryItem> items;
  final int currentPage;
  final bool hasReachedMax;
  final bool isPostsTab;

  const GalleryLoaded({
    required this.items,
    required this.currentPage,
    required this.hasReachedMax,
    this.isPostsTab = false,
  });

  GalleryLoaded copyWith({
    List<GalleryItem>? items,
    int? currentPage,
    bool? hasReachedMax,
    bool? isPostsTab,
  }) {
    return GalleryLoaded(
      items: items ?? this.items,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      isPostsTab: isPostsTab ?? this.isPostsTab,
    );
  }

  @override
  List<Object?> get props => [items, currentPage, hasReachedMax, isPostsTab];
}

class GalleryLoadingMore extends GalleryLoaded {
  const GalleryLoadingMore({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
  });
}

class GalleryRefreshing extends GalleryLoaded {
  const GalleryRefreshing({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
  });
}

class GalleryEmpty extends GalleryState {}

class GalleryError extends GalleryState {
  final String message;
  const GalleryError(this.message);
  @override
  List<Object?> get props => [message];
}

class GalleryErrorLoadingMore extends GalleryLoaded {
  final String message;
  const GalleryErrorLoadingMore({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
    required this.message,
  });
  @override
  List<Object?> get props => [...super.props, message];
}

class GalleryCreating extends GalleryLoaded {
  const GalleryCreating({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
  });
}

class GalleryUpdating extends GalleryLoaded {
  const GalleryUpdating({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
  });
}

class GalleryDeleting extends GalleryLoaded {
  final String id;
  const GalleryDeleting({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
    required this.id,
  });
  @override
  List<Object?> get props => [...super.props, id];
}

class GalleryActionSuccess extends GalleryLoaded {
  final String message;
  const GalleryActionSuccess({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
    required this.message,
  });
  @override
  List<Object?> get props => [...super.props, message];
}

class GalleryActionError extends GalleryLoaded {
  final String message;
  const GalleryActionError({
    required super.items,
    required super.currentPage,
    required super.hasReachedMax,
    super.isPostsTab,
    required this.message,
  });
  @override
  List<Object?> get props => [...super.props, message];
}
