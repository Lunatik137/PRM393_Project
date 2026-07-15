import 'package:injectable/injectable.dart';
import '../entities/share_link.dart';
import '../repositories/share_repository.dart';

@injectable
class GetSharedLinksUseCase {
  final ShareRepository _repository;

  GetSharedLinksUseCase(this._repository);

  Future<List<ShareLink>> call() {
    return _repository.getShareLinks();
  }
}
