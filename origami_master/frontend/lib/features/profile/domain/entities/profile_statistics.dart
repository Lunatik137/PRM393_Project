import 'package:equatable/equatable.dart';

class ProfileStatistics extends Equatable {
  final int completedFolds;
  final int publicCreations;
  final int followersCount;
  final int followingCount;

  const ProfileStatistics({
    required this.completedFolds,
    required this.publicCreations,
    required this.followersCount,
    required this.followingCount,
  });

  @override
  List<Object?> get props => [
        completedFolds,
        publicCreations,
        followersCount,
        followingCount,
      ];
}
