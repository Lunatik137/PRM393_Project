abstract class AppException implements Exception {
  final String message;
  final String? code;
  final dynamic details;

  AppException(this.message, {this.code, this.details});

  @override
  String toString() => 'AppException: $message (code: $code)';
}

class NetworkException extends AppException {
  NetworkException(super.message);
}

class TimeoutException extends AppException {
  TimeoutException(super.message);
}

class UnauthorizedException extends AppException {
  UnauthorizedException(super.message);
}

class ForbiddenException extends AppException {
  ForbiddenException(super.message);
}

class ValidationException extends AppException {
  ValidationException(super.message, {super.details});
}

class ConflictException extends AppException {
  ConflictException(super.message);
}

class ServerException extends AppException {
  ServerException(super.message);
}

class UnknownException extends AppException {
  UnknownException(super.message);
}
