import 'package:injectable/injectable.dart';
import '../storage/secure_storage_service.dart';

@singleton
class TokenManager {
  final SecureStorageService _storageService;

  TokenManager(this._storageService);

  Future<String?> getAccessToken() async {
    return await _storageService.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _storageService.getRefreshToken();
  }

  Future<void> saveTokens({required String accessToken, required String refreshToken}) async {
    await _storageService.saveAccessToken(accessToken);
    await _storageService.saveRefreshToken(refreshToken);
  }

  Future<void> removeTokens() async {
    await _storageService.clearSession();
  }

  Future<bool> isAuthenticated() async {
    final token = await getAccessToken();
    return token != null && token.isNotEmpty;
  }
}
