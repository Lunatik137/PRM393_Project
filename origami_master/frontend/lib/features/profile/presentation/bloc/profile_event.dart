import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object?> get props => [];
}

class LoadMyProfile extends ProfileEvent {}

class LoadUserProfile extends ProfileEvent {
  final String userId;
  final bool isMyProfile;
  const LoadUserProfile(this.userId, {this.isMyProfile = false});
  @override
  List<Object?> get props => [userId, isMyProfile];
}

class RefreshProfile extends ProfileEvent {
  final String? userId;
  const RefreshProfile([this.userId]);
  @override
  List<Object?> get props => [userId];
}

class LoadUserPosts extends ProfileEvent {
  final String userId;
  const LoadUserPosts(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LoadMorePosts extends ProfileEvent {
  final String userId;
  const LoadMorePosts(this.userId);
  @override
  List<Object?> get props => [userId];
}

class RefreshPosts extends ProfileEvent {
  final String userId;
  const RefreshPosts(this.userId);
  @override
  List<Object?> get props => [userId];
}

class LogoutEvent extends ProfileEvent {}
