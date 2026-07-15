import 'package:dio/dio.dart';
import 'dart:developer';
import 'package:flutter/foundation.dart';

class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      log('--> ${options.method.toUpperCase()} ${options.uri}');
      log('Headers: ${options.headers}');
      final body = options.data;
      if (body != null) {
        if (body is Map) {
          final safeBody = Map.of(body);
          safeBody.remove('password');
          log('Body: $safeBody');
        } else {
          log('Body: $body');
        }
      }
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      log('<-- ${response.statusCode} ${response.requestOptions.uri}');
      log('Response: ${response.data}');
    }
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      log('<-- Error ${err.message}');
      log('Response: ${err.response?.data}');
    }
    super.onError(err, handler);
  }
}
