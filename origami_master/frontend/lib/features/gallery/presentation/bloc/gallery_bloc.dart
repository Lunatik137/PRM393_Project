import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'gallery_event.dart';
import 'gallery_state.dart';
import '../../domain/usecases/get_gallery.dart';
import '../../domain/usecases/get_my_posts_gallery.dart';
import '../../domain/usecases/create_gallery.dart';
import '../../domain/usecases/update_gallery.dart';
import '../../domain/usecases/delete_gallery.dart';
import '../../domain/usecases/update_visibility.dart';
import '../../../upload/domain/usecases/upload_image.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../data/dto/gallery_request_dto.dart';
import '../../domain/entities/gallery_item.dart';

const int _pageSize = 20;

@injectable
class GalleryBloc extends Bloc<GalleryEvent, GalleryState> {
  final GetGalleryUseCase _getGallery;
  final GetMyPostsGalleryUseCase _getMyPostsGallery;
  final CreateGalleryUseCase _createGallery;
  final UpdateGalleryUseCase _updateGallery;
  final DeleteGalleryUseCase _deleteGallery;
  final UpdateVisibilityUseCase _updateVisibility;
  final UploadImageUseCase _uploadImage;

  GalleryBloc(
    this._getGallery,
    this._getMyPostsGallery,
    this._createGallery,
    this._updateGallery,
    this._deleteGallery,
    this._updateVisibility,
    this._uploadImage,
  ) : super(GalleryInitial()) {
    on<LoadGallery>(_onLoadGallery);
    on<RefreshGallery>(_onRefreshGallery);
    on<LoadMoreGallery>(_onLoadMoreGallery);
    on<CreateGallery>(_onCreateGallery);
    on<UpdateGallery>(_onUpdateGallery);
    on<DeleteGallery>(_onDeleteGallery);
    on<UpdateVisibility>(_onUpdateVisibility);
  }

  Future<void> _onLoadGallery(LoadGallery event, Emitter<GalleryState> emit) async {
    emit(GalleryLoading());
    try {
      final pagination = event.isPostsTab 
          ? await _getMyPostsGallery(1, _pageSize) 
          : await _getGallery(1, _pageSize);
      
      if (pagination.items.isEmpty) {
        emit(GalleryEmpty());
      } else {
        emit(GalleryLoaded(
          items: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
          isPostsTab: event.isPostsTab,
        ));
      }
    } on AppException catch (e) {
      emit(GalleryError(e.message));
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }

  Future<void> _onRefreshGallery(RefreshGallery event, Emitter<GalleryState> emit) async {
    bool isPostsTab = false;
    if (state is GalleryLoaded) {
      final st = state as GalleryLoaded;
      isPostsTab = st.isPostsTab;
      emit(GalleryRefreshing(
        items: st.items,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        isPostsTab: st.isPostsTab,
      ));
    } else {
      emit(GalleryLoading());
    }

    try {
      final pagination = isPostsTab 
          ? await _getMyPostsGallery(1, _pageSize) 
          : await _getGallery(1, _pageSize);
          
      if (pagination.items.isEmpty) {
        emit(GalleryEmpty());
      } else {
        emit(GalleryLoaded(
          items: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
          isPostsTab: isPostsTab,
        ));
      }
    } on AppException catch (e) {
      emit(GalleryError(e.message));
    } catch (e) {
      emit(GalleryError(e.toString()));
    }
  }

  Future<void> _onLoadMoreGallery(LoadMoreGallery event, Emitter<GalleryState> emit) async {
    if (state is GalleryLoadingMore || state is GalleryRefreshing) return;
    
    if (state is GalleryLoaded) {
      final st = state as GalleryLoaded;
      if (st.hasReachedMax) return;

      final nextPage = st.currentPage + 1;
      emit(GalleryLoadingMore(
        items: st.items,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        isPostsTab: st.isPostsTab,
      ));

      try {
        final pagination = st.isPostsTab 
            ? await _getMyPostsGallery(nextPage, _pageSize) 
            : await _getGallery(nextPage, _pageSize);
            
        emit(GalleryLoaded(
          items: List.of(st.items)..addAll(pagination.items),
          currentPage: nextPage,
          hasReachedMax: !pagination.hasMore,
          isPostsTab: st.isPostsTab,
        ));
      } catch (e) {
        emit(GalleryErrorLoadingMore(
          items: st.items,
          currentPage: st.currentPage,
          hasReachedMax: st.hasReachedMax,
          isPostsTab: st.isPostsTab,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
    }
  }

  Future<void> _onCreateGallery(CreateGallery event, Emitter<GalleryState> emit) async {
    if (state is! GalleryLoaded && state is! GalleryEmpty) return;
    
    final currentItems = state is GalleryLoaded ? (state as GalleryLoaded).items : <GalleryItem>[];
    final currentPage = state is GalleryLoaded ? (state as GalleryLoaded).currentPage : 1;
    final hasReachedMax = state is GalleryLoaded ? (state as GalleryLoaded).hasReachedMax : true;

    emit(GalleryCreating(
      items: currentItems,
      currentPage: currentPage,
      hasReachedMax: hasReachedMax,
    ));

    try {
      String imageUrl = event.request.imageUrl;
      if (event.imageFile != null) {
        final uploaded = await _uploadImage(event.imageFile!);
        imageUrl = uploaded.imageUrl;
      }

      final request = CreateGalleryRequestDto(
        foldModelId: event.request.foldModelId,
        imageUrl: imageUrl,
        caption: event.request.caption,
        visibility: event.request.visibility,
      );

      final newItem = await _createGallery(request);
      
      emit(GalleryActionSuccess(
        items: [newItem, ...currentItems],
        currentPage: currentPage,
        hasReachedMax: hasReachedMax,
        message: 'Gallery item created successfully',
      ));
      
      add(RefreshGallery());
      
    } catch (e) {
      emit(GalleryActionError(
        items: currentItems,
        currentPage: currentPage,
        hasReachedMax: hasReachedMax,
        message: e is AppException ? e.message : e.toString(),
      ));
    }
  }

  Future<void> _onUpdateGallery(UpdateGallery event, Emitter<GalleryState> emit) async {
    final currentItems = state is GalleryLoaded ? (state as GalleryLoaded).items : <GalleryItem>[];
    final currentPage = state is GalleryLoaded ? (state as GalleryLoaded).currentPage : 1;
    final hasReachedMax = state is GalleryLoaded ? (state as GalleryLoaded).hasReachedMax : true;

    emit(GalleryUpdating(
      items: currentItems,
      currentPage: currentPage,
      hasReachedMax: hasReachedMax,
    ));

    try {
      String? imageUrl = event.request.imageUrl;
      if (event.newImageFile != null) {
        final uploaded = await _uploadImage(event.newImageFile!);
        imageUrl = uploaded.imageUrl;
      }

      final request = UpdateGalleryRequestDto(
        caption: event.request.caption,
        visibility: event.request.visibility,
        imageUrl: imageUrl,
        foldModelId: event.request.foldModelId,
      );

      await _updateGallery(event.id, request);

      final updatedList = currentItems.map((item) {
        if (item.id == event.id) {
          return GalleryItem(
            id: item.id,
            origamiModelId: request.foldModelId ?? item.origamiModelId,
            origamiModelName: item.origamiModelName,
            imageUrl: request.imageUrl ?? item.imageUrl,
            caption: request.caption ?? item.caption,
            difficulty: item.difficulty,
            createdAt: item.createdAt,
            visibility: request.visibility ?? item.visibility,
            isPublished: request.visibility != null ? request.visibility == 'Public' : item.isPublished,
            creatorId: item.creatorId,
            creatorName: item.creatorName,
            creatorAvatar: item.creatorAvatar,
          );
        }
        return item;
      }).toList();

      emit(GalleryActionSuccess(
        items: updatedList,
        currentPage: currentPage,
        hasReachedMax: hasReachedMax,
        message: 'Gallery item updated successfully',
      ));

    } catch (e) {
      emit(GalleryActionError(
        items: currentItems,
        currentPage: currentPage,
        hasReachedMax: hasReachedMax,
        message: e is AppException ? e.message : e.toString(),
      ));
    }
  }

  Future<void> _onDeleteGallery(DeleteGallery event, Emitter<GalleryState> emit) async {
    if (state is! GalleryLoaded) return;
    final st = state as GalleryLoaded;
    
    emit(GalleryDeleting(
      items: st.items,
      currentPage: st.currentPage,
      hasReachedMax: st.hasReachedMax,
      id: event.id,
    ));

    try {
      await _deleteGallery(event.id);
      
      final updatedList = st.items.where((item) => item.id != event.id).toList();
      
      emit(GalleryActionSuccess(
        items: updatedList,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        message: 'Gallery item deleted',
      ));

      if (updatedList.isEmpty) {
        emit(GalleryEmpty());
      }
      
    } catch (e) {
      emit(GalleryActionError(
        items: st.items,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        message: e is AppException ? e.message : e.toString(),
      ));
    }
  }

  Future<void> _onUpdateVisibility(UpdateVisibility event, Emitter<GalleryState> emit) async {
    if (state is! GalleryLoaded) return;
    final st = state as GalleryLoaded;
    
    emit(GalleryUpdating(
      items: st.items,
      currentPage: st.currentPage,
      hasReachedMax: st.hasReachedMax,
    ));

    try {
      await _updateVisibility(event.id, event.isPublic);
      
      final updatedList = st.items.map((item) {
        if (item.id == event.id) {
          return GalleryItem(
            id: item.id,
            origamiModelId: item.origamiModelId,
            origamiModelName: item.origamiModelName,
            imageUrl: item.imageUrl,
            caption: item.caption,
            difficulty: item.difficulty,
            createdAt: item.createdAt,
            visibility: event.isPublic ? 'Public' : 'Private',
            isPublished: event.isPublic,
            creatorId: item.creatorId,
            creatorName: item.creatorName,
            creatorAvatar: item.creatorAvatar,
          );
        }
        return item;
      }).toList();
      
      emit(GalleryActionSuccess(
        items: updatedList,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        message: 'Visibility updated',
      ));
      
    } catch (e) {
      emit(GalleryActionError(
        items: st.items,
        currentPage: st.currentPage,
        hasReachedMax: st.hasReachedMax,
        message: e is AppException ? e.message : e.toString(),
      ));
    }
  }
}

