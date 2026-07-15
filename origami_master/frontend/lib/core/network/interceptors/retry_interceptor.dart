import 'package:dio/dio.dart';
import '../network_info.dart';

class RetryInterceptor extends Interceptor {
  final Dio _dio;
  final NetworkInfo _networkInfo;
  final int maxRetries;

  RetryInterceptor(this._dio, this._networkInfo, {this.maxRetries = 2});

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (_shouldRetry(err)) {
      int retries = err.requestOptions.extra['retries'] ?? 0;
      if (retries < maxRetries) {
        retries++;
        err.requestOptions.extra['retries'] = retries;
        
        try {
          final isConnected = await _networkInfo.isConnected;
          if (isConnected) {
            final response = await _dio.fetch(err.requestOptions);
            return handler.resolve(response);
          }
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    super.onError(err, handler);
  }

  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.connectionError) {
      return true;
    }
    
    if (err.response != null) {
      final statusCode = err.response!.statusCode;
      if (statusCode == 401 ||
          statusCode == 403 ||
          statusCode == 404 ||
          statusCode == 409 ||
          statusCode == 422) {
        return false;
      }
    }
    return false;
  }
}
