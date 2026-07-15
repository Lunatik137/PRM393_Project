import 'package:injectable/injectable.dart';
import '../repositories/profile_repository.dart';
import '../entities/profile.dart';

@injectable
class GetProfileUseCase {
  final ProfileRepository _repository;

  GetProfileUseCase(this._repository);

  Future<Profile> getMyProfile() {
    return _repository.getMyProfile();
  }

  Future<Profile> getUserProfile(String userId) {
    return _repository.getUserProfile(userId);
  }
}
