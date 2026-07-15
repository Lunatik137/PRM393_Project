import 'package:equatable/equatable.dart';

abstract class FollowEvent extends Equatable {
  const FollowEvent();
  @override
  List<Object?> get props => [];
}

class FollowUserEvent extends FollowEvent {
  final String userId;
  const FollowUserEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class UnfollowUserEvent extends FollowEvent {
  final String userId;
  const UnfollowUserEvent(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadFollowers extends FollowEvent {
  final String userId;
  const LoadFollowers(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadFollowing extends FollowEvent {
  final String userId;
  const LoadFollowing(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadMoreFollowers extends FollowEvent {
  final String userId;
  const LoadMoreFollowers(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadMoreFollowing extends FollowEvent {
  final String userId;
  const LoadMoreFollowing(this.userId);
  @override
  List<Object?> get props => [userId];
}

class RefreshFollowers extends FollowEvent {
  final String userId;
  const RefreshFollowers(this.userId);
  @override
  List<Object?> get props => [userId];
}

class RefreshFollowing extends FollowEvent {
  final String userId;
  const RefreshFollowing(this.userId);
  @override
  List<Object?> get props => [userId];
}
