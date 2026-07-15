import 'package:equatable/equatable.dart';
import '../../domain/entities/profile.dart';
import '../../../home/domain/entities/feed_post.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;
  final List<FeedPost> posts;
  final int currentPostsPage;
  final bool hasReachedMaxPosts;
  final bool isMyProfile;

  const ProfileLoaded({
    required this.profile,
    required this.posts,
    required this.currentPostsPage,
    required this.hasReachedMaxPosts,
    required this.isMyProfile,
  });

  ProfileLoaded copyWith({
    Profile? profile,
    List<FeedPost>? posts,
    int? currentPostsPage,
    bool? hasReachedMaxPosts,
    bool? isMyProfile,
  }) {
    return ProfileLoaded(
      profile: profile ?? this.profile,
      posts: posts ?? this.posts,
      currentPostsPage: currentPostsPage ?? this.currentPostsPage,
      hasReachedMaxPosts: hasReachedMaxPosts ?? this.hasReachedMaxPosts,
      isMyProfile: isMyProfile ?? this.isMyProfile,
    );
  }

  @override
  List<Object?> get props => [
        profile,
        posts,
        currentPostsPage,
        hasReachedMaxPosts,
        isMyProfile,
      ];
}

class ProfileLoadingMorePosts extends ProfileLoaded {
  const ProfileLoadingMorePosts({
    required super.profile,
    required super.posts,
    required super.currentPostsPage,
    required super.hasReachedMaxPosts,
    required super.isMyProfile,
  });
}

class ProfileRefreshing extends ProfileLoaded {
  const ProfileRefreshing({
    required super.profile,
    required super.posts,
    required super.currentPostsPage,
    required super.hasReachedMaxPosts,
    required super.isMyProfile,
  });
}

class ProfileEmptyPosts extends ProfileLoaded {
  const ProfileEmptyPosts({
    required super.profile,
    required super.posts,
    required super.currentPostsPage,
    required super.hasReachedMaxPosts,
    required super.isMyProfile,
  });
}

class ProfileError extends ProfileState {
  final String message;
  const ProfileError(this.message);
  @override
  List<Object?> get props => [message];
}

class ProfileErrorLoadingMorePosts extends ProfileLoaded {
  final String message;
  const ProfileErrorLoadingMorePosts({
    required super.profile,
    required super.posts,
    required super.currentPostsPage,
    required super.hasReachedMaxPosts,
    required super.isMyProfile,
    required this.message,
  });
  @override
  List<Object?> get props => [...super.props, message];
}

class ProfileLogoutSuccess extends ProfileState {}
