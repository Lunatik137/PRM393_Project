import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../dto/login_request_dto.dart';
import '../dto/login_response_dto.dart';
import '../dto/register_request_dto.dart';
import '../dto/refresh_token_request_dto.dart';
import '../dto/google_auth_request_dto.dart';

part 'auth_api.g.dart';

@RestApi()
abstract class AuthApi {
  factory AuthApi(Dio dio, {String baseUrl}) = _AuthApi;

  @POST('/auth/login')
  Future<LoginResponseDto> login(@Body() LoginRequestDto request);

  @POST('/auth/google')
  Future<LoginResponseDto> googleLogin(@Body() GoogleAuthRequestDto request);

  @POST('/auth/register')
  Future<void> register(@Body() RegisterRequestDto request);

  @POST('/auth/refresh')
  Future<LoginResponseDto> refreshToken(@Body() RefreshTokenRequestDto request);

  @POST('/auth/logout')
  Future<void> logout();
}

