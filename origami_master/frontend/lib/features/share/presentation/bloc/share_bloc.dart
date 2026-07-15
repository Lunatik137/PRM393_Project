import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'share_event.dart';
import 'share_state.dart';
import '../../domain/usecases/generate_share_link.dart';
import '../../domain/usecases/get_shared_links.dart';
import '../../domain/usecases/delete_share_link.dart';
import '../../domain/usecases/toggle_share_link.dart';
import '../../domain/usecases/get_shared_creation.dart';
import '../../../../core/network/exceptions/app_exception.dart';

@injectable
class ShareBloc extends Bloc<ShareEvent, ShareState> {
  final GenerateShareLinkUseCase _generateShareLink;
  final GetSharedLinksUseCase _getSharedLinks;
  final DeleteShareLinkUseCase _deleteShareLink;
  final ToggleShareLinkUseCase _toggleShareLink;
  final GetSharedCreationUseCase _getSharedCreation;

  ShareBloc(
    this._generateShareLink,
    this._getSharedLinks,
    this._deleteShareLink,
    this._toggleShareLink,
    this._getSharedCreation,
  ) : super(ShareInitial()) {
    on<GenerateShareLink>(_onGenerateShareLink);
    on<LoadShareLinks>(_onLoadShareLinks);
    on<DeleteShareLink>(_onDeleteShareLink);
    on<ToggleShareLink>(_onToggleShareLink);
    on<LoadSharedCreation>(_onLoadSharedCreation);
  }

  Future<void> _onGenerateShareLink(GenerateShareLink event, Emitter<ShareState> emit) async {
    emit(ShareGenerating());
    try {
      final link = await _generateShareLink(event.galleryId);
      emit(ShareGeneratedSuccess(link));
    } on AppException catch (e) {
      emit(ShareError(e.message));
    } catch (e) {
      emit(ShareError(e.toString()));
    }
  }

  Future<void> _onLoadShareLinks(LoadShareLinks event, Emitter<ShareState> emit) async {
    emit(ShareLoading());
    try {
      final links = await _getSharedLinks();
      emit(ShareLinksLoaded(links));
    } on AppException catch (e) {
      emit(ShareError(e.message));
    } catch (e) {
      emit(ShareError(e.toString()));
    }
  }

  Future<void> _onDeleteShareLink(DeleteShareLink event, Emitter<ShareState> emit) async {
    emit(ShareDeleting());
    try {
      await _deleteShareLink(event.shareId);
      emit(ShareDeletedSuccess());
      add(LoadShareLinks());
    } on AppException catch (e) {
      emit(ShareError(e.message));
    } catch (e) {
      emit(ShareError(e.toString()));
    }
  }

  Future<void> _onToggleShareLink(ToggleShareLink event, Emitter<ShareState> emit) async {
    emit(ShareDeleting()); // reuse loading indicator
    try {
      await _toggleShareLink(event.shareId);
      emit(ShareToggledSuccess());
      add(LoadShareLinks()); // reload to reflect updated status
    } on AppException catch (e) {
      emit(ShareError(e.message));
    } catch (e) {
      emit(ShareError(e.toString()));
    }
  }

  Future<void> _onLoadSharedCreation(LoadSharedCreation event, Emitter<ShareState> emit) async {
    emit(ShareLoading());
    try {
      final creation = await _getSharedCreation(event.token);
      emit(SharedCreationLoaded(creation));
    } on AppException catch (e) {
      emit(ShareUnavailable(e.message));
    } catch (e) {
      emit(ShareUnavailable(e.toString()));
    }
  }
}

