import 'package:injectable/injectable.dart';
import '../repositories/follow_repository.dart';
import '../entities/follow_user.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetFollowingUseCase {
  final FollowRepository _repository;

  GetFollowingUseCase(this._repository);

  Future<Pagination<FollowUser>> call(String userId, int page, int pageSize) {
    return _repository.getFollowing(userId, page, pageSize);
  }
}
