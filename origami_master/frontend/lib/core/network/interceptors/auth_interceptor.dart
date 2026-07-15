import 'package:dio/dio.dart';
import '../../auth/token_manager.dart';
import '../../constants/api_constants.dart';

class AuthInterceptor extends Interceptor {
  final TokenManager _tokenManager;

  AuthInterceptor(this._tokenManager);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _tokenManager.getAccessToken();
    if (token != null && token.isNotEmpty) {
      options.headers[ApiConstants.authorization] = 'Bearer $token';
    }
    super.onRequest(options, handler);
  }
}
