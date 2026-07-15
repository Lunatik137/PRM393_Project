import 'package:injectable/injectable.dart';
import '../repositories/follow_repository.dart';

@injectable
class UnfollowUserUseCase {
  final FollowRepository _repository;

  UnfollowUserUseCase(this._repository);

  Future<void> call(String userId) {
    return _repository.unfollowUser(userId);
  }
}
