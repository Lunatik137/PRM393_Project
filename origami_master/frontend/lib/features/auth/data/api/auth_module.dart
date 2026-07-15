import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'auth_api.dart';

@module
abstract class AuthModule {
  @lazySingleton
  AuthApi getAuthApi(Dio dio) => AuthApi(dio);
}
