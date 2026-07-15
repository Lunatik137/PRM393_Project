import 'package:injectable/injectable.dart';
import '../api/auth_api.dart';
import '../dto/login_request_dto.dart';
import '../dto/login_response_dto.dart';
import '../dto/register_request_dto.dart';
import '../dto/refresh_token_request_dto.dart';
import '../dto/google_auth_request_dto.dart';

abstract class AuthRemoteDataSource {
  Future<LoginResponseDto> login(LoginRequestDto request);
  Future<LoginResponseDto> googleLogin(GoogleAuthRequestDto request);
  Future<void> register(RegisterRequestDto request);
  Future<LoginResponseDto> refreshToken(RefreshTokenRequestDto request);
  Future<void> logout();
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final AuthApi _api;

  AuthRemoteDataSourceImpl(this._api);

  @override
  Future<LoginResponseDto> login(LoginRequestDto request) async {
    return await _api.login(request);
  }

  @override
  Future<LoginResponseDto> googleLogin(GoogleAuthRequestDto request) async {
    return await _api.googleLogin(request);
  }

  @override
  Future<void> register(RegisterRequestDto request) async {
    await _api.register(request);
  }

  @override
  Future<LoginResponseDto> refreshToken(RefreshTokenRequestDto request) async {
    return await _api.refreshToken(request);
  }

  @override
  Future<void> logout() async {
    await _api.logout();
  }
}

