import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../domain/usecases/login.dart';
import '../../domain/usecases/google_login.dart';
import '../../domain/usecases/register.dart';
import '../../domain/usecases/logout.dart';
import '../../domain/usecases/refresh_token.dart';
import '../../domain/usecases/check_session.dart';
import '../../../../core/network/exceptions/app_exception.dart';
import '../../../../core/network/exceptions/exception_mapper.dart';
import 'package:dio/dio.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _login;
  final GoogleLoginUseCase _googleLogin;
  final RegisterUseCase _register;
  final LogoutUseCase _logout;
  final RefreshTokenUseCase _refreshToken;
  final CheckSessionUseCase _checkSession;

  AuthBloc(
    this._login,
    this._googleLogin,
    this._register,
    this._logout,
    this._refreshToken,
    this._checkSession,
  ) : super(AuthInitial()) {
    on<LoginRequested>(_onLogin);
    on<GoogleLoginRequested>(_onGoogleLogin);
    on<RegisterRequested>(_onRegister);
    on<LogoutRequested>(_onLogout);
    on<CheckSessionRequested>(_onCheckSession);
    on<RefreshTokenRequested>(_onRefreshToken);
  }

  Future<void> _onLogin(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final session = await _login(event.email, event.password);
      emit(Authenticated(session));
    } on AppException catch (e) {
      emit(AuthError(e.message));
    } on DioException catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    } catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    }
  }

  Future<void> _onGoogleLogin(GoogleLoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final session = await _googleLogin(event.idToken);
      emit(Authenticated(session));
    } on AppException catch (e) {
      emit(AuthError(e.message));
    } on DioException catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    } catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    }
  }

  Future<void> _onRegister(RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await _register(
        username: event.username,
        email: event.email,
        password: event.password,
        confirmPassword: event.confirmPassword,
      );
      emit(RegisterSuccess());
    } on AppException catch (e) {
      emit(AuthError(e.message));
    } on DioException catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    } catch (e) {
      final appError = ExceptionMapper.map(e);
      emit(AuthError(appError.message));
    }
  }

  Future<void> _onLogout(LogoutRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await _logout();
    emit(Unauthenticated());
  }

  Future<void> _onCheckSession(CheckSessionRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final session = await _checkSession();
      if (session != null) {
        emit(Authenticated(session));
      } else {
        // If session is invalid (e.g. JWT expired), try to refresh token
        final newSession = await _refreshToken();
        emit(Authenticated(newSession));
      }
    } catch (e) {
      emit(Unauthenticated());
    }
  }

  Future<void> _onRefreshToken(RefreshTokenRequested event, Emitter<AuthState> emit) async {
    try {
      final session = await _refreshToken();
      emit(Authenticated(session));
    } catch (e) {
      emit(Unauthenticated());
    }
  }
}

