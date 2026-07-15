import 'package:injectable/injectable.dart';
import '../repositories/follow_repository.dart';
import '../entities/follow_user.dart';
import '../../../../core/network/pagination.dart';

@injectable
class GetFollowersUseCase {
  final FollowRepository _repository;

  GetFollowersUseCase(this._repository);

  Future<Pagination<FollowUser>> call(String userId, int page, int pageSize) {
    return _repository.getFollowers(userId, page, pageSize);
  }
}
