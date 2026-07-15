import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'profile_event.dart';
import 'profile_state.dart';
import '../../domain/usecases/get_profile.dart';
import '../../domain/usecases/get_user_posts.dart';
import '../../../../core/services/auth_service.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../../../core/network/pagination.dart';
import '../../../home/domain/entities/feed_post.dart';
import '../../domain/entities/profile.dart';

const int _pageSize = 20;

@injectable
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase _getProfile;
  final GetUserPostsUseCase _getUserPosts;
  final AuthService _authService = AuthService.instance;

  ProfileBloc(this._getProfile, this._getUserPosts) : super(ProfileInitial()) {
    on<LoadMyProfile>(_onLoadMyProfile);
    on<LoadUserProfile>(_onLoadUserProfile);
    on<RefreshProfile>(_onRefreshProfile);
    on<LoadUserPosts>(_onLoadUserPosts);
    on<LoadMorePosts>(_onLoadMorePosts);
    on<RefreshPosts>(_onRefreshPosts);
    on<LogoutEvent>(_onLogout);
  }

  Future<void> _onLoadMyProfile(LoadMyProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _getProfile.getMyProfile();
      final postsPagination = await _getUserPosts(profile.id, 1, _pageSize);
      _emitLoaded(emit, profile, postsPagination, true);
    } on AppException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onLoadUserProfile(LoadUserProfile event, Emitter<ProfileState> emit) async {
    emit(ProfileLoading());
    try {
      final profile = await _getProfile.getUserProfile(event.userId);
      final postsPagination = await _getUserPosts(event.userId, 1, _pageSize);
      _emitLoaded(emit, profile, postsPagination, event.isMyProfile);
    } on AppException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  void _emitLoaded(Emitter<ProfileState> emit, Profile profile, Pagination<FeedPost> postsPagination, bool isMyProfile) {
    if (postsPagination.items.isEmpty) {
      emit(ProfileEmptyPosts(
        profile: profile,
        posts: const [],
        currentPostsPage: 1,
        hasReachedMaxPosts: true,
        isMyProfile: isMyProfile,
      ));
    } else {
      emit(ProfileLoaded(
        profile: profile,
        posts: postsPagination.items,
        currentPostsPage: 1,
        hasReachedMaxPosts: !postsPagination.hasMore,
        isMyProfile: isMyProfile,
      ));
    }
  }

  Future<void> _onRefreshProfile(RefreshProfile event, Emitter<ProfileState> emit) async {
    if (state is! ProfileLoaded) {
      emit(ProfileLoading());
    } else {
      final st = state as ProfileLoaded;
      emit(ProfileRefreshing(
        profile: st.profile,
        posts: st.posts,
        currentPostsPage: st.currentPostsPage,
        hasReachedMaxPosts: st.hasReachedMaxPosts,
        isMyProfile: st.isMyProfile,
      ));
    }

    try {
      final isMyProfile = event.userId == null || (state is ProfileLoaded && (state as ProfileLoaded).isMyProfile);
      final profile = isMyProfile ? await _getProfile.getMyProfile() : await _getProfile.getUserProfile(event.userId!);
      final postsPagination = await _getUserPosts(profile.id, 1, _pageSize);
      
      _emitLoaded(emit, profile, postsPagination, isMyProfile);
    } on AppException catch (e) {
      emit(ProfileError(e.message));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> _onLoadUserPosts(LoadUserPosts event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoaded) {
      final st = state as ProfileLoaded;
      emit(ProfileRefreshing(
        profile: st.profile,
        posts: st.posts,
        currentPostsPage: st.currentPostsPage,
        hasReachedMaxPosts: st.hasReachedMaxPosts,
        isMyProfile: st.isMyProfile,
      ));
      
      try {
        final postsPagination = await _getUserPosts(event.userId, 1, _pageSize);
        _emitLoaded(emit, st.profile, postsPagination, st.isMyProfile);
      } catch (e) {
        emit(ProfileLoaded(
          profile: st.profile,
          posts: st.posts,
          currentPostsPage: st.currentPostsPage,
          hasReachedMaxPosts: st.hasReachedMaxPosts,
          isMyProfile: st.isMyProfile,
        ));
      }
    }
  }

  Future<void> _onLoadMorePosts(LoadMorePosts event, Emitter<ProfileState> emit) async {
    if (state is ProfileLoadingMorePosts || state is ProfileRefreshing) return;
    
    if (state is ProfileLoaded) {
      final st = state as ProfileLoaded;
      if (st.hasReachedMaxPosts) return;

      final nextPage = st.currentPostsPage + 1;
      emit(ProfileLoadingMorePosts(
        profile: st.profile,
        posts: st.posts,
        currentPostsPage: st.currentPostsPage,
        hasReachedMaxPosts: st.hasReachedMaxPosts,
        isMyProfile: st.isMyProfile,
      ));

      try {
        final postsPagination = await _getUserPosts(event.userId, nextPage, _pageSize);
        emit(ProfileLoaded(
          profile: st.profile,
          posts: List.of(st.posts)..addAll(postsPagination.items),
          currentPostsPage: nextPage,
          hasReachedMaxPosts: !postsPagination.hasMore,
          isMyProfile: st.isMyProfile,
        ));
      } catch (e) {
        emit(ProfileErrorLoadingMorePosts(
          profile: st.profile,
          posts: st.posts,
          currentPostsPage: st.currentPostsPage,
          hasReachedMaxPosts: st.hasReachedMaxPosts,
          isMyProfile: st.isMyProfile,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
    }
  }

  Future<void> _onRefreshPosts(RefreshPosts event, Emitter<ProfileState> emit) async {
    add(LoadUserPosts(event.userId));
  }

  Future<void> _onLogout(LogoutEvent event, Emitter<ProfileState> emit) async {
    await _authService.logout();
    emit(ProfileLogoutSuccess());
  }
}

