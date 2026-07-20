import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../config/app_config.dart';
import '../constants/api_constants.dart';
import '../auth/token_manager.dart';
import 'network_info.dart';
import 'interceptors/auth_interceptor.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/error_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

@module
abstract class DioModule {
  @lazySingleton
  Dio getDio(
    TokenManager tokenManager,
    NetworkInfo networkInfo,
  ) {
    final dio = Dio(
      BaseOptions(
        baseUrl: AppConfig.baseUrl,
        connectTimeout: const Duration(milliseconds: AppConfig.connectTimeout),
        receiveTimeout: const Duration(milliseconds: AppConfig.receiveTimeout),
        headers: {
          ApiConstants.accept: ApiConstants.applicationJson,
          ApiConstants.contentType: ApiConstants.applicationJson,
          'ngrok-skip-browser-warning': 'true',
        },
      ),
    );

    dio.interceptors.addAll([
      AuthInterceptor(tokenManager),
      LoggingInterceptor(),
      ErrorInterceptor(),
      RetryInterceptor(dio, networkInfo),
    ]);

    return dio;
  }
}
