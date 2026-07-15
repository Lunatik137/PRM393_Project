import 'package:injectable/injectable.dart';
import '../api/profile_api.dart';
import '../dto/profile_response_dto.dart';
import '../dto/user_post_response_dto.dart';
import '../../../../core/network/pagination.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileResponseDto> getMyProfile();
  Future<ProfileResponseDto> getUserProfile(String userId);
  Future<Pagination<UserPostResponseDto>> getUserPosts(String userId, int page, int pageSize);
}

@LazySingleton(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApi _api;

  ProfileRemoteDataSourceImpl(this._api);

  @override
  Future<ProfileResponseDto> getMyProfile() async {
    return await _api.getMyProfile();
  }

  @override
  Future<ProfileResponseDto> getUserProfile(String userId) async {
    return await _api.getUserProfile(userId);
  }

  @override
  Future<Pagination<UserPostResponseDto>> getUserPosts(String userId, int page, int pageSize) async {
    return await _api.getUserPosts(userId, page: page, pageSize: pageSize);
  }
}

