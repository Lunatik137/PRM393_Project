import 'package:equatable/equatable.dart';

class Profile extends Equatable {
  final String id;
  final String username;
  final String? displayName;
  final String? avatarUrl;
  final String? bio;
  final int followersCount;
  final int followingCount;
  final int completedFolds;
  final int publicCreations;
  final bool isFollowing;

  const Profile({
    required this.id,
    required this.username,
    this.displayName,
    this.avatarUrl,
    this.bio,
    required this.followersCount,
    required this.followingCount,
    required this.completedFolds,
    required this.publicCreations,
    required this.isFollowing,
  });

  Profile copyWith({
    String? id,
    String? username,
    String? displayName,
    String? avatarUrl,
    String? bio,
    int? followersCount,
    int? followingCount,
    int? completedFolds,
    int? publicCreations,
    bool? isFollowing,
  }) {
    return Profile(
      id: id ?? this.id,
      username: username ?? this.username,
      displayName: displayName ?? this.displayName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      bio: bio ?? this.bio,
      followersCount: followersCount ?? this.followersCount,
      followingCount: followingCount ?? this.followingCount,
      completedFolds: completedFolds ?? this.completedFolds,
      publicCreations: publicCreations ?? this.publicCreations,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [
        id,
        username,
        displayName,
        avatarUrl,
        bio,
        followersCount,
        followingCount,
        completedFolds,
        publicCreations,
        isFollowing,
      ];
}
