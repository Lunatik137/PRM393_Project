import 'package:equatable/equatable.dart';

class FollowUser extends Equatable {
  final String id;
  final String username;
  final String? avatarUrl;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final bool isFollowing;

  const FollowUser({
    required this.id,
    required this.username,
    this.avatarUrl,
    this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.isFollowing,
  });

  FollowUser copyWith({
    String? id,
    String? username,
    String? avatarUrl,
    String? bio,
    int? followersCount,
    int? followingCount,
    bool? isFollowing,
  }) {
    return FollowUser(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        avatarUrl,
        bio,
        followersCount,
        followingCount,
        isFollowing,
      ];
}
