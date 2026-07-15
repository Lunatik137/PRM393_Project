import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'follow_event.dart';
import 'follow_state.dart';
import '../../domain/usecases/follow_user.dart';
import '../../domain/usecases/unfollow_user.dart';
import '../../domain/usecases/get_followers.dart';
import '../../domain/usecases/get_following.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../domain/entities/follow_user.dart';

const int _pageSize = 20;

@injectable
class FollowBloc extends Bloc<FollowEvent, FollowState> {
  final FollowUserUseCase _followUser;
  final UnfollowUserUseCase _unfollowUser;
  final GetFollowersUseCase _getFollowers;
  final GetFollowingUseCase _getFollowing;

  FollowBloc(
    this._followUser,
    this._unfollowUser,
    this._getFollowers,
    this._getFollowing,
  ) : super(FollowInitial()) {
    on<FollowUserEvent>(_onFollowUser);
    on<UnfollowUserEvent>(_onUnfollowUser);
    on<LoadFollowers>(_onLoadFollowers);
    on<LoadFollowing>(_onLoadFollowing);
    on<LoadMoreFollowers>(_onLoadMoreFollowers);
    on<LoadMoreFollowing>(_onLoadMoreFollowing);
    on<RefreshFollowers>(_onRefreshFollowers);
    on<RefreshFollowing>(_onRefreshFollowing);
  }

  Future<void> _onFollowUser(FollowUserEvent event, Emitter<FollowState> emit) async {
    List<FollowUser> currentUsers = [];
    int currentPg = 1;
    bool reachedMax = true;

    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      currentUsers = List.from(st.users);
      currentPg = st.currentPage;
      reachedMax = st.hasReachedMax;

      final index = currentUsers.indexWhere((u) => u.id == event.userId);
      if (index != -1) {
        currentUsers[index] = currentUsers[index].copyWith(isFollowing: true);
      }
    }

    emit(FollowingUser(
      users: currentUsers,
      currentPage: currentPg,
      hasReachedMax: reachedMax,
      targetUserId: event.userId,
    ));

    try {
      await _followUser(event.userId);
      if (state is FollowLoaded) {
        emit(FollowLoaded(
          users: currentUsers,
          currentPage: currentPg,
          hasReachedMax: reachedMax,
        ));
      } else {
        emit(FollowInitial());
      }
    } catch (e) {
      if (state is FollowLoaded) {
        final index = currentUsers.indexWhere((u) => u.id == event.userId);
        if (index != -1) {
          currentUsers[index] = currentUsers[index].copyWith(isFollowing: false);
        }
        emit(FollowLoaded(
          users: currentUsers,
          currentPage: currentPg,
          hasReachedMax: reachedMax,
        ));
      } else {
        emit(FollowInitial());
      }
    }
  }

  Future<void> _onUnfollowUser(UnfollowUserEvent event, Emitter<FollowState> emit) async {
    List<FollowUser> currentUsers = [];
    int currentPg = 1;
    bool reachedMax = true;

    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      currentUsers = List.from(st.users);
      currentPg = st.currentPage;
      reachedMax = st.hasReachedMax;

      final index = currentUsers.indexWhere((u) => u.id == event.userId);
      if (index != -1) {
        currentUsers[index] = currentUsers[index].copyWith(isFollowing: false);
      }
    }

    emit(UnfollowingUser(
      users: currentUsers,
      currentPage: currentPg,
      hasReachedMax: reachedMax,
      targetUserId: event.userId,
    ));

    try {
      await _unfollowUser(event.userId);
      if (state is FollowLoaded) {
        emit(FollowLoaded(
          users: currentUsers,
          currentPage: currentPg,
          hasReachedMax: reachedMax,
        ));
      } else {
        emit(FollowInitial());
      }
    } catch (e) {
      if (state is FollowLoaded) {
        final index = currentUsers.indexWhere((u) => u.id == event.userId);
        if (index != -1) {
          currentUsers[index] = currentUsers[index].copyWith(isFollowing: true);
        }
        emit(FollowLoaded(
          users: currentUsers,
          currentPage: currentPg,
          hasReachedMax: reachedMax,
        ));
      } else {
        emit(FollowInitial());
      }
    }
  }

  Future<void> _onLoadFollowers(LoadFollowers event, Emitter<FollowState> emit) async {
    emit(FollowLoading());
    try {
      final pagination = await _getFollowers(event.userId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FollowEmpty());
      } else {
        emit(FollowLoaded(
          users: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(FollowError(e.message));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

  Future<void> _onLoadFollowing(LoadFollowing event, Emitter<FollowState> emit) async {
    emit(FollowLoading());
    try {
      final pagination = await _getFollowing(event.userId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FollowEmpty());
      } else {
        emit(FollowLoaded(
          users: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(FollowError(e.message));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

  Future<void> _onRefreshFollowers(RefreshFollowers event, Emitter<FollowState> emit) async {
    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      emit(FollowRefreshing(users: st.users, currentPage: st.currentPage, hasReachedMax: st.hasReachedMax));
    } else {
      emit(FollowLoading());
    }

    try {
      final pagination = await _getFollowers(event.userId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FollowEmpty());
      } else {
        emit(FollowLoaded(
          users: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(FollowError(e.message));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

  Future<void> _onRefreshFollowing(RefreshFollowing event, Emitter<FollowState> emit) async {
    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      emit(FollowRefreshing(users: st.users, currentPage: st.currentPage, hasReachedMax: st.hasReachedMax));
    } else {
      emit(FollowLoading());
    }

    try {
      final pagination = await _getFollowing(event.userId, 1, _pageSize);
      if (pagination.items.isEmpty) {
        emit(FollowEmpty());
      } else {
        emit(FollowLoaded(
          users: pagination.items,
          currentPage: 1,
          hasReachedMax: !pagination.hasMore,
        ));
      }
    } on AppException catch (e) {
      emit(FollowError(e.message));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }

  Future<void> _onLoadMoreFollowers(LoadMoreFollowers event, Emitter<FollowState> emit) async {
    if (state is FollowLoadingMore || state is FollowRefreshing || state is FollowErrorLoadingMore) {
      if (state is! FollowErrorLoadingMore) return;
    }

    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      if (st.hasReachedMax) return;

      final nextPage = st.currentPage + 1;
      emit(FollowLoadingMore(users: st.users, currentPage: st.currentPage, hasReachedMax: st.hasReachedMax));

      try {
        final pagination = await _getFollowers(event.userId, nextPage, _pageSize);
        emit(FollowLoaded(
          users: List.of(st.users)..addAll(pagination.items),
          currentPage: nextPage,
          hasReachedMax: !pagination.hasMore,
        ));
      } catch (e) {
        emit(FollowErrorLoadingMore(
          users: st.users,
          currentPage: st.currentPage,
          hasReachedMax: st.hasReachedMax,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
    }
  }

  Future<void> _onLoadMoreFollowing(LoadMoreFollowing event, Emitter<FollowState> emit) async {
    if (state is FollowLoadingMore || state is FollowRefreshing || state is FollowErrorLoadingMore) {
      if (state is! FollowErrorLoadingMore) return;
    }

    if (state is FollowLoaded) {
      final st = state as FollowLoaded;
      if (st.hasReachedMax) return;

      final nextPage = st.currentPage + 1;
      emit(FollowLoadingMore(users: st.users, currentPage: st.currentPage, hasReachedMax: st.hasReachedMax));

      try {
        final pagination = await _getFollowing(event.userId, nextPage, _pageSize);
        emit(FollowLoaded(
          users: List.of(st.users)..addAll(pagination.items),
          currentPage: nextPage,
          hasReachedMax: !pagination.hasMore,
        ));
      } catch (e) {
        emit(FollowErrorLoadingMore(
          users: st.users,
          currentPage: st.currentPage,
          hasReachedMax: st.hasReachedMax,
          message: e is AppException ? e.message : e.toString(),
        ));
      }
    }
  }
}

