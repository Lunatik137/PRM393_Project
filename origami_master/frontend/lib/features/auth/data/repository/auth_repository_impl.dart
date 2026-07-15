import 'dart:convert';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/user.dart';
import '../datasource/auth_remote_datasource.dart';
import '../mapper/auth_mapper.dart';
import '../dto/login_request_dto.dart';
import '../dto/register_request_dto.dart';
import '../dto/refresh_token_request_dto.dart';
import '../dto/google_auth_request_dto.dart';
import '../../../../core/auth/token_manager.dart';
import '../../../../core/network/exceptions/app_exception.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remoteDataSource;
  final TokenManager _tokenManager;

  AuthRepositoryImpl(this._remoteDataSource, this._tokenManager);

  @override
  Future<AuthSession> login({required String email, required String password}) async {
    final dto = await _remoteDataSource.login(LoginRequestDto(email: email, password: password));
    await _tokenManager.saveTokens(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    return AuthMapper.mapSession(dto);
  }

  @override
  Future<AuthSession> googleLogin({required String idToken}) async {
    final dto = await _remoteDataSource.googleLogin(GoogleAuthRequestDto(idToken: idToken));
    await _tokenManager.saveTokens(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    return AuthMapper.mapSession(dto);
  }

  @override
  Future<void> register({
    required String username,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    await _remoteDataSource.register(RegisterRequestDto(
      username: username,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
    ));
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } catch (_) {
      // Ignore errors on logout
    } finally {
      await _tokenManager.removeTokens();
    }
  }

  @override
  Future<AuthSession> refresh() async {
    final refreshToken = await _tokenManager.getRefreshToken();
    if (refreshToken == null || refreshToken.isEmpty) {
      throw UnauthorizedException('No refresh token found');
    }

    final dto = await _remoteDataSource.refreshToken(RefreshTokenRequestDto(refreshToken: refreshToken));
    await _tokenManager.saveTokens(accessToken: dto.accessToken, refreshToken: dto.refreshToken);
    return AuthMapper.mapSession(dto);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await _tokenManager.isAuthenticated();
  }

  @override
  Future<AuthSession?> getValidSession() async {
    final token = await _tokenManager.getAccessToken();
    final refresh = await _tokenManager.getRefreshToken();
    if (token == null || refresh == null) return null;

    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;
      
      String payload = parts[1];
      while (payload.length % 4 != 0) {
        payload += '=';
      }
      
      final String decoded = utf8.decode(base64Url.decode(payload));
      final Map<String, dynamic> json = jsonDecode(decoded);
      
      final exp = json['exp'];
      if (exp != null) {
        final now = DateTime.now().millisecondsSinceEpoch / 1000;
        if (now > (exp - 60)) {
          return null; // Expired or close to expire
        }
      }

      final id = json['sub']?.toString() ?? '';
      final email = json['email']?.toString() ?? '';
      final username = json['username']?.toString() ?? email.split('@').first;

      return AuthSession(
        accessToken: token,
        refreshToken: refresh,
        user: User(id: id, username: username, email: email),
      );
    } catch (e) {
      return null;
    }
  }
}
