import 'package:dio/dio.dart';
import 'app_exception.dart';

class ExceptionMapper {
  static AppException map(dynamic error) {
    if (error is DioException) {
      switch (error.type) {
        case DioExceptionType.connectionTimeout:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
          return TimeoutException('Connection timed out');
        case DioExceptionType.badResponse:
          final statusCode = error.response?.statusCode;
          final message = error.response?.data?['message'] ?? 'Unknown error occurred';
          
          switch (statusCode) {
            case 400:
              return ValidationException(message, details: error.response?.data?['errors']);
            case 401:
              return UnauthorizedException(message);
            case 403:
              return ForbiddenException(message);
            case 404:
              return UnknownException('Resource not found');
            case 409:
              return ConflictException(message);
            case 422:
              return ValidationException(message, details: error.response?.data?['errors']);
            case 500:
            case 502:
            case 503:
              return ServerException('Server error occurred');
            default:
              return UnknownException(message);
          }
        case DioExceptionType.cancel:
          return UnknownException('Request cancelled');
        case DioExceptionType.connectionError:
          return NetworkException('No internet connection');
        default:
          return UnknownException('Lỗi: ${error.message ?? error.toString()}');
      }
    } else if (error is AppException) {
      return error;
    }
    
    return UnknownException(error.toString());
  }
}
