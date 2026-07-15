import 'package:equatable/equatable.dart';
import '../../domain/entities/follow_user.dart';

abstract class FollowState extends Equatable {
  const FollowState();
  @override
  List<Object?> get props => [];
}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowLoaded extends FollowState {
  final List<FollowUser> users;
  final int currentPage;
  final bool hasReachedMax;

  const FollowLoaded({
    required this.users,
    required this.currentPage,
    required this.hasReachedMax,
  });

  FollowLoaded copyWith({
    List<FollowUser>? users,
    int? currentPage,
    bool? hasReachedMax,
  }) {
    return FollowLoaded(
      users: users ?? this.users,
      currentPage: currentPage ?? this.currentPage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object?> get props => [users, currentPage, hasReachedMax];
}

class FollowLoadingMore extends FollowLoaded {
  const FollowLoadingMore({
    required super.users,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class FollowRefreshing extends FollowLoaded {
  const FollowRefreshing({
    required super.users,
    required super.currentPage,
    required super.hasReachedMax,
  });
}

class FollowingUser extends FollowLoaded {
  final String targetUserId;
  const FollowingUser({
    required super.users,
    required super.currentPage,
    required super.hasReachedMax,
    required this.targetUserId,
  });
  @override
  List<Object?> get props => [users, currentPage, hasReachedMax, targetUserId];
}

class UnfollowingUser extends FollowLoaded {
  final String targetUserId;
  const UnfollowingUser({
    required super.users,
    required super.currentPage,
    required super.hasReachedMax,
    required this.targetUserId,
  });
  @override
  List<Object?> get props => [users, currentPage, hasReachedMax, targetUserId];
}

class FollowEmpty extends FollowState {}

class FollowError extends FollowState {
  final String message;
  const FollowError(this.message);
  @override
  List<Object?> get props => [message];
}

class FollowErrorLoadingMore extends FollowLoaded {
  final String message;
  const FollowErrorLoadingMore({
    required super.users,
    required super.currentPage,
    required super.hasReachedMax,
    required this.message,
  });

  @override
  List<Object?> get props => [users, currentPage, hasReachedMax, message];
}
