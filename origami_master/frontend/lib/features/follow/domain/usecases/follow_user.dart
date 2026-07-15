import 'package:injectable/injectable.dart';
import '../repositories/follow_repository.dart';

@injectable
class FollowUserUseCase {
  final FollowRepository _repository;

  FollowUserUseCase(this._repository);

  Future<void> call(String userId) {
    return _repository.followUser(userId);
  }
}
